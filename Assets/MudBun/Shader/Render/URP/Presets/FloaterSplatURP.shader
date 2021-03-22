// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MudBun/Floater Splat (URP)"
{
	Properties
	{
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[HideInInspector] _EmissionColor("Emission Color", Color) = (1,1,1,1)
		[HideInInspector]_Color("Color", Color) = (1,1,1,1)
		[HideInInspector]_Emission("Emission", Color) = (1,1,1,1)
		[HideInInspector]_Metallic("Metallic", Range( 0 , 1)) = 0
		[HideInInspector]_Smoothness("Smoothness", Range( 0 , 1)) = 1
		[HideInInspector]_IsSplatRenderMaterial("Is Splat Render Material", Float) = 1
		[ASEBegin]_Frequency("Frequency", Range( 0 , 1)) = 0.1
		_OffsetAmount("Offset Amount", Float) = 0.01
		_MainTex("Albedo", 2D) = "white" {}
		_AlphaCutoutThreshold("Alpha Cutout Threshold", Range( 0 , 1)) = 0
		_DitherTexture("Dither Texture", 2D) = "white" {}
		_Dithering("Dithering", Range( 0 , 1)) = 1
		_DitherTextureSize("Dither Texture Size", Int) = 256
		[ASEEnd][Toggle]_RandomDither("Random Dither", Range( 0 , 1)) = 0

		//_TransmissionShadow( "Transmission Shadow", Range( 0, 1 ) ) = 0.5
		//_TransStrength( "Trans Strength", Range( 0, 50 ) ) = 1
		//_TransNormal( "Trans Normal Distortion", Range( 0, 1 ) ) = 0.5
		//_TransScattering( "Trans Scattering", Range( 1, 50 ) ) = 2
		//_TransDirect( "Trans Direct", Range( 0, 1 ) ) = 0.9
		//_TransAmbient( "Trans Ambient", Range( 0, 1 ) ) = 0.1
		//_TransShadow( "Trans Shadow", Range( 0, 1 ) ) = 0.5
		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25
	}

	SubShader
	{
		LOD 0

		

		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
		Cull Back
		AlphaToMask Off
		HLSLINCLUDE
		#pragma target 4.0

		float4 FixedTess( float tessValue )
		{
			return tessValue;
		}
		
		float CalcDistanceTessFactor (float4 vertex, float minDist, float maxDist, float tess, float4x4 o2w, float3 cameraPos )
		{
			float3 wpos = mul(o2w,vertex).xyz;
			float dist = distance (wpos, cameraPos);
			float f = clamp(1.0 - (dist - minDist) / (maxDist - minDist), 0.01, 1.0) * tess;
			return f;
		}

		float4 CalcTriEdgeTessFactors (float3 triVertexFactors)
		{
			float4 tess;
			tess.x = 0.5 * (triVertexFactors.y + triVertexFactors.z);
			tess.y = 0.5 * (triVertexFactors.x + triVertexFactors.z);
			tess.z = 0.5 * (triVertexFactors.x + triVertexFactors.y);
			tess.w = (triVertexFactors.x + triVertexFactors.y + triVertexFactors.z) / 3.0f;
			return tess;
		}

		float CalcEdgeTessFactor (float3 wpos0, float3 wpos1, float edgeLen, float3 cameraPos, float4 scParams )
		{
			float dist = distance (0.5 * (wpos0+wpos1), cameraPos);
			float len = distance(wpos0, wpos1);
			float f = max(len * scParams.y / (edgeLen * dist), 1.0);
			return f;
		}

		float DistanceFromPlane (float3 pos, float4 plane)
		{
			float d = dot (float4(pos,1.0f), plane);
			return d;
		}

		bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
		{
			float4 planeTest;
			planeTest.x = (( DistanceFromPlane(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.y = (( DistanceFromPlane(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.z = (( DistanceFromPlane(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.w = (( DistanceFromPlane(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
			return !all (planeTest);
		}

		float4 DistanceBasedTess( float4 v0, float4 v1, float4 v2, float tess, float minDist, float maxDist, float4x4 o2w, float3 cameraPos )
		{
			float3 f;
			f.x = CalcDistanceTessFactor (v0,minDist,maxDist,tess,o2w,cameraPos);
			f.y = CalcDistanceTessFactor (v1,minDist,maxDist,tess,o2w,cameraPos);
			f.z = CalcDistanceTessFactor (v2,minDist,maxDist,tess,o2w,cameraPos);

			return CalcTriEdgeTessFactors (f);
		}

		float4 EdgeLengthBasedTess( float4 v0, float4 v1, float4 v2, float edgeLength, float4x4 o2w, float3 cameraPos, float4 scParams )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;
			tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
			tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
			tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
			tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			return tess;
		}

		float4 EdgeLengthBasedTessCull( float4 v0, float4 v1, float4 v2, float edgeLength, float maxDisplacement, float4x4 o2w, float3 cameraPos, float4 scParams, float4 planes[6] )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;

			if (WorldViewFrustumCull(pos0, pos1, pos2, maxDisplacement, planes))
			{
				tess = 0.0f;
			}
			else
			{
				tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
				tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
				tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
				tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			}
			return tess;
		}
		ENDHLSL

		
		Pass
		{
			
			Name "Forward"
			Tags { "LightMode"="UniversalForward" }
			
			Blend One Zero, One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA
			

			HLSLPROGRAM
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define _EMISSION
			#define _ALPHATEST_ON 1
			#define ASE_SRP_VERSION 70301

			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x

			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS
			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
			#pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
			#pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
			#pragma multi_compile _ _SHADOWS_SOFT
			#pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
			
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ LIGHTMAP_ON

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS_FORWARD

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/UnityInstancing.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			
			#if ASE_SRP_VERSION <= 70108
			#define REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR
			#endif

			#if defined(UNITY_INSTANCING_ENABLED) && defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL)
			    #define ENABLE_TERRAIN_PERPIXEL_NORMAL
			#endif

			#define SHADER_GRAPH
			#pragma multi_compile _ MUDBUN_PROCEDURAL
			#pragma multi_compile _ MUDBUN_QUAD_SPLATS
			#include "Assets/MudBun/Shader/Render/ShaderCommon.cginc"
			#include "Assets/MudBun/Shader/Render/SplatCommon.cginc"


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord : TEXCOORD0;
				uint ase_vertexID : SV_VertexID;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				float4 lightmapUVOrVertexSH : TEXCOORD0;
				half4 fogFactorAndVertexLight : TEXCOORD1;
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
				float4 shadowCoord : TEXCOORD2;
				#endif
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
				float4 screenPos : TEXCOORD6;
				#endif
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_texcoord9 : TEXCOORD9;
				float4 ase_texcoord10 : TEXCOORD10;
				float4 ase_texcoord11 : TEXCOORD11;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float _Frequency;
			float _OffsetAmount;
			float _IsSplatRenderMaterial;
			int _DitherTextureSize;
			float _RandomDither;
			float _AlphaCutoutThreshold;
			float _Dithering;
			#ifdef _TRANSMISSION_ASE
				float _TransmissionShadow;
			#endif
			#ifdef _TRANSLUCENCY_ASE
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _MainTex;
			sampler2D _DitherTexture;


			float3 MudBunSplatPoint( int VertexID, out float3 PositionLs, out float3 NormalWs, out float3 NormalLs, out float3 TangentWs, out float3 TangentLs, out float3 CenterWs, out float3 CenterLs, out float4 Color, out float4 EmissionHash, out float Metallic, out float Smoothness, out float2 Tex, out float4 TextureWeight, out float SdfValue, out float3 Outward2dNormalLs, out float3 Outward2dNormalWs )
			{
				float4 positionWs;
				float2 metallicSmoothness;
				mudbun_splat_vert(VertexID, positionWs, PositionLs, NormalWs, NormalLs, TangentWs, TangentLs, CenterWs, CenterLs, Color, EmissionHash, metallicSmoothness, Tex, TextureWeight, SdfValue, Outward2dNormalLs, Outward2dNormalWs);
				Metallic = metallicSmoothness.x;
				Smoothness = metallicSmoothness.y;
				return positionWs.xyz;
			}
			
			float3 SimplexNoiseGradient6_g279( float3 Position, float Size )
			{
				#ifdef MUDBUN_VALID
				return snoise_grad(Position / max(1e-6, Size)).xyz;
				#else
				return Position;
				#endif
			}
			
			float3 SimplexNoiseGradient6_g280( float3 Position, float Size )
			{
				#ifdef MUDBUN_VALID
				return snoise_grad(Position / max(1e-6, Size)).xyz;
				#else
				return Position;
				#endif
			}
			

			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				int VertexID5_g25 = v.ase_vertexID;
				float3 PositionLs5_g25 = float3( 0,0,0 );
				float3 NormalWs5_g25 = float3( 0,0,0 );
				float3 NormalLs5_g25 = float3( 0,0,0 );
				float3 TangentWs5_g25 = float3( 0,0,0 );
				float3 TangentLs5_g25 = float3( 0,0,0 );
				float3 CenterWs5_g25 = float3( 0,0,0 );
				float3 CenterLs5_g25 = float3( 0,0,0 );
				float4 Color5_g25 = float4( 0,0,0,0 );
				float4 EmissionHash5_g25 = float4( 0,0,0,0 );
				float Metallic5_g25 = 0.0;
				float Smoothness5_g25 = 0.0;
				float2 Tex5_g25 = float2( 0,0 );
				float4 TextureWeight5_g25 = float4( 1,0,0,0 );
				float SdfValue5_g25 = 0.0;
				float3 Outward2dNormalLs5_g25 = float3( 0,0,0 );
				float3 Outward2dNormalWs5_g25 = float3( 0,0,0 );
				float3 localMudBunSplatPoint5_g25 = MudBunSplatPoint( VertexID5_g25 , PositionLs5_g25 , NormalWs5_g25 , NormalLs5_g25 , TangentWs5_g25 , TangentLs5_g25 , CenterWs5_g25 , CenterLs5_g25 , Color5_g25 , EmissionHash5_g25 , Metallic5_g25 , Smoothness5_g25 , Tex5_g25 , TextureWeight5_g25 , SdfValue5_g25 , Outward2dNormalLs5_g25 , Outward2dNormalWs5_g25 );
				float3 temp_output_183_21 = localMudBunSplatPoint5_g25;
				float3 temp_output_183_52 = TangentWs5_g25;
				float3 Position6_g279 = CenterWs5_g25;
				float Size6_g279 = 0.1;
				float3 localSimplexNoiseGradient6_g279 = SimplexNoiseGradient6_g279( Position6_g279 , Size6_g279 );
				float3 Position6_g280 = ( float3( 0,0,0 ) + ( _TimeParameters.x * _Frequency ) + ( localSimplexNoiseGradient6_g279 * 1.0 ) );
				float Size6_g280 = 0.5;
				float3 localSimplexNoiseGradient6_g280 = SimplexNoiseGradient6_g280( Position6_g280 , Size6_g280 );
				float3 temp_output_215_0 = ( localSimplexNoiseGradient6_g280 * _OffsetAmount );
				float3 temp_output_183_28 = NormalWs5_g25;
				
				float2 vertexToFrag34_g25 = Tex5_g25;
				o.ase_texcoord7.xy = vertexToFrag34_g25;
				float4 vertexToFrag3_g25 = Color5_g25;
				o.ase_texcoord8 = vertexToFrag3_g25;
				float3 vertexToFrag20_g25 = localMudBunSplatPoint5_g25;
				o.ase_texcoord9.xyz = vertexToFrag20_g25;
				float3 vertexToFrag27_g281 = temp_output_183_21;
				o.ase_texcoord10.xyz = vertexToFrag27_g281;
				
				float3 vertexToFrag11_g25 = (EmissionHash5_g25).xyz;
				o.ase_texcoord11.xyz = vertexToFrag11_g25;
				
				float vertexToFrag2_g25 = Metallic5_g25;
				o.ase_texcoord7.w = vertexToFrag2_g25;
				
				float vertexToFrag14_g25 = Smoothness5_g25;
				o.ase_texcoord9.w = vertexToFrag14_g25;
				
				o.ase_texcoord7.z = v.ase_vertexID;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord10.w = 0;
				o.ase_texcoord11.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = ( temp_output_183_21 + ( temp_output_183_52 * (temp_output_215_0).x ) + ( cross( temp_output_183_28 , temp_output_183_52 ) * (temp_output_215_0).z ) );
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.ase_normal = temp_output_183_28;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float3 positionVS = TransformWorldToView( positionWS );
				float4 positionCS = TransformWorldToHClip( positionWS );

				VertexNormalInputs normalInput = GetVertexNormalInputs( v.ase_normal, v.ase_tangent );

				o.tSpace0 = float4( normalInput.normalWS, positionWS.x);
				o.tSpace1 = float4( normalInput.tangentWS, positionWS.y);
				o.tSpace2 = float4( normalInput.bitangentWS, positionWS.z);

				OUTPUT_LIGHTMAP_UV( v.texcoord1, unity_LightmapST, o.lightmapUVOrVertexSH.xy );
				OUTPUT_SH( normalInput.normalWS.xyz, o.lightmapUVOrVertexSH.xyz );

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					o.lightmapUVOrVertexSH.zw = v.texcoord;
					o.lightmapUVOrVertexSH.xy = v.texcoord * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif

				half3 vertexLight = VertexLighting( positionWS, normalInput.normalWS );
				#ifdef ASE_FOG
					half fogFactor = ComputeFogFactor( positionCS.z );
				#else
					half fogFactor = 0;
				#endif
				o.fogFactorAndVertexLight = half4(fogFactor, vertexLight);
				
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
				VertexPositionInputs vertexInput = (VertexPositionInputs)0;
				vertexInput.positionWS = positionWS;
				vertexInput.positionCS = positionCS;
				o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				
				o.clipPos = positionCS;
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
				o.screenPos = ComputeScreenPos(positionCS);
				#endif
				return o;
			}
			
			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_tangent : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				uint ase_vertexID : SV_VertexID;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_tangent = v.ase_tangent;
				o.texcoord = v.texcoord;
				o.texcoord1 = v.texcoord1;
				o.vertex = v.vertex;
				o.ase_vertexID = v.ase_vertexID;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				o.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
				o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_vertexID = patch[0].ase_vertexID * bary.x + patch[1].ase_vertexID * bary.y + patch[2].ase_vertexID * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag ( VertexOutput IN  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(IN);

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float2 sampleCoords = (IN.lightmapUVOrVertexSH.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
					float3 WorldNormal = TransformObjectToWorldNormal(normalize(SAMPLE_TEXTURE2D(_TerrainNormalmapTexture, sampler_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
					float3 WorldTangent = -cross(GetObjectToWorldMatrix()._13_23_33, WorldNormal);
					float3 WorldBiTangent = cross(WorldNormal, -WorldTangent);
				#else
					float3 WorldNormal = normalize( IN.tSpace0.xyz );
					float3 WorldTangent = IN.tSpace1.xyz;
					float3 WorldBiTangent = IN.tSpace2.xyz;
				#endif
				float3 WorldPosition = float3(IN.tSpace0.w,IN.tSpace1.w,IN.tSpace2.w);
				float3 WorldViewDirection = _WorldSpaceCameraPos.xyz  - WorldPosition;
				float4 ShadowCoords = float4( 0, 0, 0, 0 );
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
				float4 ScreenPos = IN.screenPos;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					ShadowCoords = IN.shadowCoord;
				#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
					ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
				#endif
	
				WorldViewDirection = SafeNormalize( WorldViewDirection );

				float2 vertexToFrag34_g25 = IN.ase_texcoord7.xy;
				float2 clampResult36_g25 = clamp( ( vertexToFrag34_g25 + float2( 0.5,0.5 ) ) , float2( 0,0 ) , float2( 1,1 ) );
				float4 vertexToFrag3_g25 = IN.ase_texcoord8;
				float4 temp_output_7_0_g25 = ( _Color * vertexToFrag3_g25 * _IsSplatRenderMaterial );
				float4 temp_output_124_0 = ( tex2D( _MainTex, clampResult36_g25 ) * temp_output_7_0_g25 );
				float localComputeOpaqueTransparency20_g281 = ( 0.0 );
				float3 vertexToFrag20_g25 = IN.ase_texcoord9.xyz;
				float4 unityObjectToClipPos17_g25 = TransformWorldToHClip(TransformObjectToWorld(vertexToFrag20_g25));
				float4 computeScreenPos18_g25 = ComputeScreenPos( unityObjectToClipPos17_g25 );
				float2 ScreenPos20_g281 = (( ( computeScreenPos18_g25 / (computeScreenPos18_g25).w ) * _ScreenParams )).xy;
				float3 vertexToFrag27_g281 = IN.ase_texcoord10.xyz;
				float3 VertPos20_g281 = vertexToFrag27_g281;
				int VertexID5_g25 = IN.ase_texcoord7.z;
				float3 PositionLs5_g25 = float3( 0,0,0 );
				float3 NormalWs5_g25 = float3( 0,0,0 );
				float3 NormalLs5_g25 = float3( 0,0,0 );
				float3 TangentWs5_g25 = float3( 0,0,0 );
				float3 TangentLs5_g25 = float3( 0,0,0 );
				float3 CenterWs5_g25 = float3( 0,0,0 );
				float3 CenterLs5_g25 = float3( 0,0,0 );
				float4 Color5_g25 = float4( 0,0,0,0 );
				float4 EmissionHash5_g25 = float4( 0,0,0,0 );
				float Metallic5_g25 = 0.0;
				float Smoothness5_g25 = 0.0;
				float2 Tex5_g25 = float2( 0,0 );
				float4 TextureWeight5_g25 = float4( 1,0,0,0 );
				float SdfValue5_g25 = 0.0;
				float3 Outward2dNormalLs5_g25 = float3( 0,0,0 );
				float3 Outward2dNormalWs5_g25 = float3( 0,0,0 );
				float3 localMudBunSplatPoint5_g25 = MudBunSplatPoint( VertexID5_g25 , PositionLs5_g25 , NormalWs5_g25 , NormalLs5_g25 , TangentWs5_g25 , TangentLs5_g25 , CenterWs5_g25 , CenterLs5_g25 , Color5_g25 , EmissionHash5_g25 , Metallic5_g25 , Smoothness5_g25 , Tex5_g25 , TextureWeight5_g25 , SdfValue5_g25 , Outward2dNormalLs5_g25 , Outward2dNormalWs5_g25 );
				float Hash20_g281 = (EmissionHash5_g25).w;
				float ifLocalVar62_g25 = 0;
				UNITY_BRANCH 
				if( length( vertexToFrag34_g25 ) <= 0.5 )
				ifLocalVar62_g25 = 1.0;
				else
				ifLocalVar62_g25 = 0.0;
				#ifdef MUDBUN_QUAD_SPLATS
				float staticSwitch50_g25 = 1.0;
				#else
				float staticSwitch50_g25 = ifLocalVar62_g25;
				#endif
				float AlphaIn20_g281 = ( (temp_output_7_0_g25).a * staticSwitch50_g25 );
				float AlphaOut20_g281 = 0;
				float AlphaThreshold20_g281 = 0;
				sampler2D DitherNoiseTexture20_g281 = _DitherTexture;
				int DitherNoiseTextureSize20_g281 = _DitherTextureSize;
				int UseRandomDither20_g281 = (int)_RandomDither;
				float AlphaCutoutThreshold20_g281 = _AlphaCutoutThreshold;
				float DitherBlend20_g281 = _Dithering;
				{
				float alpha = AlphaIn20_g281;
				computeOpaqueTransparency(ScreenPos20_g281, VertPos20_g281, Hash20_g281, DitherNoiseTexture20_g281, DitherNoiseTextureSize20_g281, UseRandomDither20_g281 > 0, AlphaCutoutThreshold20_g281, DitherBlend20_g281,  alpha, AlphaThreshold20_g281);
				AlphaOut20_g281 = alpha;
				}
				float temp_output_197_0 = ( (temp_output_124_0).a * AlphaOut20_g281 );
				float temp_output_119_25 = AlphaThreshold20_g281;
				clip( temp_output_197_0 - temp_output_119_25);
				
				float3 vertexToFrag11_g25 = IN.ase_texcoord11.xyz;
				
				float vertexToFrag2_g25 = IN.ase_texcoord7.w;
				
				float vertexToFrag14_g25 = IN.ase_texcoord9.w;
				
				float3 Albedo = temp_output_124_0.rgb;
				float3 Normal = float3(0, 0, 1);
				float3 Emission = ( vertexToFrag11_g25 * (_Emission).rgb );
				float3 Specular = 0.5;
				float Metallic = ( _Metallic * vertexToFrag2_g25 );
				float Smoothness = ( _Smoothness * vertexToFrag14_g25 );
				float Occlusion = 1;
				float Alpha = temp_output_197_0;
				float AlphaClipThreshold = temp_output_119_25;
				float AlphaClipThresholdShadow = 0.5;
				float3 BakedGI = 0;
				float3 RefractionColor = 1;
				float RefractionIndex = 1;
				float3 Transmission = 1;
				float3 Translucency = 1;

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				InputData inputData;
				inputData.positionWS = WorldPosition;
				inputData.viewDirectionWS = WorldViewDirection;
				inputData.shadowCoord = ShadowCoords;

				#ifdef _NORMALMAP
					#if _NORMAL_DROPOFF_TS
					inputData.normalWS = TransformTangentToWorld(Normal, half3x3( WorldTangent, WorldBiTangent, WorldNormal ));
					#elif _NORMAL_DROPOFF_OS
					inputData.normalWS = TransformObjectToWorldNormal(Normal);
					#elif _NORMAL_DROPOFF_WS
					inputData.normalWS = Normal;
					#endif
					inputData.normalWS = NormalizeNormalPerPixel(inputData.normalWS);
				#else
					inputData.normalWS = WorldNormal;
				#endif

				#ifdef ASE_FOG
					inputData.fogCoord = IN.fogFactorAndVertexLight.x;
				#endif

				inputData.vertexLighting = IN.fogFactorAndVertexLight.yzw;
				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float3 SH = SampleSH(inputData.normalWS.xyz);
				#else
					float3 SH = IN.lightmapUVOrVertexSH.xyz;
				#endif

				inputData.bakedGI = SAMPLE_GI( IN.lightmapUVOrVertexSH.xy, SH, inputData.normalWS );
				#ifdef _ASE_BAKEDGI
					inputData.bakedGI = BakedGI;
				#endif
				half4 color = UniversalFragmentPBR(
					inputData, 
					Albedo, 
					Metallic, 
					Specular, 
					Smoothness, 
					Occlusion, 
					Emission, 
					Alpha);

				#ifdef _TRANSMISSION_ASE
				{
					float shadow = _TransmissionShadow;

					Light mainLight = GetMainLight( inputData.shadowCoord );
					float3 mainAtten = mainLight.color * mainLight.distanceAttenuation;
					mainAtten = lerp( mainAtten, mainAtten * mainLight.shadowAttenuation, shadow );
					half3 mainTransmission = max(0 , -dot(inputData.normalWS, mainLight.direction)) * mainAtten * Transmission;
					color.rgb += Albedo * mainTransmission;

					#ifdef _ADDITIONAL_LIGHTS
						int transPixelLightCount = GetAdditionalLightsCount();
						for (int i = 0; i < transPixelLightCount; ++i)
						{
							Light light = GetAdditionalLight(i, inputData.positionWS);
							float3 atten = light.color * light.distanceAttenuation;
							atten = lerp( atten, atten * light.shadowAttenuation, shadow );

							half3 transmission = max(0 , -dot(inputData.normalWS, light.direction)) * atten * Transmission;
							color.rgb += Albedo * transmission;
						}
					#endif
				}
				#endif

				#ifdef _TRANSLUCENCY_ASE
				{
					float shadow = _TransShadow;
					float normal = _TransNormal;
					float scattering = _TransScattering;
					float direct = _TransDirect;
					float ambient = _TransAmbient;
					float strength = _TransStrength;

					Light mainLight = GetMainLight( inputData.shadowCoord );
					float3 mainAtten = mainLight.color * mainLight.distanceAttenuation;
					mainAtten = lerp( mainAtten, mainAtten * mainLight.shadowAttenuation, shadow );

					half3 mainLightDir = mainLight.direction + inputData.normalWS * normal;
					half mainVdotL = pow( saturate( dot( inputData.viewDirectionWS, -mainLightDir ) ), scattering );
					half3 mainTranslucency = mainAtten * ( mainVdotL * direct + inputData.bakedGI * ambient ) * Translucency;
					color.rgb += Albedo * mainTranslucency * strength;

					#ifdef _ADDITIONAL_LIGHTS
						int transPixelLightCount = GetAdditionalLightsCount();
						for (int i = 0; i < transPixelLightCount; ++i)
						{
							Light light = GetAdditionalLight(i, inputData.positionWS);
							float3 atten = light.color * light.distanceAttenuation;
							atten = lerp( atten, atten * light.shadowAttenuation, shadow );

							half3 lightDir = light.direction + inputData.normalWS * normal;
							half VdotL = pow( saturate( dot( inputData.viewDirectionWS, -lightDir ) ), scattering );
							half3 translucency = atten * ( VdotL * direct + inputData.bakedGI * ambient ) * Translucency;
							color.rgb += Albedo * translucency * strength;
						}
					#endif
				}
				#endif

				#ifdef _REFRACTION_ASE
					float4 projScreenPos = ScreenPos / ScreenPos.w;
					float3 refractionOffset = ( RefractionIndex - 1.0 ) * mul( UNITY_MATRIX_V, WorldNormal ).xyz * ( 1.0 - dot( WorldNormal, WorldViewDirection ) );
					projScreenPos.xy += refractionOffset.xy;
					float3 refraction = SHADERGRAPH_SAMPLE_SCENE_COLOR( projScreenPos ) * RefractionColor;
					color.rgb = lerp( refraction, color.rgb, color.a );
					color.a = 1;
				#endif

				#ifdef ASE_FINAL_COLOR_ALPHA_MULTIPLY
					color.rgb *= color.a;
				#endif

				#ifdef ASE_FOG
					#ifdef TERRAIN_SPLAT_ADDPASS
						color.rgb = MixFogColor(color.rgb, half3( 0, 0, 0 ), IN.fogFactorAndVertexLight.x );
					#else
						color.rgb = MixFog(color.rgb, IN.fogFactorAndVertexLight.x);
					#endif
				#endif
				
				return color;
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }

			ZWrite On
			ZTest LEqual
			AlphaToMask Off

			HLSLPROGRAM
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define _EMISSION
			#define _ALPHATEST_ON 1
			#define ASE_SRP_VERSION 70301

			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS_SHADOWCASTER

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

			#define SHADER_GRAPH
			#pragma multi_compile _ MUDBUN_PROCEDURAL
			#pragma multi_compile _ MUDBUN_QUAD_SPLATS
			#include "Assets/MudBun/Shader/Render/ShaderCommon.cginc"
			#include "Assets/MudBun/Shader/Render/SplatCommon.cginc"


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				uint ase_vertexID : SV_VertexID;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float _Frequency;
			float _OffsetAmount;
			float _IsSplatRenderMaterial;
			int _DitherTextureSize;
			float _RandomDither;
			float _AlphaCutoutThreshold;
			float _Dithering;
			#ifdef _TRANSMISSION_ASE
				float _TransmissionShadow;
			#endif
			#ifdef _TRANSLUCENCY_ASE
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _MainTex;
			sampler2D _DitherTexture;


			float3 MudBunSplatPoint( int VertexID, out float3 PositionLs, out float3 NormalWs, out float3 NormalLs, out float3 TangentWs, out float3 TangentLs, out float3 CenterWs, out float3 CenterLs, out float4 Color, out float4 EmissionHash, out float Metallic, out float Smoothness, out float2 Tex, out float4 TextureWeight, out float SdfValue, out float3 Outward2dNormalLs, out float3 Outward2dNormalWs )
			{
				float4 positionWs;
				float2 metallicSmoothness;
				mudbun_splat_vert(VertexID, positionWs, PositionLs, NormalWs, NormalLs, TangentWs, TangentLs, CenterWs, CenterLs, Color, EmissionHash, metallicSmoothness, Tex, TextureWeight, SdfValue, Outward2dNormalLs, Outward2dNormalWs);
				Metallic = metallicSmoothness.x;
				Smoothness = metallicSmoothness.y;
				return positionWs.xyz;
			}
			
			float3 SimplexNoiseGradient6_g279( float3 Position, float Size )
			{
				#ifdef MUDBUN_VALID
				return snoise_grad(Position / max(1e-6, Size)).xyz;
				#else
				return Position;
				#endif
			}
			
			float3 SimplexNoiseGradient6_g280( float3 Position, float Size )
			{
				#ifdef MUDBUN_VALID
				return snoise_grad(Position / max(1e-6, Size)).xyz;
				#else
				return Position;
				#endif
			}
			

			float3 _LightDirection;

			VertexOutput VertexFunction( VertexInput v )
			{
				VertexOutput o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

				int VertexID5_g25 = v.ase_vertexID;
				float3 PositionLs5_g25 = float3( 0,0,0 );
				float3 NormalWs5_g25 = float3( 0,0,0 );
				float3 NormalLs5_g25 = float3( 0,0,0 );
				float3 TangentWs5_g25 = float3( 0,0,0 );
				float3 TangentLs5_g25 = float3( 0,0,0 );
				float3 CenterWs5_g25 = float3( 0,0,0 );
				float3 CenterLs5_g25 = float3( 0,0,0 );
				float4 Color5_g25 = float4( 0,0,0,0 );
				float4 EmissionHash5_g25 = float4( 0,0,0,0 );
				float Metallic5_g25 = 0.0;
				float Smoothness5_g25 = 0.0;
				float2 Tex5_g25 = float2( 0,0 );
				float4 TextureWeight5_g25 = float4( 1,0,0,0 );
				float SdfValue5_g25 = 0.0;
				float3 Outward2dNormalLs5_g25 = float3( 0,0,0 );
				float3 Outward2dNormalWs5_g25 = float3( 0,0,0 );
				float3 localMudBunSplatPoint5_g25 = MudBunSplatPoint( VertexID5_g25 , PositionLs5_g25 , NormalWs5_g25 , NormalLs5_g25 , TangentWs5_g25 , TangentLs5_g25 , CenterWs5_g25 , CenterLs5_g25 , Color5_g25 , EmissionHash5_g25 , Metallic5_g25 , Smoothness5_g25 , Tex5_g25 , TextureWeight5_g25 , SdfValue5_g25 , Outward2dNormalLs5_g25 , Outward2dNormalWs5_g25 );
				float3 temp_output_183_21 = localMudBunSplatPoint5_g25;
				float3 temp_output_183_52 = TangentWs5_g25;
				float3 Position6_g279 = CenterWs5_g25;
				float Size6_g279 = 0.1;
				float3 localSimplexNoiseGradient6_g279 = SimplexNoiseGradient6_g279( Position6_g279 , Size6_g279 );
				float3 Position6_g280 = ( float3( 0,0,0 ) + ( _TimeParameters.x * _Frequency ) + ( localSimplexNoiseGradient6_g279 * 1.0 ) );
				float Size6_g280 = 0.5;
				float3 localSimplexNoiseGradient6_g280 = SimplexNoiseGradient6_g280( Position6_g280 , Size6_g280 );
				float3 temp_output_215_0 = ( localSimplexNoiseGradient6_g280 * _OffsetAmount );
				float3 temp_output_183_28 = NormalWs5_g25;
				
				float2 vertexToFrag34_g25 = Tex5_g25;
				o.ase_texcoord2.xy = vertexToFrag34_g25;
				float4 vertexToFrag3_g25 = Color5_g25;
				o.ase_texcoord3 = vertexToFrag3_g25;
				float3 vertexToFrag20_g25 = localMudBunSplatPoint5_g25;
				o.ase_texcoord4.xyz = vertexToFrag20_g25;
				float3 vertexToFrag27_g281 = temp_output_183_21;
				o.ase_texcoord5.xyz = vertexToFrag27_g281;
				
				o.ase_texcoord2.z = v.ase_vertexID;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord2.w = 0;
				o.ase_texcoord4.w = 0;
				o.ase_texcoord5.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = ( temp_output_183_21 + ( temp_output_183_52 * (temp_output_215_0).x ) + ( cross( temp_output_183_28 , temp_output_183_52 ) * (temp_output_215_0).z ) );
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = temp_output_183_28;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif
				float3 normalWS = TransformObjectToWorldDir(v.ase_normal);

				float4 clipPos = TransformWorldToHClip( ApplyShadowBias( positionWS, normalWS, _LightDirection ) );

				#if UNITY_REVERSED_Z
					clipPos.z = min(clipPos.z, clipPos.w * UNITY_NEAR_CLIP_VALUE);
				#else
					clipPos.z = max(clipPos.z, clipPos.w * UNITY_NEAR_CLIP_VALUE);
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = clipPos;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				o.clipPos = clipPos;
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				uint ase_vertexID : SV_VertexID;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.vertex = v.vertex;
				o.ase_vertexID = v.ase_vertexID;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_vertexID = patch[0].ase_vertexID * bary.x + patch[1].ase_vertexID * bary.y + patch[2].ase_vertexID * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );
				
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float2 vertexToFrag34_g25 = IN.ase_texcoord2.xy;
				float2 clampResult36_g25 = clamp( ( vertexToFrag34_g25 + float2( 0.5,0.5 ) ) , float2( 0,0 ) , float2( 1,1 ) );
				float4 vertexToFrag3_g25 = IN.ase_texcoord3;
				float4 temp_output_7_0_g25 = ( _Color * vertexToFrag3_g25 * _IsSplatRenderMaterial );
				float4 temp_output_124_0 = ( tex2D( _MainTex, clampResult36_g25 ) * temp_output_7_0_g25 );
				float localComputeOpaqueTransparency20_g281 = ( 0.0 );
				float3 vertexToFrag20_g25 = IN.ase_texcoord4.xyz;
				float4 unityObjectToClipPos17_g25 = TransformWorldToHClip(TransformObjectToWorld(vertexToFrag20_g25));
				float4 computeScreenPos18_g25 = ComputeScreenPos( unityObjectToClipPos17_g25 );
				float2 ScreenPos20_g281 = (( ( computeScreenPos18_g25 / (computeScreenPos18_g25).w ) * _ScreenParams )).xy;
				float3 vertexToFrag27_g281 = IN.ase_texcoord5.xyz;
				float3 VertPos20_g281 = vertexToFrag27_g281;
				int VertexID5_g25 = IN.ase_texcoord2.z;
				float3 PositionLs5_g25 = float3( 0,0,0 );
				float3 NormalWs5_g25 = float3( 0,0,0 );
				float3 NormalLs5_g25 = float3( 0,0,0 );
				float3 TangentWs5_g25 = float3( 0,0,0 );
				float3 TangentLs5_g25 = float3( 0,0,0 );
				float3 CenterWs5_g25 = float3( 0,0,0 );
				float3 CenterLs5_g25 = float3( 0,0,0 );
				float4 Color5_g25 = float4( 0,0,0,0 );
				float4 EmissionHash5_g25 = float4( 0,0,0,0 );
				float Metallic5_g25 = 0.0;
				float Smoothness5_g25 = 0.0;
				float2 Tex5_g25 = float2( 0,0 );
				float4 TextureWeight5_g25 = float4( 1,0,0,0 );
				float SdfValue5_g25 = 0.0;
				float3 Outward2dNormalLs5_g25 = float3( 0,0,0 );
				float3 Outward2dNormalWs5_g25 = float3( 0,0,0 );
				float3 localMudBunSplatPoint5_g25 = MudBunSplatPoint( VertexID5_g25 , PositionLs5_g25 , NormalWs5_g25 , NormalLs5_g25 , TangentWs5_g25 , TangentLs5_g25 , CenterWs5_g25 , CenterLs5_g25 , Color5_g25 , EmissionHash5_g25 , Metallic5_g25 , Smoothness5_g25 , Tex5_g25 , TextureWeight5_g25 , SdfValue5_g25 , Outward2dNormalLs5_g25 , Outward2dNormalWs5_g25 );
				float Hash20_g281 = (EmissionHash5_g25).w;
				float ifLocalVar62_g25 = 0;
				UNITY_BRANCH 
				if( length( vertexToFrag34_g25 ) <= 0.5 )
				ifLocalVar62_g25 = 1.0;
				else
				ifLocalVar62_g25 = 0.0;
				#ifdef MUDBUN_QUAD_SPLATS
				float staticSwitch50_g25 = 1.0;
				#else
				float staticSwitch50_g25 = ifLocalVar62_g25;
				#endif
				float AlphaIn20_g281 = ( (temp_output_7_0_g25).a * staticSwitch50_g25 );
				float AlphaOut20_g281 = 0;
				float AlphaThreshold20_g281 = 0;
				sampler2D DitherNoiseTexture20_g281 = _DitherTexture;
				int DitherNoiseTextureSize20_g281 = _DitherTextureSize;
				int UseRandomDither20_g281 = (int)_RandomDither;
				float AlphaCutoutThreshold20_g281 = _AlphaCutoutThreshold;
				float DitherBlend20_g281 = _Dithering;
				{
				float alpha = AlphaIn20_g281;
				computeOpaqueTransparency(ScreenPos20_g281, VertPos20_g281, Hash20_g281, DitherNoiseTexture20_g281, DitherNoiseTextureSize20_g281, UseRandomDither20_g281 > 0, AlphaCutoutThreshold20_g281, DitherBlend20_g281,  alpha, AlphaThreshold20_g281);
				AlphaOut20_g281 = alpha;
				}
				float temp_output_197_0 = ( (temp_output_124_0).a * AlphaOut20_g281 );
				
				float temp_output_119_25 = AlphaThreshold20_g281;
				
				float Alpha = temp_output_197_0;
				float AlphaClipThreshold = temp_output_119_25;
				float AlphaClipThresholdShadow = 0.5;

				#ifdef _ALPHATEST_ON
					#ifdef _ALPHATEST_SHADOW_ON
						clip(Alpha - AlphaClipThresholdShadow);
					#else
						clip(Alpha - AlphaClipThreshold);
					#endif
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif
				return 0;
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			ZWrite On
			ColorMask 0
			AlphaToMask Off

			HLSLPROGRAM
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define _EMISSION
			#define _ALPHATEST_ON 1
			#define ASE_SRP_VERSION 70301

			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS_DEPTHONLY

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

			#define SHADER_GRAPH
			#pragma multi_compile _ MUDBUN_PROCEDURAL
			#pragma multi_compile _ MUDBUN_QUAD_SPLATS
			#include "Assets/MudBun/Shader/Render/ShaderCommon.cginc"
			#include "Assets/MudBun/Shader/Render/SplatCommon.cginc"


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				uint ase_vertexID : SV_VertexID;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float _Frequency;
			float _OffsetAmount;
			float _IsSplatRenderMaterial;
			int _DitherTextureSize;
			float _RandomDither;
			float _AlphaCutoutThreshold;
			float _Dithering;
			#ifdef _TRANSMISSION_ASE
				float _TransmissionShadow;
			#endif
			#ifdef _TRANSLUCENCY_ASE
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _MainTex;
			sampler2D _DitherTexture;


			float3 MudBunSplatPoint( int VertexID, out float3 PositionLs, out float3 NormalWs, out float3 NormalLs, out float3 TangentWs, out float3 TangentLs, out float3 CenterWs, out float3 CenterLs, out float4 Color, out float4 EmissionHash, out float Metallic, out float Smoothness, out float2 Tex, out float4 TextureWeight, out float SdfValue, out float3 Outward2dNormalLs, out float3 Outward2dNormalWs )
			{
				float4 positionWs;
				float2 metallicSmoothness;
				mudbun_splat_vert(VertexID, positionWs, PositionLs, NormalWs, NormalLs, TangentWs, TangentLs, CenterWs, CenterLs, Color, EmissionHash, metallicSmoothness, Tex, TextureWeight, SdfValue, Outward2dNormalLs, Outward2dNormalWs);
				Metallic = metallicSmoothness.x;
				Smoothness = metallicSmoothness.y;
				return positionWs.xyz;
			}
			
			float3 SimplexNoiseGradient6_g279( float3 Position, float Size )
			{
				#ifdef MUDBUN_VALID
				return snoise_grad(Position / max(1e-6, Size)).xyz;
				#else
				return Position;
				#endif
			}
			
			float3 SimplexNoiseGradient6_g280( float3 Position, float Size )
			{
				#ifdef MUDBUN_VALID
				return snoise_grad(Position / max(1e-6, Size)).xyz;
				#else
				return Position;
				#endif
			}
			

			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				int VertexID5_g25 = v.ase_vertexID;
				float3 PositionLs5_g25 = float3( 0,0,0 );
				float3 NormalWs5_g25 = float3( 0,0,0 );
				float3 NormalLs5_g25 = float3( 0,0,0 );
				float3 TangentWs5_g25 = float3( 0,0,0 );
				float3 TangentLs5_g25 = float3( 0,0,0 );
				float3 CenterWs5_g25 = float3( 0,0,0 );
				float3 CenterLs5_g25 = float3( 0,0,0 );
				float4 Color5_g25 = float4( 0,0,0,0 );
				float4 EmissionHash5_g25 = float4( 0,0,0,0 );
				float Metallic5_g25 = 0.0;
				float Smoothness5_g25 = 0.0;
				float2 Tex5_g25 = float2( 0,0 );
				float4 TextureWeight5_g25 = float4( 1,0,0,0 );
				float SdfValue5_g25 = 0.0;
				float3 Outward2dNormalLs5_g25 = float3( 0,0,0 );
				float3 Outward2dNormalWs5_g25 = float3( 0,0,0 );
				float3 localMudBunSplatPoint5_g25 = MudBunSplatPoint( VertexID5_g25 , PositionLs5_g25 , NormalWs5_g25 , NormalLs5_g25 , TangentWs5_g25 , TangentLs5_g25 , CenterWs5_g25 , CenterLs5_g25 , Color5_g25 , EmissionHash5_g25 , Metallic5_g25 , Smoothness5_g25 , Tex5_g25 , TextureWeight5_g25 , SdfValue5_g25 , Outward2dNormalLs5_g25 , Outward2dNormalWs5_g25 );
				float3 temp_output_183_21 = localMudBunSplatPoint5_g25;
				float3 temp_output_183_52 = TangentWs5_g25;
				float3 Position6_g279 = CenterWs5_g25;
				float Size6_g279 = 0.1;
				float3 localSimplexNoiseGradient6_g279 = SimplexNoiseGradient6_g279( Position6_g279 , Size6_g279 );
				float3 Position6_g280 = ( float3( 0,0,0 ) + ( _TimeParameters.x * _Frequency ) + ( localSimplexNoiseGradient6_g279 * 1.0 ) );
				float Size6_g280 = 0.5;
				float3 localSimplexNoiseGradient6_g280 = SimplexNoiseGradient6_g280( Position6_g280 , Size6_g280 );
				float3 temp_output_215_0 = ( localSimplexNoiseGradient6_g280 * _OffsetAmount );
				float3 temp_output_183_28 = NormalWs5_g25;
				
				float2 vertexToFrag34_g25 = Tex5_g25;
				o.ase_texcoord2.xy = vertexToFrag34_g25;
				float4 vertexToFrag3_g25 = Color5_g25;
				o.ase_texcoord3 = vertexToFrag3_g25;
				float3 vertexToFrag20_g25 = localMudBunSplatPoint5_g25;
				o.ase_texcoord4.xyz = vertexToFrag20_g25;
				float3 vertexToFrag27_g281 = temp_output_183_21;
				o.ase_texcoord5.xyz = vertexToFrag27_g281;
				
				o.ase_texcoord2.z = v.ase_vertexID;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord2.w = 0;
				o.ase_texcoord4.w = 0;
				o.ase_texcoord5.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = ( temp_output_183_21 + ( temp_output_183_52 * (temp_output_215_0).x ) + ( cross( temp_output_183_28 , temp_output_183_52 ) * (temp_output_215_0).z ) );
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = temp_output_183_28;
				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float4 positionCS = TransformWorldToHClip( positionWS );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = positionCS;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				o.clipPos = positionCS;
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				uint ase_vertexID : SV_VertexID;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.vertex = v.vertex;
				o.ase_vertexID = v.ase_vertexID;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_vertexID = patch[0].ase_vertexID * bary.x + patch[1].ase_vertexID * bary.y + patch[2].ase_vertexID * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float2 vertexToFrag34_g25 = IN.ase_texcoord2.xy;
				float2 clampResult36_g25 = clamp( ( vertexToFrag34_g25 + float2( 0.5,0.5 ) ) , float2( 0,0 ) , float2( 1,1 ) );
				float4 vertexToFrag3_g25 = IN.ase_texcoord3;
				float4 temp_output_7_0_g25 = ( _Color * vertexToFrag3_g25 * _IsSplatRenderMaterial );
				float4 temp_output_124_0 = ( tex2D( _MainTex, clampResult36_g25 ) * temp_output_7_0_g25 );
				float localComputeOpaqueTransparency20_g281 = ( 0.0 );
				float3 vertexToFrag20_g25 = IN.ase_texcoord4.xyz;
				float4 unityObjectToClipPos17_g25 = TransformWorldToHClip(TransformObjectToWorld(vertexToFrag20_g25));
				float4 computeScreenPos18_g25 = ComputeScreenPos( unityObjectToClipPos17_g25 );
				float2 ScreenPos20_g281 = (( ( computeScreenPos18_g25 / (computeScreenPos18_g25).w ) * _ScreenParams )).xy;
				float3 vertexToFrag27_g281 = IN.ase_texcoord5.xyz;
				float3 VertPos20_g281 = vertexToFrag27_g281;
				int VertexID5_g25 = IN.ase_texcoord2.z;
				float3 PositionLs5_g25 = float3( 0,0,0 );
				float3 NormalWs5_g25 = float3( 0,0,0 );
				float3 NormalLs5_g25 = float3( 0,0,0 );
				float3 TangentWs5_g25 = float3( 0,0,0 );
				float3 TangentLs5_g25 = float3( 0,0,0 );
				float3 CenterWs5_g25 = float3( 0,0,0 );
				float3 CenterLs5_g25 = float3( 0,0,0 );
				float4 Color5_g25 = float4( 0,0,0,0 );
				float4 EmissionHash5_g25 = float4( 0,0,0,0 );
				float Metallic5_g25 = 0.0;
				float Smoothness5_g25 = 0.0;
				float2 Tex5_g25 = float2( 0,0 );
				float4 TextureWeight5_g25 = float4( 1,0,0,0 );
				float SdfValue5_g25 = 0.0;
				float3 Outward2dNormalLs5_g25 = float3( 0,0,0 );
				float3 Outward2dNormalWs5_g25 = float3( 0,0,0 );
				float3 localMudBunSplatPoint5_g25 = MudBunSplatPoint( VertexID5_g25 , PositionLs5_g25 , NormalWs5_g25 , NormalLs5_g25 , TangentWs5_g25 , TangentLs5_g25 , CenterWs5_g25 , CenterLs5_g25 , Color5_g25 , EmissionHash5_g25 , Metallic5_g25 , Smoothness5_g25 , Tex5_g25 , TextureWeight5_g25 , SdfValue5_g25 , Outward2dNormalLs5_g25 , Outward2dNormalWs5_g25 );
				float Hash20_g281 = (EmissionHash5_g25).w;
				float ifLocalVar62_g25 = 0;
				UNITY_BRANCH 
				if( length( vertexToFrag34_g25 ) <= 0.5 )
				ifLocalVar62_g25 = 1.0;
				else
				ifLocalVar62_g25 = 0.0;
				#ifdef MUDBUN_QUAD_SPLATS
				float staticSwitch50_g25 = 1.0;
				#else
				float staticSwitch50_g25 = ifLocalVar62_g25;
				#endif
				float AlphaIn20_g281 = ( (temp_output_7_0_g25).a * staticSwitch50_g25 );
				float AlphaOut20_g281 = 0;
				float AlphaThreshold20_g281 = 0;
				sampler2D DitherNoiseTexture20_g281 = _DitherTexture;
				int DitherNoiseTextureSize20_g281 = _DitherTextureSize;
				int UseRandomDither20_g281 = (int)_RandomDither;
				float AlphaCutoutThreshold20_g281 = _AlphaCutoutThreshold;
				float DitherBlend20_g281 = _Dithering;
				{
				float alpha = AlphaIn20_g281;
				computeOpaqueTransparency(ScreenPos20_g281, VertPos20_g281, Hash20_g281, DitherNoiseTexture20_g281, DitherNoiseTextureSize20_g281, UseRandomDither20_g281 > 0, AlphaCutoutThreshold20_g281, DitherBlend20_g281,  alpha, AlphaThreshold20_g281);
				AlphaOut20_g281 = alpha;
				}
				float temp_output_197_0 = ( (temp_output_124_0).a * AlphaOut20_g281 );
				
				float temp_output_119_25 = AlphaThreshold20_g281;
				
				float Alpha = temp_output_197_0;
				float AlphaClipThreshold = temp_output_119_25;

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif
				return 0;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "Meta"
			Tags { "LightMode"="Meta" }

			Cull Off

			HLSLPROGRAM
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define _EMISSION
			#define _ALPHATEST_ON 1
			#define ASE_SRP_VERSION 70301

			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS_META

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

			#define SHADER_GRAPH
			#pragma multi_compile _ MUDBUN_PROCEDURAL
			#pragma multi_compile _ MUDBUN_QUAD_SPLATS
			#include "Assets/MudBun/Shader/Render/ShaderCommon.cginc"
			#include "Assets/MudBun/Shader/Render/SplatCommon.cginc"


			#pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A

			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				uint ase_vertexID : SV_VertexID;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float _Frequency;
			float _OffsetAmount;
			float _IsSplatRenderMaterial;
			int _DitherTextureSize;
			float _RandomDither;
			float _AlphaCutoutThreshold;
			float _Dithering;
			#ifdef _TRANSMISSION_ASE
				float _TransmissionShadow;
			#endif
			#ifdef _TRANSLUCENCY_ASE
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _MainTex;
			sampler2D _DitherTexture;


			float3 MudBunSplatPoint( int VertexID, out float3 PositionLs, out float3 NormalWs, out float3 NormalLs, out float3 TangentWs, out float3 TangentLs, out float3 CenterWs, out float3 CenterLs, out float4 Color, out float4 EmissionHash, out float Metallic, out float Smoothness, out float2 Tex, out float4 TextureWeight, out float SdfValue, out float3 Outward2dNormalLs, out float3 Outward2dNormalWs )
			{
				float4 positionWs;
				float2 metallicSmoothness;
				mudbun_splat_vert(VertexID, positionWs, PositionLs, NormalWs, NormalLs, TangentWs, TangentLs, CenterWs, CenterLs, Color, EmissionHash, metallicSmoothness, Tex, TextureWeight, SdfValue, Outward2dNormalLs, Outward2dNormalWs);
				Metallic = metallicSmoothness.x;
				Smoothness = metallicSmoothness.y;
				return positionWs.xyz;
			}
			
			float3 SimplexNoiseGradient6_g279( float3 Position, float Size )
			{
				#ifdef MUDBUN_VALID
				return snoise_grad(Position / max(1e-6, Size)).xyz;
				#else
				return Position;
				#endif
			}
			
			float3 SimplexNoiseGradient6_g280( float3 Position, float Size )
			{
				#ifdef MUDBUN_VALID
				return snoise_grad(Position / max(1e-6, Size)).xyz;
				#else
				return Position;
				#endif
			}
			

			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				int VertexID5_g25 = v.ase_vertexID;
				float3 PositionLs5_g25 = float3( 0,0,0 );
				float3 NormalWs5_g25 = float3( 0,0,0 );
				float3 NormalLs5_g25 = float3( 0,0,0 );
				float3 TangentWs5_g25 = float3( 0,0,0 );
				float3 TangentLs5_g25 = float3( 0,0,0 );
				float3 CenterWs5_g25 = float3( 0,0,0 );
				float3 CenterLs5_g25 = float3( 0,0,0 );
				float4 Color5_g25 = float4( 0,0,0,0 );
				float4 EmissionHash5_g25 = float4( 0,0,0,0 );
				float Metallic5_g25 = 0.0;
				float Smoothness5_g25 = 0.0;
				float2 Tex5_g25 = float2( 0,0 );
				float4 TextureWeight5_g25 = float4( 1,0,0,0 );
				float SdfValue5_g25 = 0.0;
				float3 Outward2dNormalLs5_g25 = float3( 0,0,0 );
				float3 Outward2dNormalWs5_g25 = float3( 0,0,0 );
				float3 localMudBunSplatPoint5_g25 = MudBunSplatPoint( VertexID5_g25 , PositionLs5_g25 , NormalWs5_g25 , NormalLs5_g25 , TangentWs5_g25 , TangentLs5_g25 , CenterWs5_g25 , CenterLs5_g25 , Color5_g25 , EmissionHash5_g25 , Metallic5_g25 , Smoothness5_g25 , Tex5_g25 , TextureWeight5_g25 , SdfValue5_g25 , Outward2dNormalLs5_g25 , Outward2dNormalWs5_g25 );
				float3 temp_output_183_21 = localMudBunSplatPoint5_g25;
				float3 temp_output_183_52 = TangentWs5_g25;
				float3 Position6_g279 = CenterWs5_g25;
				float Size6_g279 = 0.1;
				float3 localSimplexNoiseGradient6_g279 = SimplexNoiseGradient6_g279( Position6_g279 , Size6_g279 );
				float3 Position6_g280 = ( float3( 0,0,0 ) + ( _TimeParameters.x * _Frequency ) + ( localSimplexNoiseGradient6_g279 * 1.0 ) );
				float Size6_g280 = 0.5;
				float3 localSimplexNoiseGradient6_g280 = SimplexNoiseGradient6_g280( Position6_g280 , Size6_g280 );
				float3 temp_output_215_0 = ( localSimplexNoiseGradient6_g280 * _OffsetAmount );
				float3 temp_output_183_28 = NormalWs5_g25;
				
				float2 vertexToFrag34_g25 = Tex5_g25;
				o.ase_texcoord2.xy = vertexToFrag34_g25;
				float4 vertexToFrag3_g25 = Color5_g25;
				o.ase_texcoord3 = vertexToFrag3_g25;
				float3 vertexToFrag20_g25 = localMudBunSplatPoint5_g25;
				o.ase_texcoord4.xyz = vertexToFrag20_g25;
				float3 vertexToFrag27_g281 = temp_output_183_21;
				o.ase_texcoord5.xyz = vertexToFrag27_g281;
				
				float3 vertexToFrag11_g25 = (EmissionHash5_g25).xyz;
				o.ase_texcoord6.xyz = vertexToFrag11_g25;
				
				o.ase_texcoord2.z = v.ase_vertexID;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord2.w = 0;
				o.ase_texcoord4.w = 0;
				o.ase_texcoord5.w = 0;
				o.ase_texcoord6.w = 0;
				
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = ( temp_output_183_21 + ( temp_output_183_52 * (temp_output_215_0).x ) + ( cross( temp_output_183_28 , temp_output_183_52 ) * (temp_output_215_0).z ) );
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = temp_output_183_28;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif

				o.clipPos = MetaVertexPosition( v.vertex, v.texcoord1.xy, v.texcoord1.xy, unity_LightmapST, unity_DynamicLightmapST );
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = o.clipPos;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				uint ase_vertexID : SV_VertexID;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.texcoord1 = v.texcoord1;
				o.texcoord2 = v.texcoord2;
				o.vertex = v.vertex;
				o.ase_vertexID = v.ase_vertexID;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				o.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_vertexID = patch[0].ase_vertexID * bary.x + patch[1].ase_vertexID * bary.y + patch[2].ase_vertexID * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float2 vertexToFrag34_g25 = IN.ase_texcoord2.xy;
				float2 clampResult36_g25 = clamp( ( vertexToFrag34_g25 + float2( 0.5,0.5 ) ) , float2( 0,0 ) , float2( 1,1 ) );
				float4 vertexToFrag3_g25 = IN.ase_texcoord3;
				float4 temp_output_7_0_g25 = ( _Color * vertexToFrag3_g25 * _IsSplatRenderMaterial );
				float4 temp_output_124_0 = ( tex2D( _MainTex, clampResult36_g25 ) * temp_output_7_0_g25 );
				float localComputeOpaqueTransparency20_g281 = ( 0.0 );
				float3 vertexToFrag20_g25 = IN.ase_texcoord4.xyz;
				float4 unityObjectToClipPos17_g25 = TransformWorldToHClip(TransformObjectToWorld(vertexToFrag20_g25));
				float4 computeScreenPos18_g25 = ComputeScreenPos( unityObjectToClipPos17_g25 );
				float2 ScreenPos20_g281 = (( ( computeScreenPos18_g25 / (computeScreenPos18_g25).w ) * _ScreenParams )).xy;
				float3 vertexToFrag27_g281 = IN.ase_texcoord5.xyz;
				float3 VertPos20_g281 = vertexToFrag27_g281;
				int VertexID5_g25 = IN.ase_texcoord2.z;
				float3 PositionLs5_g25 = float3( 0,0,0 );
				float3 NormalWs5_g25 = float3( 0,0,0 );
				float3 NormalLs5_g25 = float3( 0,0,0 );
				float3 TangentWs5_g25 = float3( 0,0,0 );
				float3 TangentLs5_g25 = float3( 0,0,0 );
				float3 CenterWs5_g25 = float3( 0,0,0 );
				float3 CenterLs5_g25 = float3( 0,0,0 );
				float4 Color5_g25 = float4( 0,0,0,0 );
				float4 EmissionHash5_g25 = float4( 0,0,0,0 );
				float Metallic5_g25 = 0.0;
				float Smoothness5_g25 = 0.0;
				float2 Tex5_g25 = float2( 0,0 );
				float4 TextureWeight5_g25 = float4( 1,0,0,0 );
				float SdfValue5_g25 = 0.0;
				float3 Outward2dNormalLs5_g25 = float3( 0,0,0 );
				float3 Outward2dNormalWs5_g25 = float3( 0,0,0 );
				float3 localMudBunSplatPoint5_g25 = MudBunSplatPoint( VertexID5_g25 , PositionLs5_g25 , NormalWs5_g25 , NormalLs5_g25 , TangentWs5_g25 , TangentLs5_g25 , CenterWs5_g25 , CenterLs5_g25 , Color5_g25 , EmissionHash5_g25 , Metallic5_g25 , Smoothness5_g25 , Tex5_g25 , TextureWeight5_g25 , SdfValue5_g25 , Outward2dNormalLs5_g25 , Outward2dNormalWs5_g25 );
				float Hash20_g281 = (EmissionHash5_g25).w;
				float ifLocalVar62_g25 = 0;
				UNITY_BRANCH 
				if( length( vertexToFrag34_g25 ) <= 0.5 )
				ifLocalVar62_g25 = 1.0;
				else
				ifLocalVar62_g25 = 0.0;
				#ifdef MUDBUN_QUAD_SPLATS
				float staticSwitch50_g25 = 1.0;
				#else
				float staticSwitch50_g25 = ifLocalVar62_g25;
				#endif
				float AlphaIn20_g281 = ( (temp_output_7_0_g25).a * staticSwitch50_g25 );
				float AlphaOut20_g281 = 0;
				float AlphaThreshold20_g281 = 0;
				sampler2D DitherNoiseTexture20_g281 = _DitherTexture;
				int DitherNoiseTextureSize20_g281 = _DitherTextureSize;
				int UseRandomDither20_g281 = (int)_RandomDither;
				float AlphaCutoutThreshold20_g281 = _AlphaCutoutThreshold;
				float DitherBlend20_g281 = _Dithering;
				{
				float alpha = AlphaIn20_g281;
				computeOpaqueTransparency(ScreenPos20_g281, VertPos20_g281, Hash20_g281, DitherNoiseTexture20_g281, DitherNoiseTextureSize20_g281, UseRandomDither20_g281 > 0, AlphaCutoutThreshold20_g281, DitherBlend20_g281,  alpha, AlphaThreshold20_g281);
				AlphaOut20_g281 = alpha;
				}
				float temp_output_197_0 = ( (temp_output_124_0).a * AlphaOut20_g281 );
				float temp_output_119_25 = AlphaThreshold20_g281;
				clip( temp_output_197_0 - temp_output_119_25);
				
				float3 vertexToFrag11_g25 = IN.ase_texcoord6.xyz;
				
				
				float3 Albedo = temp_output_124_0.rgb;
				float3 Emission = ( vertexToFrag11_g25 * (_Emission).rgb );
				float Alpha = temp_output_197_0;
				float AlphaClipThreshold = temp_output_119_25;

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				MetaInput metaInput = (MetaInput)0;
				metaInput.Albedo = Albedo;
				metaInput.Emission = Emission;
				
				return MetaFragment(metaInput);
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "Universal2D"
			Tags { "LightMode"="Universal2D" }

			Blend One Zero, One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA

			HLSLPROGRAM
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define _EMISSION
			#define _ALPHATEST_ON 1
			#define ASE_SRP_VERSION 70301

			#pragma enable_d3d11_debug_symbols
			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS_2D

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/UnityInstancing.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			
			#define SHADER_GRAPH
			#pragma multi_compile _ MUDBUN_PROCEDURAL
			#pragma multi_compile _ MUDBUN_QUAD_SPLATS
			#include "Assets/MudBun/Shader/Render/ShaderCommon.cginc"
			#include "Assets/MudBun/Shader/Render/SplatCommon.cginc"


			#pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A

			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				uint ase_vertexID : SV_VertexID;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float _Frequency;
			float _OffsetAmount;
			float _IsSplatRenderMaterial;
			int _DitherTextureSize;
			float _RandomDither;
			float _AlphaCutoutThreshold;
			float _Dithering;
			#ifdef _TRANSMISSION_ASE
				float _TransmissionShadow;
			#endif
			#ifdef _TRANSLUCENCY_ASE
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _MainTex;
			sampler2D _DitherTexture;


			float3 MudBunSplatPoint( int VertexID, out float3 PositionLs, out float3 NormalWs, out float3 NormalLs, out float3 TangentWs, out float3 TangentLs, out float3 CenterWs, out float3 CenterLs, out float4 Color, out float4 EmissionHash, out float Metallic, out float Smoothness, out float2 Tex, out float4 TextureWeight, out float SdfValue, out float3 Outward2dNormalLs, out float3 Outward2dNormalWs )
			{
				float4 positionWs;
				float2 metallicSmoothness;
				mudbun_splat_vert(VertexID, positionWs, PositionLs, NormalWs, NormalLs, TangentWs, TangentLs, CenterWs, CenterLs, Color, EmissionHash, metallicSmoothness, Tex, TextureWeight, SdfValue, Outward2dNormalLs, Outward2dNormalWs);
				Metallic = metallicSmoothness.x;
				Smoothness = metallicSmoothness.y;
				return positionWs.xyz;
			}
			
			float3 SimplexNoiseGradient6_g279( float3 Position, float Size )
			{
				#ifdef MUDBUN_VALID
				return snoise_grad(Position / max(1e-6, Size)).xyz;
				#else
				return Position;
				#endif
			}
			
			float3 SimplexNoiseGradient6_g280( float3 Position, float Size )
			{
				#ifdef MUDBUN_VALID
				return snoise_grad(Position / max(1e-6, Size)).xyz;
				#else
				return Position;
				#endif
			}
			

			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );

				int VertexID5_g25 = v.ase_vertexID;
				float3 PositionLs5_g25 = float3( 0,0,0 );
				float3 NormalWs5_g25 = float3( 0,0,0 );
				float3 NormalLs5_g25 = float3( 0,0,0 );
				float3 TangentWs5_g25 = float3( 0,0,0 );
				float3 TangentLs5_g25 = float3( 0,0,0 );
				float3 CenterWs5_g25 = float3( 0,0,0 );
				float3 CenterLs5_g25 = float3( 0,0,0 );
				float4 Color5_g25 = float4( 0,0,0,0 );
				float4 EmissionHash5_g25 = float4( 0,0,0,0 );
				float Metallic5_g25 = 0.0;
				float Smoothness5_g25 = 0.0;
				float2 Tex5_g25 = float2( 0,0 );
				float4 TextureWeight5_g25 = float4( 1,0,0,0 );
				float SdfValue5_g25 = 0.0;
				float3 Outward2dNormalLs5_g25 = float3( 0,0,0 );
				float3 Outward2dNormalWs5_g25 = float3( 0,0,0 );
				float3 localMudBunSplatPoint5_g25 = MudBunSplatPoint( VertexID5_g25 , PositionLs5_g25 , NormalWs5_g25 , NormalLs5_g25 , TangentWs5_g25 , TangentLs5_g25 , CenterWs5_g25 , CenterLs5_g25 , Color5_g25 , EmissionHash5_g25 , Metallic5_g25 , Smoothness5_g25 , Tex5_g25 , TextureWeight5_g25 , SdfValue5_g25 , Outward2dNormalLs5_g25 , Outward2dNormalWs5_g25 );
				float3 temp_output_183_21 = localMudBunSplatPoint5_g25;
				float3 temp_output_183_52 = TangentWs5_g25;
				float3 Position6_g279 = CenterWs5_g25;
				float Size6_g279 = 0.1;
				float3 localSimplexNoiseGradient6_g279 = SimplexNoiseGradient6_g279( Position6_g279 , Size6_g279 );
				float3 Position6_g280 = ( float3( 0,0,0 ) + ( _TimeParameters.x * _Frequency ) + ( localSimplexNoiseGradient6_g279 * 1.0 ) );
				float Size6_g280 = 0.5;
				float3 localSimplexNoiseGradient6_g280 = SimplexNoiseGradient6_g280( Position6_g280 , Size6_g280 );
				float3 temp_output_215_0 = ( localSimplexNoiseGradient6_g280 * _OffsetAmount );
				float3 temp_output_183_28 = NormalWs5_g25;
				
				float2 vertexToFrag34_g25 = Tex5_g25;
				o.ase_texcoord2.xy = vertexToFrag34_g25;
				float4 vertexToFrag3_g25 = Color5_g25;
				o.ase_texcoord3 = vertexToFrag3_g25;
				float3 vertexToFrag20_g25 = localMudBunSplatPoint5_g25;
				o.ase_texcoord4.xyz = vertexToFrag20_g25;
				float3 vertexToFrag27_g281 = temp_output_183_21;
				o.ase_texcoord5.xyz = vertexToFrag27_g281;
				
				o.ase_texcoord2.z = v.ase_vertexID;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord2.w = 0;
				o.ase_texcoord4.w = 0;
				o.ase_texcoord5.w = 0;
				
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = ( temp_output_183_21 + ( temp_output_183_52 * (temp_output_215_0).x ) + ( cross( temp_output_183_28 , temp_output_183_52 ) * (temp_output_215_0).z ) );
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = temp_output_183_28;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float4 positionCS = TransformWorldToHClip( positionWS );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = positionCS;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				o.clipPos = positionCS;
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				uint ase_vertexID : SV_VertexID;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.vertex = v.vertex;
				o.ase_vertexID = v.ase_vertexID;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_vertexID = patch[0].ase_vertexID * bary.x + patch[1].ase_vertexID * bary.y + patch[2].ase_vertexID * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float2 vertexToFrag34_g25 = IN.ase_texcoord2.xy;
				float2 clampResult36_g25 = clamp( ( vertexToFrag34_g25 + float2( 0.5,0.5 ) ) , float2( 0,0 ) , float2( 1,1 ) );
				float4 vertexToFrag3_g25 = IN.ase_texcoord3;
				float4 temp_output_7_0_g25 = ( _Color * vertexToFrag3_g25 * _IsSplatRenderMaterial );
				float4 temp_output_124_0 = ( tex2D( _MainTex, clampResult36_g25 ) * temp_output_7_0_g25 );
				float localComputeOpaqueTransparency20_g281 = ( 0.0 );
				float3 vertexToFrag20_g25 = IN.ase_texcoord4.xyz;
				float4 unityObjectToClipPos17_g25 = TransformWorldToHClip(TransformObjectToWorld(vertexToFrag20_g25));
				float4 computeScreenPos18_g25 = ComputeScreenPos( unityObjectToClipPos17_g25 );
				float2 ScreenPos20_g281 = (( ( computeScreenPos18_g25 / (computeScreenPos18_g25).w ) * _ScreenParams )).xy;
				float3 vertexToFrag27_g281 = IN.ase_texcoord5.xyz;
				float3 VertPos20_g281 = vertexToFrag27_g281;
				int VertexID5_g25 = IN.ase_texcoord2.z;
				float3 PositionLs5_g25 = float3( 0,0,0 );
				float3 NormalWs5_g25 = float3( 0,0,0 );
				float3 NormalLs5_g25 = float3( 0,0,0 );
				float3 TangentWs5_g25 = float3( 0,0,0 );
				float3 TangentLs5_g25 = float3( 0,0,0 );
				float3 CenterWs5_g25 = float3( 0,0,0 );
				float3 CenterLs5_g25 = float3( 0,0,0 );
				float4 Color5_g25 = float4( 0,0,0,0 );
				float4 EmissionHash5_g25 = float4( 0,0,0,0 );
				float Metallic5_g25 = 0.0;
				float Smoothness5_g25 = 0.0;
				float2 Tex5_g25 = float2( 0,0 );
				float4 TextureWeight5_g25 = float4( 1,0,0,0 );
				float SdfValue5_g25 = 0.0;
				float3 Outward2dNormalLs5_g25 = float3( 0,0,0 );
				float3 Outward2dNormalWs5_g25 = float3( 0,0,0 );
				float3 localMudBunSplatPoint5_g25 = MudBunSplatPoint( VertexID5_g25 , PositionLs5_g25 , NormalWs5_g25 , NormalLs5_g25 , TangentWs5_g25 , TangentLs5_g25 , CenterWs5_g25 , CenterLs5_g25 , Color5_g25 , EmissionHash5_g25 , Metallic5_g25 , Smoothness5_g25 , Tex5_g25 , TextureWeight5_g25 , SdfValue5_g25 , Outward2dNormalLs5_g25 , Outward2dNormalWs5_g25 );
				float Hash20_g281 = (EmissionHash5_g25).w;
				float ifLocalVar62_g25 = 0;
				UNITY_BRANCH 
				if( length( vertexToFrag34_g25 ) <= 0.5 )
				ifLocalVar62_g25 = 1.0;
				else
				ifLocalVar62_g25 = 0.0;
				#ifdef MUDBUN_QUAD_SPLATS
				float staticSwitch50_g25 = 1.0;
				#else
				float staticSwitch50_g25 = ifLocalVar62_g25;
				#endif
				float AlphaIn20_g281 = ( (temp_output_7_0_g25).a * staticSwitch50_g25 );
				float AlphaOut20_g281 = 0;
				float AlphaThreshold20_g281 = 0;
				sampler2D DitherNoiseTexture20_g281 = _DitherTexture;
				int DitherNoiseTextureSize20_g281 = _DitherTextureSize;
				int UseRandomDither20_g281 = (int)_RandomDither;
				float AlphaCutoutThreshold20_g281 = _AlphaCutoutThreshold;
				float DitherBlend20_g281 = _Dithering;
				{
				float alpha = AlphaIn20_g281;
				computeOpaqueTransparency(ScreenPos20_g281, VertPos20_g281, Hash20_g281, DitherNoiseTexture20_g281, DitherNoiseTextureSize20_g281, UseRandomDither20_g281 > 0, AlphaCutoutThreshold20_g281, DitherBlend20_g281,  alpha, AlphaThreshold20_g281);
				AlphaOut20_g281 = alpha;
				}
				float temp_output_197_0 = ( (temp_output_124_0).a * AlphaOut20_g281 );
				float temp_output_119_25 = AlphaThreshold20_g281;
				clip( temp_output_197_0 - temp_output_119_25);
				
				
				float3 Albedo = temp_output_124_0.rgb;
				float Alpha = temp_output_197_0;
				float AlphaClipThreshold = temp_output_119_25;

				half4 color = half4( Albedo, Alpha );

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				return color;
			}
			ENDHLSL
		}
		
	}
	/*ase_lod*/
	
	Fallback "Hidden/InternalErrorShader"
	
}
/*ASEBEGIN
Version=18800
-1569;255;1302;771;807.5094;-26.69476;1.730734;True;False
Node;AmplifyShaderEditor.FunctionNode;183;0,-352;Inherit;False;Mud Splat;0;;25;1947d49d4d7bb92419410ba0439aa2bc;0;0;20;COLOR;22;FLOAT2;29;FLOAT;24;FLOAT3;27;FLOAT;26;FLOAT;23;FLOAT4;45;FLOAT3;21;FLOAT3;43;FLOAT3;28;FLOAT3;42;FLOAT3;52;FLOAT3;53;FLOAT3;60;FLOAT3;61;FLOAT3;68;FLOAT3;67;FLOAT;66;FLOAT2;25;FLOAT;57
Node;AmplifyShaderEditor.SimpleTimeNode;210;0,352;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;211;0,448;Inherit;False;Property;_Frequency;Frequency;6;0;Create;True;0;0;0;False;0;False;0.1;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;213;352,224;Inherit;False;Mud Noise Gradient;-1;;279;ded4656e0e0531448b1f2a26fd64d584;0;3;2;FLOAT3;0,0,0;False;5;FLOAT;0.1;False;7;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;212;416,352;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;29;384,-640;Inherit;True;Property;_MainTex;Albedo;8;0;Create;False;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RangedFloatNode;220;0,544;Inherit;False;Property;_OffsetAmount;Offset Amount;7;0;Create;True;0;0;0;False;0;False;0.01;0.01;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;214;624,272;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;193;768,-544;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;122;16,1264;Inherit;False;Property;_Dithering;Dithering;11;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;196;16,976;Inherit;False;Property;_DitherTextureSize;Dither Texture Size;12;0;Create;True;0;0;0;False;0;False;256;256;False;0;1;INT;0
Node;AmplifyShaderEditor.TexturePropertyNode;195;16,752;Inherit;True;Property;_DitherTexture;Dither Texture;10;0;Create;True;0;0;0;False;0;False;f240bbb7854046345b218811e5681a54;f240bbb7854046345b218811e5681a54;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;124;1152,-416;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;215;800,304;Inherit;False;Mud Noise Gradient;-1;;280;ded4656e0e0531448b1f2a26fd64d584;0;3;2;FLOAT3;0,0,0;False;5;FLOAT;0.5;False;7;FLOAT;0.1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;123;16,1168;Inherit;False;Property;_AlphaCutoutThreshold;Alpha Cutout Threshold;9;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;194;16,1072;Inherit;False;Property;_RandomDither;Random Dither;13;1;[Toggle];Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;133;1344,-304;Inherit;False;False;False;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;216;1088,384;Inherit;False;False;False;True;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CrossProductOpNode;221;896,528;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;119;640,656;Inherit;False;Mud Alpha Threshold;-1;;281;926535703f4c32948ac1f55275a22bf0;0;9;8;FLOAT2;0,0;False;15;FLOAT3;0,0,0;False;18;FLOAT;0;False;22;FLOAT;0;False;19;SAMPLER2D;0;False;26;INT;256;False;9;INT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;2;FLOAT;24;FLOAT;25
Node;AmplifyShaderEditor.ComponentMaskNode;217;1088,256;Inherit;False;True;False;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;197;1600,-288;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;218;1360,384;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;219;1360,256;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClipNode;198;1865.599,-332.7999;Inherit;False;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;209;1792,240;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;192;2144,-288;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;2;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Universal2D;0;5;Universal2D;0;False;False;False;False;False;False;False;False;True;0;False;-1;True;0;False;-1;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;0;True;1;1;False;-1;0;False;-1;1;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;-1;False;False;False;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;LightMode=Universal2D;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;189;2144,-288;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;2;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;True;0;False;-1;True;0;False;-1;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;0;False;False;False;False;False;False;False;False;True;0;False;-1;False;False;False;False;False;False;True;1;False;-1;True;3;False;-1;False;True;1;LightMode=ShadowCaster;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;187;1824,-256;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;2;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ExtraPrePass;0;0;ExtraPrePass;5;False;False;False;False;False;False;False;False;True;0;False;-1;True;0;False;-1;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;0;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;True;0;False;-1;True;True;True;True;True;0;False;-1;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;0;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;188;2112,-256;Float;False;True;-1;2;;0;2;MudBun/Floater Splat (URP);94348b07e5e8bab40bd6c8a1e3df54cd;True;Forward;0;1;Forward;17;False;False;False;False;False;False;False;False;True;0;False;-1;True;0;False;-1;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;4;0;True;1;1;False;-1;0;False;-1;1;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;-1;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;LightMode=UniversalForward;False;0;Hidden/InternalErrorShader;0;0;Standard;36;Workflow;1;Surface;0;  Refraction Model;0;  Blend;0;Two Sided;1;Fragment Normal Space,InvertActionOnDeselection;0;Transmission;0;  Transmission Shadow;0.5,False,-1;Translucency;0;  Translucency Strength;1,False,-1;  Normal Distortion;0.5,False,-1;  Scattering;2,False,-1;  Direct;0.9,False,-1;  Ambient;0.1,False,-1;  Shadow;0.5,False,-1;Cast Shadows;1;  Use Shadow Threshold;0;Receive Shadows;1;GPU Instancing;1;LOD CrossFade;1;Built-in Fog;1;_FinalColorxAlpha;0;Meta Pass;1;Override Baked GI;0;Extra Pre Pass;0;DOTS Instancing;0;Tessellation;0;  Phong;0;  Strength;0.5,False,-1;  Type;0;  Tess;16,False,-1;  Min;10,False,-1;  Max;25,False,-1;  Edge Length;16,False,-1;  Max Displacement;25,False,-1;Vertex Position,InvertActionOnDeselection;0;0;6;False;True;True;True;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;191;2144,-288;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;2;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Meta;0;4;Meta;0;False;False;False;False;False;False;False;False;True;0;False;-1;True;0;False;-1;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;0;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;190;2144,-288;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;2;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;DepthOnly;0;3;DepthOnly;0;False;False;False;False;False;False;False;False;True;0;False;-1;True;0;False;-1;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;0;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;False;False;False;False;0;False;-1;False;False;False;False;True;1;False;-1;False;False;True;1;LightMode=DepthOnly;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
WireConnection;213;2;183;60
WireConnection;212;0;210;0
WireConnection;212;1;211;0
WireConnection;214;1;212;0
WireConnection;214;2;213;0
WireConnection;193;0;29;0
WireConnection;193;1;183;29
WireConnection;124;0;193;0
WireConnection;124;1;183;22
WireConnection;215;2;214;0
WireConnection;215;7;220;0
WireConnection;133;0;124;0
WireConnection;216;0;215;0
WireConnection;221;0;183;28
WireConnection;221;1;183;52
WireConnection;119;8;183;25
WireConnection;119;15;183;21
WireConnection;119;18;183;57
WireConnection;119;22;183;24
WireConnection;119;19;195;0
WireConnection;119;26;196;0
WireConnection;119;9;194;0
WireConnection;119;6;123;0
WireConnection;119;7;122;0
WireConnection;217;0;215;0
WireConnection;197;0;133;0
WireConnection;197;1;119;24
WireConnection;218;0;221;0
WireConnection;218;1;216;0
WireConnection;219;0;183;52
WireConnection;219;1;217;0
WireConnection;198;0;124;0
WireConnection;198;1;197;0
WireConnection;198;2;119;25
WireConnection;209;0;183;21
WireConnection;209;1;219;0
WireConnection;209;2;218;0
WireConnection;188;0;198;0
WireConnection;188;2;183;27
WireConnection;188;3;183;26
WireConnection;188;4;183;23
WireConnection;188;6;197;0
WireConnection;188;7;119;25
WireConnection;188;8;209;0
WireConnection;188;10;183;28
ASEEND*/
//CHKSM=5D414625F846FFA65CB4D9361AAA246562039E69