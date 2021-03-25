Shader "Custom/Pyramid "
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
        Tags { "RenderType"="Opaque" "Queue"="Transparent"}
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            //#pragma multi_compile_fog

            //#pragma surface surf Lambert alpha

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

            float rand(vec2 p){
                return mix(.2, .7, Hash21(p));
            }

            vec3 palette(float d){
                return mix(vec3(0.2,0.7,0.9),vec3(1.,0.,1.),d);
            }

            vec2 rotate(vec2 p,float a){
                float c = cos(a);
                float s = sin(a);
                return mul(p,mat2(c,s,-s,c));
            }

            float map(vec3 p){
                for( int i = 0; i<8; ++i){
                    float t = iTime*0.2;
                    p.xz =rotate(p.xz,t);
                    p.xy =rotate(p.xy,t*1.89);
                    p.xz = abs(p.xz);
                    p.xz-=.5;
                }
                return dot(sign(p),p)/5.;
            }

            vec4 rm (vec3 ro, vec3 rd){
                float t = 0.;
                vec3 col = 0;
                float d;
                for(float i =0.; i<64.; i++){
                    vec3 p = ro + rd*t;
                    d = map(p)*.5;
                    if(d<0.02){
                        break;
                    }
                    if(d>100.){
                        break;
                    }
                    //col+=vec3(0.6,0.8,0.8)/(400.*(d));
                    col+=palette(length(p)*.1)/(400.*(d));
                    t+=d;
                }
                return vec4(col,1./(d*100.));
            }
            void mainImage( out vec4 fragColor, in vec2 fragCoord )
            {
                
            }

            /** SHADERDATA
            {
                "title": "fractal pyramid",
                "description": "",
                "model": "car"
            }
            */

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


                uv = (fragCoord-(iResolution.xy/2.))/iResolution.x;
                vec3 ro = vec3(0.,0.,-50.);
                ro.xz = rotate(ro.xz,iTime * _Speed);
                vec3 cf = normalize(-ro);
                vec3 cs = normalize(cross(cf,vec3(0.,1.,0.)));
                vec3 cu = normalize(cross(cf,cs));
                
                vec3 uuv = ro+cf*3. + uv.x*cs + uv.y*cu;
                
                vec3 rd = normalize(uuv-ro);
                
                vec4 col = rm(ro,rd);
                
                
                fragColor = col;

                return vec4(fragColor.x, fragColor.y, fragColor.z, 0.1);
                
                return fragColor * _Color1 + _Color2;
            }

            ENDCG
        }
    }
}
