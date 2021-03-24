Shader "Custom/Wire"
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

            // Created by David Gallardo - xjorma/2019
            // License Creative Commons Attribution-NonCommercial-ShareAlike 3.0

            #define AA

            float sdSphere( in vec3 p, in float r )
            {
                return length(p)-r;
            }

            const float k = 8.;

            float map(in vec3 pos)
            {
                // MetaBall
                float r = 0.5;
                vec3  d = vec3(0.2,0.7,0.2);
                float h = -cos(iTime/8.)*5.;
                float sminAcc = 0.;
                
                //sminAcc += exp2(-k *sdSphere( pos - d*vec3(sin(iTime/2.0+0.2),sin(iTime/2.1+0.4) + h,sin(iTime/2.3+0.7)), r ));
                //sminAcc += exp2(-k *sdSphere( pos - d*vec3(sin(iTime/2.4+1.3),sin(iTime/1.9+0.5) + h,sin(iTime/2.5+0.2)), r ));
                //sminAcc += exp2(-k *sdSphere( pos - d*vec3(sin(iTime/2.9+2.3),sin(iTime/3.0+0.3) + h,sin(iTime/2.6+0.8)), r ));
                //sminAcc += exp2(-k *sdSphere( pos - d*vec3(sin(iTime/2.2+2.9),sin(iTime/2.8+0.8) + h,sin(iTime/1.8+0.9)), r ));
                
                // Grids
                sminAcc += exp2(-k * (2. - abs(pos.y)));

                return -log2( sminAcc )/k;
            }


            vec3 calcNormal(vec3 pos)
            {
                vec2	eps	= vec2(0.0001,0);
                float	d	= map(pos);
                return	normalize(vec3(map(pos+eps.xyy)-d,map(pos+eps.yxy)-d,map(pos+eps.yyx)-d));
            }

            vec3 applyFog(vec3 rgb,float distance, vec3 fogColor)
            {
                float fogAmount = 1.0 - exp( -distance*0.3 );
                return mix( rgb, fogColor, fogAmount );
            }

            mat3 setCamera( in vec3 ro, in vec3 ta )
            {
                vec3 cw = normalize(ta-ro);
                vec3 up = vec3(0, 1, 0);
                vec3 cu = normalize( cross(cw,up) );
                vec3 cv = normalize( cross(cu,cw) );
                return mat3( cu, cv, cw );
            }

            vec3 lavaLamp(vec3 ro,vec3 rd,vec3 cd,float dist)
            {
                float t = 1.0;
                float d;
                for( int i=0; i<64; i++ )
                {
                    vec3	p = ro + t*rd;
                    float	h = map(p);
                    t += h;
                    d = dot(t*rd,cd);
                    if( abs(h)<0.001 || d>dist ) break;
                }

                vec3 col = 0.0;

                if( d<dist )
                {
                    vec3 pos = ro + t*rd;
                    vec3 nor = calcNormal(pos);

                    pos *= 3.;
                    pos.z += iTime*0.4;

                    vec3 proj = abs(fract(pos) - 0.5);
                    proj = smoothstep(0.1, 0., proj);
                    #if 0
                        col = vec3(dot(proj, smoothstep(0.1, 0.9, vec3(1) - abs(nor))));
                    #else
                        col = proj * smoothstep(0.1, 0.9, vec3(1,1,1) - abs(nor));
                        col = vec3(max(max(col.x, col.y), col.z), max(max(col.x, col.y), col.z), max(max(col.x, col.y), col.z));
                    #endif
                    col*= vec3(.5, 1., 0.3);
                    col = applyFog(col, d, vec3(0,0,0));
                }
                return col;
            }

            void mainVR( out vec4 fragColor, in vec2 fragCoord, in vec3 ro, in vec3 rd )
            {
                fragColor = vec4(lavaLamp(ro/3. + vec3(0.0,.0,4.0),rd ,rd,14.) ,1);
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


                vec3 tot = 0.0;
                    
            #ifdef AA
                vec2 rook[4];
                rook[0] = vec2( 1./8., 3./8.);
                rook[1] = vec2( 3./8.,-1./8.);
                rook[2] = vec2(-1./8.,-3./8.);
                rook[3] = vec2(-3./8., 1./8.);
                for( int n=0; n<4; ++n )
                {
                    // pixel coordinates
                    vec2 o = rook[n];
                    vec2 p = (-iResolution.xy + 2.0*(fragCoord+o))/iResolution.y;
            #else //AA
                    vec2 p = (-iResolution.xy + 2.0*fragCoord)/iResolution.y;
            #endif //AA
            
                    // camera	
                    vec3 ro = 4.*vec3( sin(0), 0.2 , cos(0) );
                    //vec3 ro = vec3(0.0,.0,4.0);
                    vec3 ta = 0;
                    // camera-to-world transformation
                    mat3 ca = setCamera( ro, ta );
                    //vec3 cd = ca[2];    
                    
                    vec3 rd =  mul(ca,normalize(vec3(p,1.0)));
                    
                    vec3 col = lavaLamp(ro ,rd ,ca[2],7.);

                    tot += col;
            #ifdef AA
                }
                tot /= 4.;
            #endif
                
                //tot = pow(tot, vec3(1. / 2.2));

                fragColor = vec4( tot, 1.0 );

                return fragColor;
            }

            ENDCG
        }
    }
}
