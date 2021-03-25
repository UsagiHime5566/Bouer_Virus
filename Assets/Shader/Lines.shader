Shader "Custom/Lines"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        iChannel0("iChannel0", 2D) = "white" {}
        _Speed ("Speed", Float) = 1.0
        _Color1 ("Color1", Color) = (0.5, 0.5, 0.5, 1)
        _Color2 ("Color2", Color) = (0.67, 0.85, 0.8, 1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            sampler2D iChannel0;
            float _Speed;
            float4  _Color1;
            float4  _Color2;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }
            #define ivec2 int2
            #define ivec3 int3
            #define ivec4 int4
            #define vec2 float2
            #define vec3 float3
            #define vec4 float4
            #define svec2(x) float2(x,x)
            #define svec3(x) float3(x,x,x)
            #define svec4(x) float4(x,x,x,x)

            #define mat2 float2x2
            #define mat3 float3x3
            #define mat4 float4x4
            #define iTime _Time.y
            // fmod用於求余數，比如fmod(1.5, 1.0) 返回0.5；
            #define mod fmod
            // 插值運算，lerp(a,b,w) return a + w*(a-b);
            #define mix lerp
            // fract(x): 取小數部分 
            #define fract frac
            #define atan atan2
            #define texture2D tex2D

            #define _fixed2(x) fixed2(x,x)
            #define _fixed3(x) fixed3(x,x,x)
            #define _fixed4(x) fixed4(x,x,x,x)



            float Hash21(vec2 p){
                p = fract(p*vec2(123.34,456.21));
                p += dot(p, p+45.32);
                return fract(p.x*p.y);
            }

            #define PI 3.141592653589793
            float PHI=1.61803398874989484820459;// Φ = Golden Ratio

            float random(in vec2 xy,in float seed){
                float f=length(fract((cross((cross(fract(xy.yxy*PHI*seed)+seed,fract(xy.xyx/seed)+seed)*PHI),vec3(5./PHI,7./PHI,3./PHI)))));
                return fract(f*seed);
            }

            float noise(vec2 st){
                vec2 st0=floor(st);
                vec2 st1=.5-cos((st-st0)*PI)*.5;
                float a0=random(vec2(int(st0.x),int(st0.y)),1.);
                float a1=random(vec2(int(st0.x)+1,int(st0.y)),1.);
                
                float a2=random(vec2(int(st0.x),int(st0.y)+1),1.);
                float a3=random(vec2(int(st0.x)+1,int(st0.y)+1),1.);
                
                float b0=(a1-a0)*st1.x+a0;
                
                float b1=(a3-a2)*st1.x+a2;
                return(b1-b0)*st1.y+b0;
            }

            float LineHeight(vec2 uv){
                return noise(uv);
            }
            #define lines 20.
            #define height 0.5
            #define edges 0.1
            #define horizontalEdges 0.05

            bool HitsLines(vec2 uv,float vOffset){
                if(uv.x < horizontalEdges || uv.x > 1.-horizontalEdges)
                    return false;
                uv.x = uv.x * (1.-horizontalEdges*2.) + horizontalEdges;
                for(float i=lines;i >= 0.;i--){
                    vec2 nuv = uv + vec2(0,((i + 0.5)/(lines)-1.) * (1.-edges*2.) - edges);
                    vec2 check = vec2(uv.x* 20. + iTime * (abs(lines/2.-i) * -0.25 + 1.125),i * 10.);
                    float h = (LineHeight(check + vec2(0,vOffset))-0.5) * height * (1.-pow(abs(2.*(uv.x - 0.5)) + 0.15,0.25));
                    if(h > nuv.y)
                        return false;
                    if(h < nuv.y && h > nuv.y - 0.004)
                        return true;
                }
                return false;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                //step1. uv 改為 i.uv , 因為貼圖一定是 1 x 1 矩形, 不必像GLSH一樣局限於瀏覽器長寬
                //step2. iGlobalTime 改為 _Time.y
                //step3. mod 改 fmod  or  #define mod(x,y) (x-y*floor(x/y))
                //step4. mix 改 lerp
                //step5. fract 改 frac
                //step6. mat2 矩陣 改為 fixed2x2
                //step7. 矩陣運算 a*b 須改為 mul(a,b)  , 通常發生此問題的編譯錯誤都是 "type mismatch"
                //int2 轉換為 float2  ->  (float2)int2
                //fragCoord.xy -> gl_FragCoord.xy
                //fragColor -> gl_FragColor
                fixed2 uv = i.uv; uv = 2.0 * uv - 1.0;
                fixed4 fragColor;
                fixed2 fragCoord = i.uv * 400;
                fixed2 iResolution = fixed2(400, 400);


                float r = (HitsLines(fragCoord/iResolution.xy, 0.25))?0.5:0.;
                float g = (HitsLines(fragCoord/iResolution.xy, -0.25))?0.5:0.;
                float b = (HitsLines(fragCoord/iResolution.xy, -0.5))?0.5:0.;
                fragColor=(HitsLines(fragCoord/iResolution.xy,0.))?vec4(1,1,1,1):vec4(r,g,b,1);

                return fragColor;
            }

            ENDCG
        }
    }
}
