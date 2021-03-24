Shader "Custom/StarBG"
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



            #define NUM_LAYERS 5.

            float2x2 Rot(float a){
                float s=sin(a), c=cos(a);
                return float2x2(c,-s,s,c);
            }

            float Star(vec2 uv, float flare){
                float d = length(uv);//distance to the center 
                float m = .03/d;//more light like than smoothstep(.1,.05,d);
                
                float rays= max(0.,1.-abs(uv.x*uv.y*1000.)); 
                m +=rays*flare;
                
                uv = mul(Rot(3.1415/4.), uv);
                rays= max(0.,1.-abs(uv.x*uv.y*1000.));
                m+=rays*.5*flare;
                m*=smoothstep(.5,.2,d);
                
                return m;


            }

            float Hash21(vec2 p){
                p = fract(p*vec2(123.34,456.21));
                p += dot(p, p+45.32);
                return fract(p.x*p.y);
                

            }

            vec3 StarLayer(vec2 uv) {
                vec3 col = 0;
                
                vec2 gv = fract(uv)-.5;
                vec2 id = floor(uv);
                
                // should add <=
                for(int y=-1;y<=1;y++) {
                    for(int x=-1;x<=1;x++) {
                        vec2 offs = vec2(x, y);
                        
                        float n = Hash21(id+offs); // random between 0 and 1
                        float size = fract(n*345.32);
                        
                        float star = Star(gv-offs-vec2(n, fract(n*34.))+.5, smoothstep(.6, 1., size)*.6);
                        
                        vec3 color = sin(vec3(.5, .1, .9)*fract(n*2345.2)*123.2)*.5+.5;
                        color = color*vec3(1,.2,.8+size)+vec3(.2, .2, .1)*2.;
                        
                        star *= sin(iTime*2.+n*6.2831)*.5+1.;
                        col += star*size*color;
                    }
                }
                return col;
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


                uv = (fragCoord-.5*iResolution.xy)/iResolution.y;
                //vec2 M = (iMouse.xy-.5*iResolution.xy)/iResolution.y;
                
                float t = iTime*.03 * _Speed;
                
                uv = mul(Rot(t), uv);
                uv.x+=max(t*.0001,1.);
                uv.y-=max(t*.0001,.5);

                vec3 col = 0;
                
                for (float i =0.; i <1.;i+=1./NUM_LAYERS){

                    float depth = fract(i+t);
                    float scale = mix (50.,2.,depth);
                    float fade = depth*smoothstep(1., .9, depth);
                    col += StarLayer(uv*scale+i*4532.)*fade;

                }
                
                col = pow(col, vec3(.85,.85,.85));	// gamma correction
                
                
                //if(gv.x>.48|| gv.y>.48) col.r=1.;//coloring the grid
                
                //col+=Hash21(id);
                float cmx = 0;
                cmx = max(cmx, col.x);
                cmx = max(cmx, col.y);
                cmx = max(cmx, col.z);
                float dif = 1 - cmx;
                col = vec3(col.x + dif, col.y + dif, col.z + dif);
                //col += 1;
                fragColor = vec4(col,1.0) * _Color1;

                return fragColor;
            }

            ENDCG
        }
    }
}
