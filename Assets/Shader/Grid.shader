Shader "Custom/Grid"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        iChannel0("iChannel0", 2D) = "white" {}
        _Speed ("Speed", Float) = 1.0
        _Color1 ("Color1", Color) = (0.5, 0.5, 0.5, 1)
        _Color2 ("Color2", Color) = (0.67, 0.85, 0.8, 1)
        _Size ("Size", Float) = 1
        _Shift ("Shift", Range (0,1.0)) = 0.5
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
            float _Size;
            float _Shift;
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

            float grid(vec2 uv, float battery)
            {
                vec2 size = vec2(uv.y, uv.y * uv.y * 0.2) * 0.01;
                uv += vec2(0.0, iTime * _Speed * (battery + 0.05));
                uv = abs(fract(uv + _Shift) - 0.5);
                vec2 lines = smoothstep(size, vec2(0.0, 0), uv);
                lines += smoothstep(size * 5.0, vec2(0.0, 0), uv) * 0.4 * battery;
                return clamp(lines.x + lines.y, 0.0, 3.0);
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


                uv = (2.0 * fragCoord.xy - iResolution.xy)/iResolution.y;
                float battery = 1.0;

                {
                    // Grid
                    float fog = smoothstep(0.1, -0.02, abs(uv.y + 0.2));
                    vec3 col = vec3(0.0, 0.0, 0.0);
                    if (uv.y < -0.28)
                    {
                        uv.y = 4 / (abs(uv.y + 0.2) + 0.05);
                        uv.y *= _Size;
                        uv.x *= uv.y * 1;
                        float gridVal = grid(uv, battery);
                        col = mix(col, vec3(1.0, 0.5, 1.0), gridVal);
                    }

                    //col += fog * fog * fog;
                    fog = uv.y * 0.1;
                    col = max(0, col - fog);
                    //col = mix(vec3(col.r, col.r, col.r) * 0.5, col, battery * 0.7);

                    fragColor = vec4(col, 1.0) * _Color1 + _Color2;
                }

                return fragColor;
            }

            ENDCG
        }
    }
}
