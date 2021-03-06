// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MudBun/Mud Mesh Multi-Textured (HDRP)"
{
	Properties
	{
		[HideInInspector] _EmissionColor("Emission Color", Color) = (1,1,1,1)
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[HideInInspector]_Color("Color", Color) = (1,1,1,1)
		[HideInInspector]_Emission("Emission", Color) = (1,1,1,1)
		[HideInInspector]_Metallic("Metallic", Range( 0 , 1)) = 0
		[HideInInspector]_Smoothness("Smoothness", Range( 0 , 1)) = 1
		[HideInInspector]_IsMeshRenderMaterial("Is Mesh Render Material", Float) = 1
		[ASEBegin]_AlphaCutoutThreshold("Alpha Cutout Threshold", Range( 0 , 1)) = 0
		_Dithering("Dithering", Range( 0 , 1)) = 1
		[Toggle]_RandomDither("Random Dither", Range( 0 , 1)) = 0
		[Toggle]_UseTex0("Use Texture 0", Float) = 0
		_MainTex("Texture 0", 2D) = "white" {}
		[Toggle]_MainTexX("Project Texture 0 X", Float) = 1
		_DitherTexture("Dither Texture", 2D) = "white" {}
		[Toggle]_MainTexY("Project Texture 0 Y", Float) = 1
		_DitherTextureSize("Dither Texture Size", Int) = 256
		[Toggle]_MainTexZ("Project Texture 0 Z", Float) = 1
		[Toggle]_UseTex1("Use Texture 1", Float) = 0
		_Tex1("Texture 1", 2D) = "white" {}
		[Toggle]_Tex1X("Project Texture 1 X", Float) = 1
		[Toggle]_Tex1Y("Project Texture 1 Y", Float) = 1
		[Toggle]_Tex1Z("Project Texture 1 Z", Float) = 1
		[Toggle]_UseTex2("Use Texture 2", Float) = 0
		_Tex2("Texture 2", 2D) = "white" {}
		[Toggle]_Tex2X("Project Texture 2 X", Float) = 1
		[Toggle]_Tex2Y("Project Texture 2 Y", Float) = 1
		[Toggle]_Tex2Z("Project Texture 2 Z", Float) = 1
		[Toggle]_UseTex3("Use Texture 3", Float) = 0
		_Tex3("Texture 3", 2D) = "white" {}
		[Toggle]_Tex3X("Project Texture 3 X", Float) = 1
		[Toggle]_Tex3Y("Project Texture 3 Y", Float) = 1
		[ASEEnd][Toggle]_Tex3Z("Project Texture 3 Z", Float) = 1

		[HideInInspector] _RenderQueueType("Render Queue Type", Float) = 1
		[HideInInspector] [ToggleUI] _AddPrecomputedVelocity("Add Precomputed Velocity", Float) = 1
		[HideInInspector] _StencilRef("Stencil Ref", Int) = 0
		[HideInInspector] _StencilWriteMask("Stencil Write Mask", Int) = 6
		[HideInInspector] _StencilRefDepth("Stencil Ref Depth", Int) = 8
		[HideInInspector] _StencilWriteMaskDepth("Stencil Write Mask Depth", Int) = 8
		[HideInInspector] _StencilRefMV("Stencil Ref MV", Int) = 40
		[HideInInspector] _StencilWriteMaskMV("Stencil Write Mask MV", Int) = 40
		[HideInInspector] _StencilRefDistortionVec("Stencil Ref Distortion Vec", Int) = 4
		[HideInInspector] _StencilWriteMaskDistortionVec("Stencil Write Mask Distortion Vec", Int) = 4
		[HideInInspector] _StencilWriteMaskGBuffer("Stencil Write Mask GBuffer", Int) = 14
		[HideInInspector] _StencilRefGBuffer("Stencil Ref GBuffer", Int) = 10
		[HideInInspector] _ZTestGBuffer("ZTest GBuffer", Int) = 4
		[HideInInspector] [ToggleUI] _RequireSplitLighting("Require Split Lighting", Float) = 0
		[HideInInspector] [ToggleUI] _ReceivesSSR("Receives SSR", Float) = 1
		[HideInInspector] _SurfaceType("Surface Type", Float) = 0
		[HideInInspector] _BlendMode("Blend Mode", Float) = 0
		[HideInInspector] _SrcBlend("Src Blend", Float) = 1
		[HideInInspector] _DstBlend("Dst Blend", Float) = 0
		[HideInInspector] _AlphaSrcBlend("Alpha Src Blend", Float) = 1
		[HideInInspector] _AlphaDstBlend("Alpha Dst Blend", Float) = 0
		[HideInInspector] [ToggleUI] _ZWrite("ZWrite", Float) = 1
		[HideInInspector] [ToggleUI] _TransparentZWrite("Transparent ZWrite", Float) = 1
		[HideInInspector] _CullMode("Cull Mode", Float) = 2
		[HideInInspector] _TransparentSortPriority("Transparent Sort Priority", Int) = 0
		[HideInInspector] [ToggleUI] _EnableFogOnTransparent("Enable Fog On Transparent", Float) = 1
		[HideInInspector] _CullModeForward("Cull Mode Forward", Float) = 2
		[HideInInspector] [Enum(Front, 1, Back, 2)] _TransparentCullMode("Transparent Cull Mode", Float) = 2
		[HideInInspector] _ZTestDepthEqualForOpaque("ZTest Depth Equal For Opaque", Int) = 4
		[HideInInspector] [Enum(UnityEngine.Rendering.CompareFunction)] _ZTestTransparent("ZTest Transparent", Float) = 4
		[HideInInspector] [ToggleUI] _TransparentBackfaceEnable("Transparent Backface Enable", Float) = 0
		[HideInInspector] [ToggleUI] _AlphaCutoffEnable("Alpha Cutoff Enable", Float) = 1
		[HideInInspector] [ToggleUI] _UseShadowThreshold("Use Shadow Threshold", Float) = 0
		[HideInInspector] [ToggleUI] _DoubleSidedEnable("Double Sided Enable", Float) = 0
		[HideInInspector] [Enum(Flip, 0, Mirror, 1, None, 2)] _DoubleSidedNormalMode("Double Sided Normal Mode", Float) = 2
		[HideInInspector] _DoubleSidedConstants("DoubleSidedConstants", Vector) = (1,1,-1,0)
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

		

		Tags { "RenderPipeline"="HDRenderPipeline" "RenderType"="Opaque" "Queue"="Geometry" }

		HLSLINCLUDE
		#pragma target 4.5
		#pragma only_renderers d3d11 ps4 xboxone vulkan metal switch
		#pragma multi_compile_instancing
		#pragma instancing_options renderinglayer

		struct GlobalSurfaceDescription // GBuffer Forward META TransparentBackface
		{
			float3 Albedo;
			float3 Normal;
			float3 BentNormal;
			float3 Specular;
			float CoatMask;
			float Metallic;
			float3 Emission;
			float Smoothness;
			float Occlusion;
			float Alpha;
			float AlphaClipThreshold;
			float AlphaClipThresholdShadow;
			float AlphaClipThresholdDepthPrepass;
			float AlphaClipThresholdDepthPostpass;
			float SpecularAAScreenSpaceVariance;
			float SpecularAAThreshold;
			float SpecularOcclusion;
			float DepthOffset;
			//Refraction
			float RefractionIndex;
			float3 RefractionColor;
			float RefractionDistance;
			//SSS/Translucent
			float Thickness;
			float SubsurfaceMask;
			float DiffusionProfile;
			//Anisotropy
			float Anisotropy;
			float3 Tangent;
			//Iridescent
			float IridescenceMask;
			float IridescenceThickness;
			//BakedGI
			float3 BakedGI;
			float3 BakedBackGI;
		};

		struct AlphaSurfaceDescription // ShadowCaster
		{
			float Alpha;
			float AlphaClipThreshold;
			float AlphaClipThresholdShadow;
			float DepthOffset;
		};

		struct SceneSurfaceDescription // SceneSelection
		{
			float Alpha;
			float AlphaClipThreshold;
			float DepthOffset;
		};

		struct PrePassSurfaceDescription // DepthPrePass
		{
			float Alpha;
			float AlphaClipThresholdDepthPrepass;
			float DepthOffset;
		};

		struct PostPassSurfaceDescription //DepthPostPass
		{
			float Alpha;
			float AlphaClipThresholdDepthPostpass;
			float DepthOffset;
		};

		struct SmoothSurfaceDescription // MotionVectors DepthOnly
		{
			float3 Normal;
			float Smoothness;
			float Alpha;
			float AlphaClipThreshold;
			float DepthOffset;
		};

		struct DistortionSurfaceDescription //Distortion
		{
			float Alpha;
			float2 Distortion;
			float DistortionBlur;
			float AlphaClipThreshold;
		};

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

		float DistanceFromPlaneASE (float3 pos, float4 plane)
		{
			return dot (float4(pos,1.0f), plane);
		}

		bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
		{
			float4 planeTest;
			planeTest.x = (( DistanceFromPlaneASE(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.y = (( DistanceFromPlaneASE(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.z = (( DistanceFromPlaneASE(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.w = (( DistanceFromPlaneASE(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
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
			
			Name "GBuffer"
			Tags { "LightMode"="GBuffer" }

			Cull [_CullMode]
			ZTest [_ZTestGBuffer]

			Stencil
			{
				Ref [_StencilRefGBuffer]
				WriteMask [_StencilWriteMaskGBuffer]
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}


			HLSLPROGRAM

			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define HAVE_MESH_MODIFICATION
			#define ASE_SRP_VERSION 70301


			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _DOUBLESIDED_ON
			#pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
			#pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT
			#pragma shader_feature_local _ALPHATEST_ON

			#if !defined(DEBUG_DISPLAY) && defined(_ALPHATEST_ON)
			#define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
			#endif

			#define SHADERPASS SHADERPASS_GBUFFER
			#pragma multi_compile _ DEBUG_DISPLAY
			#pragma multi_compile _ LIGHTMAP_ON
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ DYNAMICLIGHTMAP_ON
			#pragma multi_compile _ SHADOWS_SHADOWMASK
			#pragma multi_compile DECALS_OFF DECALS_3RT DECALS_4RT
			#pragma multi_compile _ LIGHT_LAYERS

			#pragma vertex Vert
			#pragma fragment Frag

			//#define UNITY_MATERIAL_LIT

			#if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
			#endif

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#ifdef DEBUG_DISPLAY
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
			#endif
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define SHADER_GRAPH
			#pragma multi_compile _ MUDBUN_PROCEDURAL
			#include "Assets/MudBun/Shader/Render/ShaderCommon.cginc"
			#include "Assets/MudBun/Shader/Render/MeshCommon.cginc"


			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
				#define ASE_NEED_CULLFACE 1
			#endif

			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				uint ase_vertexID : SV_VertexID;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				float4 positionCS : SV_Position;
				float3 interp00 : TEXCOORD0;
				float3 interp01 : TEXCOORD1;
				float4 interp02 : TEXCOORD2;
				float4 interp03 : TEXCOORD3;
				float4 interp04 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_texcoord9 : TEXCOORD9;
				float4 ase_texcoord10 : TEXCOORD10;
				float4 ase_texcoord11 : TEXCOORD11;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			CBUFFER_START( UnityPerMaterial )
			float _UseTex0;
			float _RandomDither;
			int _DitherTextureSize;
			float _IsMeshRenderMaterial;
			float _Tex3Z;
			float _Tex3Y;
			float _Tex3X;
			float _Tex2Z;
			float _Tex2Y;
			float _AlphaCutoutThreshold;
			float _Tex2X;
			float _Tex1Y;
			float _Tex1X;
			float _MainTexZ;
			float _MainTexY;
			float _MainTexX;
			float _UseTex3;
			float _UseTex2;
			float _UseTex1;
			float _Tex1Z;
			float _Dithering;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
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
			sampler2D _Tex1;
			sampler2D _Tex2;
			sampler2D _Tex3;
			sampler2D _DitherTexture;


			float3 MudBunMeshPoint( int VertexID, out float3 PositionLs, out float3 NormalWs, out float3 NormalLs, out float4 Color, out float4 EmissionHash, out float Metallic, out float Smoothness, out float4 TextureWeight, out float SdfValue, out float3 Outward2dNormalLs, out float3 Outward2dNormalWs )
			{
				float4 positionWs;
				float2 metallicSmoothness;
				mudbun_mesh_vert(VertexID, positionWs, PositionLs, NormalWs, NormalLs, Color, EmissionHash, metallicSmoothness, TextureWeight, SdfValue, Outward2dNormalLs, Outward2dNormalWs);
				Metallic = metallicSmoothness.x;
				Smoothness = metallicSmoothness.y;
				return positionWs.xyz;
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout GlobalSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				// surface data
				surfaceData.baseColor =					surfaceDescription.Albedo;
				surfaceData.perceptualSmoothness =		surfaceDescription.Smoothness;
				surfaceData.ambientOcclusion =			surfaceDescription.Occlusion;
				surfaceData.metallic =					surfaceDescription.Metallic;
				surfaceData.coatMask =					surfaceDescription.CoatMask;

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceData.specularOcclusion =			surfaceDescription.SpecularOcclusion;
				#endif
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.subsurfaceMask =			surfaceDescription.SubsurfaceMask;
				#endif
				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceData.thickness =					surfaceDescription.Thickness;
				#endif
				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceData.diffusionProfileHash =		asuint(surfaceDescription.DiffusionProfile);
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.specularColor =				surfaceDescription.Specular;
				#endif
				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.anisotropy =				surfaceDescription.Anisotropy;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.iridescenceMask =			surfaceDescription.IridescenceMask;
				surfaceData.iridescenceThickness =		surfaceDescription.IridescenceThickness;
				#endif

				// refraction
				#ifdef _HAS_REFRACTION
				if( _EnableSSRefraction )
				{
					surfaceData.ior = surfaceDescription.RefractionIndex;
					surfaceData.transmittanceColor = surfaceDescription.RefractionColor;
					surfaceData.atDistance = surfaceDescription.RefractionDistance;

					surfaceData.transmittanceMask = ( 1.0 - surfaceDescription.Alpha );
					surfaceDescription.Alpha = 1.0;
				}
				else
				{
					surfaceData.ior = 1.0;
					surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
					surfaceData.atDistance = 1.0;
					surfaceData.transmittanceMask = 0.0;
					surfaceDescription.Alpha = 1.0;
				}
				#else
				surfaceData.ior = 1.0;
				surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
				surfaceData.atDistance = 1.0;
				surfaceData.transmittanceMask = 0.0;
				#endif


				// material features
				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif
				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif
				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
				#endif
				#ifdef ASE_LIT_CLEAR_COAT
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				// others
				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
				surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif
				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				// normals
				float3 normalTS = float3(0.0f, 0.0f, 1.0f);
				normalTS = surfaceDescription.Normal;
				GetNormalWS( fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants );

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];

				bentNormalWS = surfaceData.normalWS;
				#ifdef ASE_BENT_NORMAL
				GetNormalWS( fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants );
				#endif

				surfaceData.tangentWS = normalize( fragInputs.tangentToWorld[ 0 ].xyz );
				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.tangentWS = TransformTangentToWorld( surfaceDescription.Tangent, fragInputs.tangentToWorld );
				#endif
				surfaceData.tangentWS = Orthonormalize( surfaceData.tangentWS, surfaceData.normalWS );

				// decals
				#if HAVE_DECALS
				if( _EnableDecals )
				{
					DecalSurfaceData decalSurfaceData = GetDecalSurfaceData( posInput, surfaceDescription.Alpha );
					ApplyDecalToSurfaceData( decalSurfaceData, surfaceData );
				}
				#endif

				#if defined(_SPECULAR_OCCLUSION_CUSTOM)
				#elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO( V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness( surfaceData.perceptualSmoothness ) );
				#elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion( ClampNdotV( dot( surfaceData.normalWS, V ) ), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness( surfaceData.perceptualSmoothness ) );
				#endif

				#ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
				surfaceData.perceptualSmoothness = GeometricNormalFiltering( surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[ 2 ], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold );
				#endif

				// debug
				#if defined(DEBUG_DISPLAY)
				if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
				{
					surfaceData.metallic = 0;
				}
				ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
				#endif
			}

			void GetSurfaceAndBuiltinData(GlobalSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
				LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				ApplyDoubleSidedFlipOrMirror( fragInputs, doubleSidedConstants );

				#ifdef _ALPHATEST_ON
				DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
				builtinData.depthOffset = surfaceDescription.DepthOffset;
				ApplyDepthOffsetPositionInput( V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput );
				#endif

				float3 bentNormalWS;
				BuildSurfaceData( fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS );

				InitBuiltinData( posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[ 2 ], fragInputs.texCoord1, fragInputs.texCoord2, builtinData );

				#ifdef _ASE_BAKEDGI
				builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
				#endif
				#ifdef _ASE_BAKEDBACKGI
				builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
				#endif

				builtinData.emissiveColor = surfaceDescription.Emission;

				#if (SHADERPASS == SHADERPASS_DISTORTION)
				builtinData.distortion = surfaceDescription.Distortion;
				builtinData.distortionBlur = surfaceDescription.DistortionBlur;
				#else
				builtinData.distortion = float2(0.0, 0.0);
				builtinData.distortionBlur = 0.0;
				#endif

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh )
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				int VertexID4_g83 = inputMesh.ase_vertexID;
				float3 PositionLs4_g83 = float3( 0,0,0 );
				float3 NormalWs4_g83 = float3( 0,0,0 );
				float3 NormalLs4_g83 = float3( 0,0,0 );
				float4 Color4_g83 = float4( 0,0,0,0 );
				float4 EmissionHash4_g83 = float4( 0,0,0,0 );
				float Metallic4_g83 = 0.0;
				float Smoothness4_g83 = 0.0;
				float4 TextureWeight4_g83 = float4( 1,0,0,0 );
				float SdfValue4_g83 = 0.0;
				float3 Outward2dNormalLs4_g83 = float3( 0,0,0 );
				float3 Outward2dNormalWs4_g83 = float3( 0,0,0 );
				float3 localMudBunMeshPoint4_g83 = MudBunMeshPoint( VertexID4_g83 , PositionLs4_g83 , NormalWs4_g83 , NormalLs4_g83 , Color4_g83 , EmissionHash4_g83 , Metallic4_g83 , Smoothness4_g83 , TextureWeight4_g83 , SdfValue4_g83 , Outward2dNormalLs4_g83 , Outward2dNormalWs4_g83 );
				float3 temp_output_198_0 = localMudBunMeshPoint4_g83;
				
				float3 vertexToFrag213 = NormalLs4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord5.xyz = vertexToFrag213;
				float3 vertexToFrag212 = PositionLs4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord6.xyz = vertexToFrag212;
				float4 vertexToFrag216 = TextureWeight4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord7 = vertexToFrag216;
				float4 vertexToFrag5_g83 = Color4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord8 = vertexToFrag5_g83;
				float3 vertexToFrag16_g83 = localMudBunMeshPoint4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord9.xyz = vertexToFrag16_g83;
				float3 vertexToFrag27_g228 = temp_output_198_0;
				outputPackedVaryingsMeshToPS.ase_texcoord10.xyz = vertexToFrag27_g228;
				
				float vertexToFrag8_g83 = Metallic4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord6.w = vertexToFrag8_g83;
				
				float3 vertexToFrag6_g83 = (EmissionHash4_g83).xyz;
				outputPackedVaryingsMeshToPS.ase_texcoord11.xyz = vertexToFrag6_g83;
				
				float vertexToFrag7_g83 = Smoothness4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord9.w = vertexToFrag7_g83;
				
				outputPackedVaryingsMeshToPS.ase_texcoord5.w = inputMesh.ase_vertexID;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord10.w = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord11.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = temp_output_198_0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS = NormalWs4_g83;
				inputMesh.tangentOS =  inputMesh.tangentOS ;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);
				float4 tangentWS = float4(TransformObjectToWorldDir(inputMesh.tangentOS.xyz), inputMesh.tangentOS.w);

				outputPackedVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
				outputPackedVaryingsMeshToPS.interp00.xyz = positionRWS;
				outputPackedVaryingsMeshToPS.interp01.xyz = normalWS;
				outputPackedVaryingsMeshToPS.interp02.xyzw = tangentWS;
				outputPackedVaryingsMeshToPS.interp03.xyzw = inputMesh.uv1;
				outputPackedVaryingsMeshToPS.interp04.xyzw = inputMesh.uv2;
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				uint ase_vertexID : SV_VertexID;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.uv1 = v.uv1;
				o.uv2 = v.uv2;
				o.ase_vertexID = v.ase_vertexID;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
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
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.uv1 = patch[0].uv1 * bary.x + patch[1].uv1 * bary.y + patch[2].uv1 * bary.z;
				o.uv2 = patch[0].uv2 * bary.x + patch[1].uv2 * bary.y + patch[2].uv2 * bary.z;
				o.ase_vertexID = patch[0].ase_vertexID * bary.x + patch[1].ase_vertexID * bary.y + patch[2].ase_vertexID * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			void Frag( PackedVaryingsMeshToPS packedInput,
						OUTPUT_GBUFFER(outGBuffer)
						#ifdef _DEPTHOFFSET_ON
						, out float outputDepth : SV_Depth
						#endif
						
						)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				UNITY_SETUP_INSTANCE_ID( packedInput );
				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.tangentToWorld = k_identity3x3;
				float3 positionRWS = packedInput.interp00.xyz;
				float3 normalWS = packedInput.interp01.xyz;
				float4 tangentWS = packedInput.interp02.xyzw;

				input.positionSS = packedInput.positionCS;
				input.positionRWS = positionRWS;
				input.tangentToWorld = BuildTangentToWorld(tangentWS, normalWS);
				input.texCoord1 = packedInput.interp03.xyzw;
				input.texCoord2 = packedInput.interp04.xyzw;

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false );
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);
				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);
				SurfaceData surfaceData;
				BuiltinData builtinData;

				GlobalSurfaceDescription surfaceDescription = (GlobalSurfaceDescription)0;
				float3 vertexToFrag213 = packedInput.ase_texcoord5.xyz;
				float3 weight54_g215 = abs( vertexToFrag213 );
				float3 appendResult83_g215 = (float3((float)(int)_MainTexX , (float)(int)_MainTexY , (float)(int)_MainTexZ));
				float3 weight0119_g215 = ( weight54_g215 * appendResult83_g215 );
				float3 temp_output_11_0_g223 = weight0119_g215;
				float3 break14_g223 = temp_output_11_0_g223;
				float3 vertexToFrag212 = packedInput.ase_texcoord6.xyz;
				float3 temp_output_36_0_g215 = vertexToFrag212;
				float2 uvX56_g215 = (temp_output_36_0_g215).yz;
				float4 appendResult23_g223 = (float4(temp_output_11_0_g223 , 0.0));
				float4 appendResult24_g223 = (float4(temp_output_11_0_g223 , 1.0));
				float4 break10_g224 = ( ( break14_g223.x + break14_g223.y + break14_g223.z ) > 0.0 ? appendResult23_g223 : appendResult24_g223 );
				float2 uvY57_g215 = (temp_output_36_0_g215).zx;
				float2 uvZ58_g215 = (temp_output_36_0_g215).xy;
				float4 color20_g223 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float4 vertexToFrag216 = packedInput.ase_texcoord7;
				float4 break10_g216 = vertexToFrag216;
				float3 appendResult123_g215 = (float3((float)(int)_Tex1X , (float)(int)_Tex1Y , (float)(int)_Tex1Z));
				float3 weight1126_g215 = ( weight54_g215 * appendResult123_g215 );
				float3 temp_output_11_0_g217 = weight1126_g215;
				float3 break14_g217 = temp_output_11_0_g217;
				float4 appendResult23_g217 = (float4(temp_output_11_0_g217 , 0.0));
				float4 appendResult24_g217 = (float4(temp_output_11_0_g217 , 1.0));
				float4 break10_g218 = ( ( break14_g217.x + break14_g217.y + break14_g217.z ) > 0.0 ? appendResult23_g217 : appendResult24_g217 );
				float4 color20_g217 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float3 appendResult130_g215 = (float3((float)(int)_Tex2X , (float)(int)_Tex2Y , (float)(int)_Tex2Z));
				float3 weight2133_g215 = ( weight54_g215 * appendResult130_g215 );
				float3 temp_output_11_0_g219 = weight2133_g215;
				float3 break14_g219 = temp_output_11_0_g219;
				float4 appendResult23_g219 = (float4(temp_output_11_0_g219 , 0.0));
				float4 appendResult24_g219 = (float4(temp_output_11_0_g219 , 1.0));
				float4 break10_g220 = ( ( break14_g219.x + break14_g219.y + break14_g219.z ) > 0.0 ? appendResult23_g219 : appendResult24_g219 );
				float4 color20_g219 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float3 appendResult137_g215 = (float3((float)(int)_Tex3X , (float)(int)_Tex3Y , (float)(int)_Tex3Z));
				float3 weight3140_g215 = ( weight54_g215 * appendResult137_g215 );
				float3 temp_output_11_0_g221 = weight3140_g215;
				float3 break14_g221 = temp_output_11_0_g221;
				float4 appendResult23_g221 = (float4(temp_output_11_0_g221 , 0.0));
				float4 appendResult24_g221 = (float4(temp_output_11_0_g221 , 1.0));
				float4 break10_g222 = ( ( break14_g221.x + break14_g221.y + break14_g221.z ) > 0.0 ? appendResult23_g221 : appendResult24_g221 );
				float4 color20_g221 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float4 color182 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
				float4 vertexToFrag5_g83 = packedInput.ase_texcoord8;
				float4 temp_output_25_0_g83 = ( _IsMeshRenderMaterial * _Color * vertexToFrag5_g83 );
				float4 temp_output_175_0 = ( ( ( _UseTex0 + _UseTex1 + _UseTex2 + _UseTex3 ) > 0.0 ? ( ( ( ( (float)(int)_UseTex0 > 0.0 ? ( ( ( ( break14_g223.x > 0.0 ? tex2D( _MainTex, uvX56_g215 ) : float4( 0,0,0,0 ) ) * break10_g224.x ) + ( ( break14_g223.y > 0.0 ? tex2D( _MainTex, uvY57_g215 ) : float4( 0,0,0,0 ) ) * break10_g224.y ) + ( ( break14_g223.z > 0.0 ? tex2D( _MainTex, uvZ58_g215 ) : float4( 0,0,0,0 ) ) * break10_g224.z ) + ( color20_g223 * break10_g224.w ) ) / ( break10_g224.x + break10_g224.y + break10_g224.z + break10_g224.w ) ) : float4( 0,0,0,0 ) ) * break10_g216.x ) + ( ( (float)(int)_UseTex1 > 0.0 ? ( ( ( ( break14_g217.x > 0.0 ? tex2D( _Tex1, uvX56_g215 ) : float4( 0,0,0,0 ) ) * break10_g218.x ) + ( ( break14_g217.y > 0.0 ? tex2D( _Tex1, uvY57_g215 ) : float4( 0,0,0,0 ) ) * break10_g218.y ) + ( ( break14_g217.z > 0.0 ? tex2D( _Tex1, uvZ58_g215 ) : float4( 0,0,0,0 ) ) * break10_g218.z ) + ( color20_g217 * break10_g218.w ) ) / ( break10_g218.x + break10_g218.y + break10_g218.z + break10_g218.w ) ) : float4( 0,0,0,0 ) ) * break10_g216.y ) + ( ( (float)(int)_UseTex2 > 0.0 ? ( ( ( ( break14_g219.x > 0.0 ? tex2D( _Tex2, uvX56_g215 ) : float4( 0,0,0,0 ) ) * break10_g220.x ) + ( ( break14_g219.y > 0.0 ? tex2D( _Tex2, uvY57_g215 ) : float4( 0,0,0,0 ) ) * break10_g220.y ) + ( ( break14_g219.z > 0.0 ? tex2D( _Tex2, uvZ58_g215 ) : float4( 0,0,0,0 ) ) * break10_g220.z ) + ( color20_g219 * break10_g220.w ) ) / ( break10_g220.x + break10_g220.y + break10_g220.z + break10_g220.w ) ) : float4( 0,0,0,0 ) ) * break10_g216.z ) + ( ( (float)(int)_UseTex3 > 0.0 ? ( ( ( ( break14_g221.x > 0.0 ? tex2D( _Tex3, uvX56_g215 ) : float4( 0,0,0,0 ) ) * break10_g222.x ) + ( ( break14_g221.y > 0.0 ? tex2D( _Tex3, uvY57_g215 ) : float4( 0,0,0,0 ) ) * break10_g222.y ) + ( ( break14_g221.z > 0.0 ? tex2D( _Tex3, uvZ58_g215 ) : float4( 0,0,0,0 ) ) * break10_g222.z ) + ( color20_g221 * break10_g222.w ) ) / ( break10_g222.x + break10_g222.y + break10_g222.z + break10_g222.w ) ) : float4( 0,0,0,0 ) ) * break10_g216.w ) ) / ( break10_g216.x + break10_g216.y + break10_g216.z + break10_g216.w ) ) : color182 ) * temp_output_25_0_g83 );
				float localComputeOpaqueTransparency20_g228 = ( 0.0 );
				float3 vertexToFrag16_g83 = packedInput.ase_texcoord9.xyz;
				float4 unityObjectToClipPos17_g83 = TransformWorldToHClip(TransformObjectToWorld(vertexToFrag16_g83));
				float4 computeScreenPos18_g83 = ComputeScreenPos( unityObjectToClipPos17_g83 , _ProjectionParams.x );
				float2 ScreenPos20_g228 = (( ( computeScreenPos18_g83 / (computeScreenPos18_g83).w ) * _ScreenParams )).xy;
				float3 vertexToFrag27_g228 = packedInput.ase_texcoord10.xyz;
				float3 VertPos20_g228 = vertexToFrag27_g228;
				int VertexID4_g83 = packedInput.ase_texcoord5.w;
				float3 PositionLs4_g83 = float3( 0,0,0 );
				float3 NormalWs4_g83 = float3( 0,0,0 );
				float3 NormalLs4_g83 = float3( 0,0,0 );
				float4 Color4_g83 = float4( 0,0,0,0 );
				float4 EmissionHash4_g83 = float4( 0,0,0,0 );
				float Metallic4_g83 = 0.0;
				float Smoothness4_g83 = 0.0;
				float4 TextureWeight4_g83 = float4( 1,0,0,0 );
				float SdfValue4_g83 = 0.0;
				float3 Outward2dNormalLs4_g83 = float3( 0,0,0 );
				float3 Outward2dNormalWs4_g83 = float3( 0,0,0 );
				float3 localMudBunMeshPoint4_g83 = MudBunMeshPoint( VertexID4_g83 , PositionLs4_g83 , NormalWs4_g83 , NormalLs4_g83 , Color4_g83 , EmissionHash4_g83 , Metallic4_g83 , Smoothness4_g83 , TextureWeight4_g83 , SdfValue4_g83 , Outward2dNormalLs4_g83 , Outward2dNormalWs4_g83 );
				float Hash20_g228 = (EmissionHash4_g83).w;
				float AlphaIn20_g228 = (temp_output_25_0_g83).a;
				float AlphaOut20_g228 = 0;
				float AlphaThreshold20_g228 = 0;
				sampler2D DitherNoiseTexture20_g228 = _DitherTexture;
				int DitherNoiseTextureSize20_g228 = _DitherTextureSize;
				int UseRandomDither20_g228 = (int)_RandomDither;
				float AlphaCutoutThreshold20_g228 = _AlphaCutoutThreshold;
				float DitherBlend20_g228 = _Dithering;
				{
				float alpha = AlphaIn20_g228;
				computeOpaqueTransparency(ScreenPos20_g228, VertPos20_g228, Hash20_g228, DitherNoiseTexture20_g228, DitherNoiseTextureSize20_g228, UseRandomDither20_g228 > 0, AlphaCutoutThreshold20_g228, DitherBlend20_g228,  alpha, AlphaThreshold20_g228);
				AlphaOut20_g228 = alpha;
				}
				float temp_output_224_0 = ( (temp_output_175_0).w * AlphaOut20_g228 );
				float temp_output_221_25 = AlphaThreshold20_g228;
				clip( temp_output_224_0 - temp_output_221_25);
				
				float vertexToFrag8_g83 = packedInput.ase_texcoord6.w;
				
				float3 vertexToFrag6_g83 = packedInput.ase_texcoord11.xyz;
				
				float vertexToFrag7_g83 = packedInput.ase_texcoord9.w;
				
				surfaceDescription.Albedo = temp_output_175_0.xyz;
				surfaceDescription.Normal = float3( 0, 0, 1 );
				surfaceDescription.BentNormal = float3( 0, 0, 1 );
				surfaceDescription.CoatMask = 0;
				surfaceDescription.Metallic = ( _Metallic * vertexToFrag8_g83 );

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceDescription.Specular = 0;
				#endif

				surfaceDescription.Emission = ( vertexToFrag6_g83 * (_Emission).rgb );
				surfaceDescription.Smoothness = ( _Smoothness * vertexToFrag7_g83 );
				surfaceDescription.Occlusion = 1;
				surfaceDescription.Alpha = temp_output_224_0;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = temp_output_221_25;
				#endif

				#ifdef _ALPHATEST_SHADOW_ON
				surfaceDescription.AlphaClipThresholdShadow = 0.5;
				#endif

				surfaceDescription.AlphaClipThresholdDepthPrepass = 0.5;
				surfaceDescription.AlphaClipThresholdDepthPostpass = 0.5;

				#ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
				surfaceDescription.SpecularAAScreenSpaceVariance = 0;
				surfaceDescription.SpecularAAThreshold = 0;
				#endif

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceDescription.SpecularOcclusion = 0;
				#endif

				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceDescription.Thickness = 1;
				#endif

				#ifdef _HAS_REFRACTION
				surfaceDescription.RefractionIndex = 1;
				surfaceDescription.RefractionColor = float3( 1, 1, 1 );
				surfaceDescription.RefractionDistance = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceDescription.SubsurfaceMask = 1;
				#endif

				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceDescription.DiffusionProfile = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceDescription.Anisotropy = 1;
				surfaceDescription.Tangent = float3( 1, 0, 0 );
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceDescription.IridescenceMask = 0;
				surfaceDescription.IridescenceThickness = 0;
				#endif

				#ifdef _ASE_DISTORTION
				surfaceDescription.Distortion = float2 ( 2, -1 );
				surfaceDescription.DistortionBlur = 1;
				#endif

				#ifdef _ASE_BAKEDGI
				surfaceDescription.BakedGI = 0;
				#endif
				#ifdef _ASE_BAKEDBACKGI
				surfaceDescription.BakedBackGI = 0;
				#endif

				#ifdef _DEPTHOFFSET_ON
				surfaceDescription.DepthOffset = 0;
				#endif

				GetSurfaceAndBuiltinData( surfaceDescription, input, V, posInput, surfaceData, builtinData );
				ENCODE_INTO_GBUFFER( surfaceData, builtinData, posInput.positionSS, outGBuffer );
				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				#endif
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "META"
			Tags { "LightMode"="Meta" }

			Cull Off

			HLSLPROGRAM

			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define HAVE_MESH_MODIFICATION
			#define ASE_SRP_VERSION 70301


			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _DOUBLESIDED_ON
			#pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
			#pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT
			#pragma shader_feature_local _ALPHATEST_ON

			#define SHADERPASS SHADERPASS_LIGHT_TRANSPORT

			#pragma vertex Vert
			#pragma fragment Frag

			//#define UNITY_MATERIAL_LIT

			#if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
			#endif

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#ifdef DEBUG_DISPLAY
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
			#endif
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define SHADER_GRAPH
			#pragma multi_compile _ MUDBUN_PROCEDURAL
			#include "Assets/MudBun/Shader/Render/ShaderCommon.cginc"
			#include "Assets/MudBun/Shader/Render/MeshCommon.cginc"


			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
				#define ASE_NEED_CULLFACE 1
			#endif

			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv0 : TEXCOORD0;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				uint ase_vertexID : SV_VertexID;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				float4 positionCS : SV_Position;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			CBUFFER_START( UnityPerMaterial )
			float _UseTex0;
			float _RandomDither;
			int _DitherTextureSize;
			float _IsMeshRenderMaterial;
			float _Tex3Z;
			float _Tex3Y;
			float _Tex3X;
			float _Tex2Z;
			float _Tex2Y;
			float _AlphaCutoutThreshold;
			float _Tex2X;
			float _Tex1Y;
			float _Tex1X;
			float _MainTexZ;
			float _MainTexY;
			float _MainTexX;
			float _UseTex3;
			float _UseTex2;
			float _UseTex1;
			float _Tex1Z;
			float _Dithering;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
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
			sampler2D _Tex1;
			sampler2D _Tex2;
			sampler2D _Tex3;
			sampler2D _DitherTexture;


			float3 MudBunMeshPoint( int VertexID, out float3 PositionLs, out float3 NormalWs, out float3 NormalLs, out float4 Color, out float4 EmissionHash, out float Metallic, out float Smoothness, out float4 TextureWeight, out float SdfValue, out float3 Outward2dNormalLs, out float3 Outward2dNormalWs )
			{
				float4 positionWs;
				float2 metallicSmoothness;
				mudbun_mesh_vert(VertexID, positionWs, PositionLs, NormalWs, NormalLs, Color, EmissionHash, metallicSmoothness, TextureWeight, SdfValue, Outward2dNormalLs, Outward2dNormalWs);
				Metallic = metallicSmoothness.x;
				Smoothness = metallicSmoothness.y;
				return positionWs.xyz;
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout GlobalSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				// surface data
				surfaceData.baseColor =					surfaceDescription.Albedo;
				surfaceData.perceptualSmoothness =		surfaceDescription.Smoothness;
				surfaceData.ambientOcclusion =			surfaceDescription.Occlusion;
				surfaceData.metallic =					surfaceDescription.Metallic;
				surfaceData.coatMask =					surfaceDescription.CoatMask;

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceData.specularOcclusion =			surfaceDescription.SpecularOcclusion;
				#endif
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.subsurfaceMask =			surfaceDescription.SubsurfaceMask;
				#endif
				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceData.thickness =					surfaceDescription.Thickness;
				#endif
				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceData.diffusionProfileHash =		asuint(surfaceDescription.DiffusionProfile);
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.specularColor =				surfaceDescription.Specular;
				#endif
				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.anisotropy =				surfaceDescription.Anisotropy;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.iridescenceMask =			surfaceDescription.IridescenceMask;
				surfaceData.iridescenceThickness =		surfaceDescription.IridescenceThickness;
				#endif

				// refraction
				#ifdef _HAS_REFRACTION
				if( _EnableSSRefraction )
				{
					surfaceData.ior = surfaceDescription.RefractionIndex;
					surfaceData.transmittanceColor = surfaceDescription.RefractionColor;
					surfaceData.atDistance = surfaceDescription.RefractionDistance;

					surfaceData.transmittanceMask = ( 1.0 - surfaceDescription.Alpha );
					surfaceDescription.Alpha = 1.0;
				}
				else
				{
					surfaceData.ior = 1.0;
					surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
					surfaceData.atDistance = 1.0;
					surfaceData.transmittanceMask = 0.0;
					surfaceDescription.Alpha = 1.0;
				}
				#else
				surfaceData.ior = 1.0;
				surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
				surfaceData.atDistance = 1.0;
				surfaceData.transmittanceMask = 0.0;
				#endif


				// material features
				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif
				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif
				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
				#endif
				#ifdef ASE_LIT_CLEAR_COAT
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				// others
				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
				surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif
				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				// normals
				float3 normalTS = float3(0.0f, 0.0f, 1.0f);
				normalTS = surfaceDescription.Normal;
				GetNormalWS( fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants );

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];

				bentNormalWS = surfaceData.normalWS;
				#ifdef ASE_BENT_NORMAL
				GetNormalWS( fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants );
				#endif

				surfaceData.tangentWS = normalize( fragInputs.tangentToWorld[ 0 ].xyz );
				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.tangentWS = TransformTangentToWorld( surfaceDescription.Tangent, fragInputs.tangentToWorld );
				#endif
				surfaceData.tangentWS = Orthonormalize( surfaceData.tangentWS, surfaceData.normalWS );

				// decals
				#if HAVE_DECALS
				if( _EnableDecals )
				{
					DecalSurfaceData decalSurfaceData = GetDecalSurfaceData( posInput, surfaceDescription.Alpha );
					ApplyDecalToSurfaceData( decalSurfaceData, surfaceData );
				}
				#endif

				#if defined(_SPECULAR_OCCLUSION_CUSTOM)
				#elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO( V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness( surfaceData.perceptualSmoothness ) );
				#elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion( ClampNdotV( dot( surfaceData.normalWS, V ) ), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness( surfaceData.perceptualSmoothness ) );
				#endif

				#ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
				surfaceData.perceptualSmoothness = GeometricNormalFiltering( surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[ 2 ], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold );
				#endif

				// debug
				#if defined(DEBUG_DISPLAY)
				if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
				{
					surfaceData.metallic = 0;
				}
				ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
				#endif
			}

			void GetSurfaceAndBuiltinData(GlobalSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
				LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				ApplyDoubleSidedFlipOrMirror( fragInputs, doubleSidedConstants );

				#ifdef _ALPHATEST_ON
				DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
				builtinData.depthOffset = surfaceDescription.DepthOffset;
				ApplyDepthOffsetPositionInput( V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput );
				#endif

				float3 bentNormalWS;
				BuildSurfaceData( fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS );

				InitBuiltinData( posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[ 2 ], fragInputs.texCoord1, fragInputs.texCoord2, builtinData );

				builtinData.emissiveColor = surfaceDescription.Emission;

				#if (SHADERPASS == SHADERPASS_DISTORTION)
				builtinData.distortion = surfaceDescription.Distortion;
				builtinData.distortionBlur = surfaceDescription.DistortionBlur;
				#else
				builtinData.distortion = float2(0.0, 0.0);
				builtinData.distortionBlur = 0.0;
				#endif

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			CBUFFER_START(UnityMetaPass)
			bool4 unity_MetaVertexControl;
			bool4 unity_MetaFragmentControl;
			CBUFFER_END

			float unity_OneOverOutputBoost;
			float unity_MaxOutputValue;

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh  )
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);

				int VertexID4_g83 = inputMesh.ase_vertexID;
				float3 PositionLs4_g83 = float3( 0,0,0 );
				float3 NormalWs4_g83 = float3( 0,0,0 );
				float3 NormalLs4_g83 = float3( 0,0,0 );
				float4 Color4_g83 = float4( 0,0,0,0 );
				float4 EmissionHash4_g83 = float4( 0,0,0,0 );
				float Metallic4_g83 = 0.0;
				float Smoothness4_g83 = 0.0;
				float4 TextureWeight4_g83 = float4( 1,0,0,0 );
				float SdfValue4_g83 = 0.0;
				float3 Outward2dNormalLs4_g83 = float3( 0,0,0 );
				float3 Outward2dNormalWs4_g83 = float3( 0,0,0 );
				float3 localMudBunMeshPoint4_g83 = MudBunMeshPoint( VertexID4_g83 , PositionLs4_g83 , NormalWs4_g83 , NormalLs4_g83 , Color4_g83 , EmissionHash4_g83 , Metallic4_g83 , Smoothness4_g83 , TextureWeight4_g83 , SdfValue4_g83 , Outward2dNormalLs4_g83 , Outward2dNormalWs4_g83 );
				float3 temp_output_198_0 = localMudBunMeshPoint4_g83;
				
				float3 vertexToFrag213 = NormalLs4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord.xyz = vertexToFrag213;
				float3 vertexToFrag212 = PositionLs4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord1.xyz = vertexToFrag212;
				float4 vertexToFrag216 = TextureWeight4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord2 = vertexToFrag216;
				float4 vertexToFrag5_g83 = Color4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord3 = vertexToFrag5_g83;
				float3 vertexToFrag16_g83 = localMudBunMeshPoint4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord4.xyz = vertexToFrag16_g83;
				float3 vertexToFrag27_g228 = temp_output_198_0;
				outputPackedVaryingsMeshToPS.ase_texcoord5.xyz = vertexToFrag27_g228;
				
				float vertexToFrag8_g83 = Metallic4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord1.w = vertexToFrag8_g83;
				
				float3 vertexToFrag6_g83 = (EmissionHash4_g83).xyz;
				outputPackedVaryingsMeshToPS.ase_texcoord6.xyz = vertexToFrag6_g83;
				
				float vertexToFrag7_g83 = Smoothness4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord4.w = vertexToFrag7_g83;
				
				outputPackedVaryingsMeshToPS.ase_texcoord.w = inputMesh.ase_vertexID;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord5.w = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord6.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = temp_output_198_0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS = NormalWs4_g83;
				inputMesh.tangentOS =  inputMesh.tangentOS ;

				float2 uv = float2(0.0, 0.0);
				if (unity_MetaVertexControl.x)
				{
					uv = inputMesh.uv1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				}
				else if (unity_MetaVertexControl.y)
				{
					uv = inputMesh.uv2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				}

				outputPackedVaryingsMeshToPS.positionCS = float4(uv * 2.0 - 1.0, inputMesh.positionOS.z > 0 ? 1.0e-4 : 0.0, 1.0);
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv0 : TEXCOORD0;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				uint ase_vertexID : SV_VertexID;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.uv0 = v.uv0;
				o.uv1 = v.uv1;
				o.uv2 = v.uv2;
				o.ase_vertexID = v.ase_vertexID;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
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
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.uv0 = patch[0].uv0 * bary.x + patch[1].uv0 * bary.y + patch[2].uv0 * bary.z;
				o.uv1 = patch[0].uv1 * bary.x + patch[1].uv1 * bary.y + patch[2].uv1 * bary.z;
				o.uv2 = patch[0].uv2 * bary.x + patch[1].uv2 * bary.y + patch[2].uv2 * bary.z;
				o.ase_vertexID = patch[0].ase_vertexID * bary.x + patch[1].ase_vertexID * bary.y + patch[2].ase_vertexID * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			float4 Frag(PackedVaryingsMeshToPS packedInput  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( packedInput );
				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE(packedInput.cullFace, true, false);
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);
				float3 V = float3(1.0, 1.0, 1.0);

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GlobalSurfaceDescription surfaceDescription = (GlobalSurfaceDescription)0;
				float3 vertexToFrag213 = packedInput.ase_texcoord.xyz;
				float3 weight54_g215 = abs( vertexToFrag213 );
				float3 appendResult83_g215 = (float3((float)(int)_MainTexX , (float)(int)_MainTexY , (float)(int)_MainTexZ));
				float3 weight0119_g215 = ( weight54_g215 * appendResult83_g215 );
				float3 temp_output_11_0_g223 = weight0119_g215;
				float3 break14_g223 = temp_output_11_0_g223;
				float3 vertexToFrag212 = packedInput.ase_texcoord1.xyz;
				float3 temp_output_36_0_g215 = vertexToFrag212;
				float2 uvX56_g215 = (temp_output_36_0_g215).yz;
				float4 appendResult23_g223 = (float4(temp_output_11_0_g223 , 0.0));
				float4 appendResult24_g223 = (float4(temp_output_11_0_g223 , 1.0));
				float4 break10_g224 = ( ( break14_g223.x + break14_g223.y + break14_g223.z ) > 0.0 ? appendResult23_g223 : appendResult24_g223 );
				float2 uvY57_g215 = (temp_output_36_0_g215).zx;
				float2 uvZ58_g215 = (temp_output_36_0_g215).xy;
				float4 color20_g223 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float4 vertexToFrag216 = packedInput.ase_texcoord2;
				float4 break10_g216 = vertexToFrag216;
				float3 appendResult123_g215 = (float3((float)(int)_Tex1X , (float)(int)_Tex1Y , (float)(int)_Tex1Z));
				float3 weight1126_g215 = ( weight54_g215 * appendResult123_g215 );
				float3 temp_output_11_0_g217 = weight1126_g215;
				float3 break14_g217 = temp_output_11_0_g217;
				float4 appendResult23_g217 = (float4(temp_output_11_0_g217 , 0.0));
				float4 appendResult24_g217 = (float4(temp_output_11_0_g217 , 1.0));
				float4 break10_g218 = ( ( break14_g217.x + break14_g217.y + break14_g217.z ) > 0.0 ? appendResult23_g217 : appendResult24_g217 );
				float4 color20_g217 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float3 appendResult130_g215 = (float3((float)(int)_Tex2X , (float)(int)_Tex2Y , (float)(int)_Tex2Z));
				float3 weight2133_g215 = ( weight54_g215 * appendResult130_g215 );
				float3 temp_output_11_0_g219 = weight2133_g215;
				float3 break14_g219 = temp_output_11_0_g219;
				float4 appendResult23_g219 = (float4(temp_output_11_0_g219 , 0.0));
				float4 appendResult24_g219 = (float4(temp_output_11_0_g219 , 1.0));
				float4 break10_g220 = ( ( break14_g219.x + break14_g219.y + break14_g219.z ) > 0.0 ? appendResult23_g219 : appendResult24_g219 );
				float4 color20_g219 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float3 appendResult137_g215 = (float3((float)(int)_Tex3X , (float)(int)_Tex3Y , (float)(int)_Tex3Z));
				float3 weight3140_g215 = ( weight54_g215 * appendResult137_g215 );
				float3 temp_output_11_0_g221 = weight3140_g215;
				float3 break14_g221 = temp_output_11_0_g221;
				float4 appendResult23_g221 = (float4(temp_output_11_0_g221 , 0.0));
				float4 appendResult24_g221 = (float4(temp_output_11_0_g221 , 1.0));
				float4 break10_g222 = ( ( break14_g221.x + break14_g221.y + break14_g221.z ) > 0.0 ? appendResult23_g221 : appendResult24_g221 );
				float4 color20_g221 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float4 color182 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
				float4 vertexToFrag5_g83 = packedInput.ase_texcoord3;
				float4 temp_output_25_0_g83 = ( _IsMeshRenderMaterial * _Color * vertexToFrag5_g83 );
				float4 temp_output_175_0 = ( ( ( _UseTex0 + _UseTex1 + _UseTex2 + _UseTex3 ) > 0.0 ? ( ( ( ( (float)(int)_UseTex0 > 0.0 ? ( ( ( ( break14_g223.x > 0.0 ? tex2D( _MainTex, uvX56_g215 ) : float4( 0,0,0,0 ) ) * break10_g224.x ) + ( ( break14_g223.y > 0.0 ? tex2D( _MainTex, uvY57_g215 ) : float4( 0,0,0,0 ) ) * break10_g224.y ) + ( ( break14_g223.z > 0.0 ? tex2D( _MainTex, uvZ58_g215 ) : float4( 0,0,0,0 ) ) * break10_g224.z ) + ( color20_g223 * break10_g224.w ) ) / ( break10_g224.x + break10_g224.y + break10_g224.z + break10_g224.w ) ) : float4( 0,0,0,0 ) ) * break10_g216.x ) + ( ( (float)(int)_UseTex1 > 0.0 ? ( ( ( ( break14_g217.x > 0.0 ? tex2D( _Tex1, uvX56_g215 ) : float4( 0,0,0,0 ) ) * break10_g218.x ) + ( ( break14_g217.y > 0.0 ? tex2D( _Tex1, uvY57_g215 ) : float4( 0,0,0,0 ) ) * break10_g218.y ) + ( ( break14_g217.z > 0.0 ? tex2D( _Tex1, uvZ58_g215 ) : float4( 0,0,0,0 ) ) * break10_g218.z ) + ( color20_g217 * break10_g218.w ) ) / ( break10_g218.x + break10_g218.y + break10_g218.z + break10_g218.w ) ) : float4( 0,0,0,0 ) ) * break10_g216.y ) + ( ( (float)(int)_UseTex2 > 0.0 ? ( ( ( ( break14_g219.x > 0.0 ? tex2D( _Tex2, uvX56_g215 ) : float4( 0,0,0,0 ) ) * break10_g220.x ) + ( ( break14_g219.y > 0.0 ? tex2D( _Tex2, uvY57_g215 ) : float4( 0,0,0,0 ) ) * break10_g220.y ) + ( ( break14_g219.z > 0.0 ? tex2D( _Tex2, uvZ58_g215 ) : float4( 0,0,0,0 ) ) * break10_g220.z ) + ( color20_g219 * break10_g220.w ) ) / ( break10_g220.x + break10_g220.y + break10_g220.z + break10_g220.w ) ) : float4( 0,0,0,0 ) ) * break10_g216.z ) + ( ( (float)(int)_UseTex3 > 0.0 ? ( ( ( ( break14_g221.x > 0.0 ? tex2D( _Tex3, uvX56_g215 ) : float4( 0,0,0,0 ) ) * break10_g222.x ) + ( ( break14_g221.y > 0.0 ? tex2D( _Tex3, uvY57_g215 ) : float4( 0,0,0,0 ) ) * break10_g222.y ) + ( ( break14_g221.z > 0.0 ? tex2D( _Tex3, uvZ58_g215 ) : float4( 0,0,0,0 ) ) * break10_g222.z ) + ( color20_g221 * break10_g222.w ) ) / ( break10_g222.x + break10_g222.y + break10_g222.z + break10_g222.w ) ) : float4( 0,0,0,0 ) ) * break10_g216.w ) ) / ( break10_g216.x + break10_g216.y + break10_g216.z + break10_g216.w ) ) : color182 ) * temp_output_25_0_g83 );
				float localComputeOpaqueTransparency20_g228 = ( 0.0 );
				float3 vertexToFrag16_g83 = packedInput.ase_texcoord4.xyz;
				float4 unityObjectToClipPos17_g83 = TransformWorldToHClip(TransformObjectToWorld(vertexToFrag16_g83));
				float4 computeScreenPos18_g83 = ComputeScreenPos( unityObjectToClipPos17_g83 , _ProjectionParams.x );
				float2 ScreenPos20_g228 = (( ( computeScreenPos18_g83 / (computeScreenPos18_g83).w ) * _ScreenParams )).xy;
				float3 vertexToFrag27_g228 = packedInput.ase_texcoord5.xyz;
				float3 VertPos20_g228 = vertexToFrag27_g228;
				int VertexID4_g83 = packedInput.ase_texcoord.w;
				float3 PositionLs4_g83 = float3( 0,0,0 );
				float3 NormalWs4_g83 = float3( 0,0,0 );
				float3 NormalLs4_g83 = float3( 0,0,0 );
				float4 Color4_g83 = float4( 0,0,0,0 );
				float4 EmissionHash4_g83 = float4( 0,0,0,0 );
				float Metallic4_g83 = 0.0;
				float Smoothness4_g83 = 0.0;
				float4 TextureWeight4_g83 = float4( 1,0,0,0 );
				float SdfValue4_g83 = 0.0;
				float3 Outward2dNormalLs4_g83 = float3( 0,0,0 );
				float3 Outward2dNormalWs4_g83 = float3( 0,0,0 );
				float3 localMudBunMeshPoint4_g83 = MudBunMeshPoint( VertexID4_g83 , PositionLs4_g83 , NormalWs4_g83 , NormalLs4_g83 , Color4_g83 , EmissionHash4_g83 , Metallic4_g83 , Smoothness4_g83 , TextureWeight4_g83 , SdfValue4_g83 , Outward2dNormalLs4_g83 , Outward2dNormalWs4_g83 );
				float Hash20_g228 = (EmissionHash4_g83).w;
				float AlphaIn20_g228 = (temp_output_25_0_g83).a;
				float AlphaOut20_g228 = 0;
				float AlphaThreshold20_g228 = 0;
				sampler2D DitherNoiseTexture20_g228 = _DitherTexture;
				int DitherNoiseTextureSize20_g228 = _DitherTextureSize;
				int UseRandomDither20_g228 = (int)_RandomDither;
				float AlphaCutoutThreshold20_g228 = _AlphaCutoutThreshold;
				float DitherBlend20_g228 = _Dithering;
				{
				float alpha = AlphaIn20_g228;
				computeOpaqueTransparency(ScreenPos20_g228, VertPos20_g228, Hash20_g228, DitherNoiseTexture20_g228, DitherNoiseTextureSize20_g228, UseRandomDither20_g228 > 0, AlphaCutoutThreshold20_g228, DitherBlend20_g228,  alpha, AlphaThreshold20_g228);
				AlphaOut20_g228 = alpha;
				}
				float temp_output_224_0 = ( (temp_output_175_0).w * AlphaOut20_g228 );
				float temp_output_221_25 = AlphaThreshold20_g228;
				clip( temp_output_224_0 - temp_output_221_25);
				
				float vertexToFrag8_g83 = packedInput.ase_texcoord1.w;
				
				float3 vertexToFrag6_g83 = packedInput.ase_texcoord6.xyz;
				
				float vertexToFrag7_g83 = packedInput.ase_texcoord4.w;
				
				surfaceDescription.Albedo = temp_output_175_0.xyz;
				surfaceDescription.Normal = float3( 0, 0, 1 );
				surfaceDescription.BentNormal = float3( 0, 0, 1 );
				surfaceDescription.CoatMask = 0;
				surfaceDescription.Metallic = ( _Metallic * vertexToFrag8_g83 );

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceDescription.Specular = 0;
				#endif

				surfaceDescription.Emission = ( vertexToFrag6_g83 * (_Emission).rgb );
				surfaceDescription.Smoothness = ( _Smoothness * vertexToFrag7_g83 );
				surfaceDescription.Occlusion = 1;
				surfaceDescription.Alpha = temp_output_224_0;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = temp_output_221_25;
				#endif

				#ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
				surfaceDescription.SpecularAAScreenSpaceVariance = 0;
				surfaceDescription.SpecularAAThreshold = 0;
				#endif

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceDescription.SpecularOcclusion = 0;
				#endif

				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceDescription.Thickness = 1;
				#endif

				#ifdef _HAS_REFRACTION
				surfaceDescription.RefractionIndex = 1;
				surfaceDescription.RefractionColor = float3( 1, 1, 1 );
				surfaceDescription.RefractionDistance = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceDescription.SubsurfaceMask = 1;
				#endif

				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceDescription.DiffusionProfile = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceDescription.Anisotropy = 1;
				surfaceDescription.Tangent = float3( 1, 0, 0 );
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceDescription.IridescenceMask = 0;
				surfaceDescription.IridescenceThickness = 0;
				#endif

				GetSurfaceAndBuiltinData(surfaceDescription,input, V, posInput, surfaceData, builtinData);

				BSDFData bsdfData = ConvertSurfaceDataToBSDFData(input.positionSS.xy, surfaceData);
				LightTransportData lightTransportData = GetLightTransportData(surfaceData, builtinData, bsdfData);

				float4 res = float4(0.0, 0.0, 0.0, 1.0);
				if (unity_MetaFragmentControl.x)
				{
					res.rgb = clamp(pow(abs(lightTransportData.diffuseColor), saturate(unity_OneOverOutputBoost)), 0, unity_MaxOutputValue);
				}

				if (unity_MetaFragmentControl.y)
				{
					res.rgb = lightTransportData.emissiveColor;
				}

				return res;
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }

			Cull [_CullMode]
			ZWrite On
			ZClip [_ZClip]
			ZTest LEqual
			ColorMask 0

			HLSLPROGRAM

			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define HAVE_MESH_MODIFICATION
			#define ASE_SRP_VERSION 70301


			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _DOUBLESIDED_ON
			#pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
			#pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT
			#pragma shader_feature_local _ALPHATEST_ON

			#define SHADERPASS SHADERPASS_SHADOWS

			#pragma vertex Vert
			#pragma fragment Frag

			//#define UNITY_MATERIAL_LIT

			#if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
			#endif

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"

			//#define USE_LEGACY_UNITY_MATRIX_VARIABLES

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#ifdef DEBUG_DISPLAY
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
			#endif
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define SHADER_GRAPH
			#pragma multi_compile _ MUDBUN_PROCEDURAL
			#include "Assets/MudBun/Shader/Render/ShaderCommon.cginc"
			#include "Assets/MudBun/Shader/Render/MeshCommon.cginc"


			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
				#define ASE_NEED_CULLFACE 1
			#endif

			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				uint ase_vertexID : SV_VertexID;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				float4 positionCS : SV_Position;
				float3 interp00 : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			CBUFFER_START( UnityPerMaterial )
			float _UseTex0;
			float _RandomDither;
			int _DitherTextureSize;
			float _IsMeshRenderMaterial;
			float _Tex3Z;
			float _Tex3Y;
			float _Tex3X;
			float _Tex2Z;
			float _Tex2Y;
			float _AlphaCutoutThreshold;
			float _Tex2X;
			float _Tex1Y;
			float _Tex1X;
			float _MainTexZ;
			float _MainTexY;
			float _MainTexX;
			float _UseTex3;
			float _UseTex2;
			float _UseTex1;
			float _Tex1Z;
			float _Dithering;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
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
			sampler2D _Tex1;
			sampler2D _Tex2;
			sampler2D _Tex3;
			sampler2D _DitherTexture;


			float3 MudBunMeshPoint( int VertexID, out float3 PositionLs, out float3 NormalWs, out float3 NormalLs, out float4 Color, out float4 EmissionHash, out float Metallic, out float Smoothness, out float4 TextureWeight, out float SdfValue, out float3 Outward2dNormalLs, out float3 Outward2dNormalWs )
			{
				float4 positionWs;
				float2 metallicSmoothness;
				mudbun_mesh_vert(VertexID, positionWs, PositionLs, NormalWs, NormalLs, Color, EmissionHash, metallicSmoothness, TextureWeight, SdfValue, Outward2dNormalLs, Outward2dNormalWs);
				Metallic = metallicSmoothness.x;
				Smoothness = metallicSmoothness.y;
				return positionWs.xyz;
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout AlphaSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				// surface data

				// refraction
				#ifdef _HAS_REFRACTION
				if( _EnableSSRefraction )
				{
					surfaceData.transmittanceMask = ( 1.0 - surfaceDescription.Alpha );
					surfaceDescription.Alpha = 1.0;
				}
				else
				{
					surfaceData.ior = 1.0;
					surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
					surfaceData.atDistance = 1.0;
					surfaceData.transmittanceMask = 0.0;
					surfaceDescription.Alpha = 1.0;
				}
				#else
				surfaceData.ior = 1.0;
				surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
				surfaceData.atDistance = 1.0;
				surfaceData.transmittanceMask = 0.0;
				#endif


				// material features
				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif
				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif
				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
				#endif
				#ifdef ASE_LIT_CLEAR_COAT
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				// others
				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
				surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif
				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				// normals
				float3 normalTS = float3(0.0f, 0.0f, 1.0f);
				GetNormalWS( fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants );

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];

				bentNormalWS = surfaceData.normalWS;

				surfaceData.tangentWS = normalize( fragInputs.tangentToWorld[ 0 ].xyz );
				surfaceData.tangentWS = Orthonormalize( surfaceData.tangentWS, surfaceData.normalWS );

				// decals
				#if HAVE_DECALS
				if( _EnableDecals )
				{
					DecalSurfaceData decalSurfaceData = GetDecalSurfaceData( posInput, surfaceDescription.Alpha );
					ApplyDecalToSurfaceData( decalSurfaceData, surfaceData );
				}
				#endif

				#if defined(_SPECULAR_OCCLUSION_CUSTOM)
				#elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO( V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness( surfaceData.perceptualSmoothness ) );
				#elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion( ClampNdotV( dot( surfaceData.normalWS, V ) ), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness( surfaceData.perceptualSmoothness ) );
				#endif

				// debug
				#if defined(DEBUG_DISPLAY)
				if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
				{
					surfaceData.metallic = 0;
				}
				ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
				#endif
			}

			void GetSurfaceAndBuiltinData(AlphaSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
				LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				ApplyDoubleSidedFlipOrMirror( fragInputs, doubleSidedConstants );

				#ifdef _ALPHATEST_ON
				#ifdef _ALPHATEST_SHADOW_ON
				DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow );
				#else
				DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif
				#endif

				#ifdef _DEPTHOFFSET_ON
				builtinData.depthOffset = surfaceDescription.DepthOffset;
				ApplyDepthOffsetPositionInput( V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput );
				#endif

				float3 bentNormalWS;
				BuildSurfaceData( fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS );

				InitBuiltinData( posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[ 2 ], fragInputs.texCoord1, fragInputs.texCoord2, builtinData );

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh )
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS;
				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				int VertexID4_g83 = inputMesh.ase_vertexID;
				float3 PositionLs4_g83 = float3( 0,0,0 );
				float3 NormalWs4_g83 = float3( 0,0,0 );
				float3 NormalLs4_g83 = float3( 0,0,0 );
				float4 Color4_g83 = float4( 0,0,0,0 );
				float4 EmissionHash4_g83 = float4( 0,0,0,0 );
				float Metallic4_g83 = 0.0;
				float Smoothness4_g83 = 0.0;
				float4 TextureWeight4_g83 = float4( 1,0,0,0 );
				float SdfValue4_g83 = 0.0;
				float3 Outward2dNormalLs4_g83 = float3( 0,0,0 );
				float3 Outward2dNormalWs4_g83 = float3( 0,0,0 );
				float3 localMudBunMeshPoint4_g83 = MudBunMeshPoint( VertexID4_g83 , PositionLs4_g83 , NormalWs4_g83 , NormalLs4_g83 , Color4_g83 , EmissionHash4_g83 , Metallic4_g83 , Smoothness4_g83 , TextureWeight4_g83 , SdfValue4_g83 , Outward2dNormalLs4_g83 , Outward2dNormalWs4_g83 );
				float3 temp_output_198_0 = localMudBunMeshPoint4_g83;
				
				float3 vertexToFrag213 = NormalLs4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord1.xyz = vertexToFrag213;
				float3 vertexToFrag212 = PositionLs4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord2.xyz = vertexToFrag212;
				float4 vertexToFrag216 = TextureWeight4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord3 = vertexToFrag216;
				float4 vertexToFrag5_g83 = Color4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord4 = vertexToFrag5_g83;
				float3 vertexToFrag16_g83 = localMudBunMeshPoint4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord5.xyz = vertexToFrag16_g83;
				float3 vertexToFrag27_g228 = temp_output_198_0;
				outputPackedVaryingsMeshToPS.ase_texcoord6.xyz = vertexToFrag27_g228;
				
				outputPackedVaryingsMeshToPS.ase_texcoord1.w = inputMesh.ase_vertexID;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord2.w = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord5.w = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord6.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = temp_output_198_0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS = NormalWs4_g83;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				outputPackedVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
				outputPackedVaryingsMeshToPS.interp00.xyz = positionRWS;
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				uint ase_vertexID : SV_VertexID;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.ase_vertexID = v.ase_vertexID;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
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
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_vertexID = patch[0].ase_vertexID * bary.x + patch[1].ase_vertexID * bary.y + patch[2].ase_vertexID * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif
			
			void Frag( PackedVaryingsMeshToPS packedInput
						#ifdef WRITE_NORMAL_BUFFER
						, out float4 outNormalBuffer : SV_Target0
							#ifdef WRITE_MSAA_DEPTH
							, out float1 depthColor : SV_Target1
							#endif
						#elif defined(WRITE_MSAA_DEPTH)
						, out float4 outNormalBuffer : SV_Target0
						, out float1 depthColor : SV_Target1
						#elif defined(SCENESELECTIONPASS)
						, out float4 outColor : SV_Target0
						#endif
						#ifdef _DEPTHOFFSET_ON
						, out float outputDepth : SV_Depth
						#endif
						
					)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				UNITY_SETUP_INSTANCE_ID( packedInput );

				float3 positionRWS = packedInput.interp00.xyz;

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);

				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				input.positionRWS = positionRWS;

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false );
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);

				AlphaSurfaceDescription surfaceDescription = (AlphaSurfaceDescription)0;
				float3 vertexToFrag213 = packedInput.ase_texcoord1.xyz;
				float3 weight54_g215 = abs( vertexToFrag213 );
				float3 appendResult83_g215 = (float3((float)(int)_MainTexX , (float)(int)_MainTexY , (float)(int)_MainTexZ));
				float3 weight0119_g215 = ( weight54_g215 * appendResult83_g215 );
				float3 temp_output_11_0_g223 = weight0119_g215;
				float3 break14_g223 = temp_output_11_0_g223;
				float3 vertexToFrag212 = packedInput.ase_texcoord2.xyz;
				float3 temp_output_36_0_g215 = vertexToFrag212;
				float2 uvX56_g215 = (temp_output_36_0_g215).yz;
				float4 appendResult23_g223 = (float4(temp_output_11_0_g223 , 0.0));
				float4 appendResult24_g223 = (float4(temp_output_11_0_g223 , 1.0));
				float4 break10_g224 = ( ( break14_g223.x + break14_g223.y + break14_g223.z ) > 0.0 ? appendResult23_g223 : appendResult24_g223 );
				float2 uvY57_g215 = (temp_output_36_0_g215).zx;
				float2 uvZ58_g215 = (temp_output_36_0_g215).xy;
				float4 color20_g223 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float4 vertexToFrag216 = packedInput.ase_texcoord3;
				float4 break10_g216 = vertexToFrag216;
				float3 appendResult123_g215 = (float3((float)(int)_Tex1X , (float)(int)_Tex1Y , (float)(int)_Tex1Z));
				float3 weight1126_g215 = ( weight54_g215 * appendResult123_g215 );
				float3 temp_output_11_0_g217 = weight1126_g215;
				float3 break14_g217 = temp_output_11_0_g217;
				float4 appendResult23_g217 = (float4(temp_output_11_0_g217 , 0.0));
				float4 appendResult24_g217 = (float4(temp_output_11_0_g217 , 1.0));
				float4 break10_g218 = ( ( break14_g217.x + break14_g217.y + break14_g217.z ) > 0.0 ? appendResult23_g217 : appendResult24_g217 );
				float4 color20_g217 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float3 appendResult130_g215 = (float3((float)(int)_Tex2X , (float)(int)_Tex2Y , (float)(int)_Tex2Z));
				float3 weight2133_g215 = ( weight54_g215 * appendResult130_g215 );
				float3 temp_output_11_0_g219 = weight2133_g215;
				float3 break14_g219 = temp_output_11_0_g219;
				float4 appendResult23_g219 = (float4(temp_output_11_0_g219 , 0.0));
				float4 appendResult24_g219 = (float4(temp_output_11_0_g219 , 1.0));
				float4 break10_g220 = ( ( break14_g219.x + break14_g219.y + break14_g219.z ) > 0.0 ? appendResult23_g219 : appendResult24_g219 );
				float4 color20_g219 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float3 appendResult137_g215 = (float3((float)(int)_Tex3X , (float)(int)_Tex3Y , (float)(int)_Tex3Z));
				float3 weight3140_g215 = ( weight54_g215 * appendResult137_g215 );
				float3 temp_output_11_0_g221 = weight3140_g215;
				float3 break14_g221 = temp_output_11_0_g221;
				float4 appendResult23_g221 = (float4(temp_output_11_0_g221 , 0.0));
				float4 appendResult24_g221 = (float4(temp_output_11_0_g221 , 1.0));
				float4 break10_g222 = ( ( break14_g221.x + break14_g221.y + break14_g221.z ) > 0.0 ? appendResult23_g221 : appendResult24_g221 );
				float4 color20_g221 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float4 color182 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
				float4 vertexToFrag5_g83 = packedInput.ase_texcoord4;
				float4 temp_output_25_0_g83 = ( _IsMeshRenderMaterial * _Color * vertexToFrag5_g83 );
				float4 temp_output_175_0 = ( ( ( _UseTex0 + _UseTex1 + _UseTex2 + _UseTex3 ) > 0.0 ? ( ( ( ( (float)(int)_UseTex0 > 0.0 ? ( ( ( ( break14_g223.x > 0.0 ? tex2D( _MainTex, uvX56_g215 ) : float4( 0,0,0,0 ) ) * break10_g224.x ) + ( ( break14_g223.y > 0.0 ? tex2D( _MainTex, uvY57_g215 ) : float4( 0,0,0,0 ) ) * break10_g224.y ) + ( ( break14_g223.z > 0.0 ? tex2D( _MainTex, uvZ58_g215 ) : float4( 0,0,0,0 ) ) * break10_g224.z ) + ( color20_g223 * break10_g224.w ) ) / ( break10_g224.x + break10_g224.y + break10_g224.z + break10_g224.w ) ) : float4( 0,0,0,0 ) ) * break10_g216.x ) + ( ( (float)(int)_UseTex1 > 0.0 ? ( ( ( ( break14_g217.x > 0.0 ? tex2D( _Tex1, uvX56_g215 ) : float4( 0,0,0,0 ) ) * break10_g218.x ) + ( ( break14_g217.y > 0.0 ? tex2D( _Tex1, uvY57_g215 ) : float4( 0,0,0,0 ) ) * break10_g218.y ) + ( ( break14_g217.z > 0.0 ? tex2D( _Tex1, uvZ58_g215 ) : float4( 0,0,0,0 ) ) * break10_g218.z ) + ( color20_g217 * break10_g218.w ) ) / ( break10_g218.x + break10_g218.y + break10_g218.z + break10_g218.w ) ) : float4( 0,0,0,0 ) ) * break10_g216.y ) + ( ( (float)(int)_UseTex2 > 0.0 ? ( ( ( ( break14_g219.x > 0.0 ? tex2D( _Tex2, uvX56_g215 ) : float4( 0,0,0,0 ) ) * break10_g220.x ) + ( ( break14_g219.y > 0.0 ? tex2D( _Tex2, uvY57_g215 ) : float4( 0,0,0,0 ) ) * break10_g220.y ) + ( ( break14_g219.z > 0.0 ? tex2D( _Tex2, uvZ58_g215 ) : float4( 0,0,0,0 ) ) * break10_g220.z ) + ( color20_g219 * break10_g220.w ) ) / ( break10_g220.x + break10_g220.y + break10_g220.z + break10_g220.w ) ) : float4( 0,0,0,0 ) ) * break10_g216.z ) + ( ( (float)(int)_UseTex3 > 0.0 ? ( ( ( ( break14_g221.x > 0.0 ? tex2D( _Tex3, uvX56_g215 ) : float4( 0,0,0,0 ) ) * break10_g222.x ) + ( ( break14_g221.y > 0.0 ? tex2D( _Tex3, uvY57_g215 ) : float4( 0,0,0,0 ) ) * break10_g222.y ) + ( ( break14_g221.z > 0.0 ? tex2D( _Tex3, uvZ58_g215 ) : float4( 0,0,0,0 ) ) * break10_g222.z ) + ( color20_g221 * break10_g222.w ) ) / ( break10_g222.x + break10_g222.y + break10_g222.z + break10_g222.w ) ) : float4( 0,0,0,0 ) ) * break10_g216.w ) ) / ( break10_g216.x + break10_g216.y + break10_g216.z + break10_g216.w ) ) : color182 ) * temp_output_25_0_g83 );
				float localComputeOpaqueTransparency20_g228 = ( 0.0 );
				float3 vertexToFrag16_g83 = packedInput.ase_texcoord5.xyz;
				float4 unityObjectToClipPos17_g83 = TransformWorldToHClip(TransformObjectToWorld(vertexToFrag16_g83));
				float4 computeScreenPos18_g83 = ComputeScreenPos( unityObjectToClipPos17_g83 , _ProjectionParams.x );
				float2 ScreenPos20_g228 = (( ( computeScreenPos18_g83 / (computeScreenPos18_g83).w ) * _ScreenParams )).xy;
				float3 vertexToFrag27_g228 = packedInput.ase_texcoord6.xyz;
				float3 VertPos20_g228 = vertexToFrag27_g228;
				int VertexID4_g83 = packedInput.ase_texcoord1.w;
				float3 PositionLs4_g83 = float3( 0,0,0 );
				float3 NormalWs4_g83 = float3( 0,0,0 );
				float3 NormalLs4_g83 = float3( 0,0,0 );
				float4 Color4_g83 = float4( 0,0,0,0 );
				float4 EmissionHash4_g83 = float4( 0,0,0,0 );
				float Metallic4_g83 = 0.0;
				float Smoothness4_g83 = 0.0;
				float4 TextureWeight4_g83 = float4( 1,0,0,0 );
				float SdfValue4_g83 = 0.0;
				float3 Outward2dNormalLs4_g83 = float3( 0,0,0 );
				float3 Outward2dNormalWs4_g83 = float3( 0,0,0 );
				float3 localMudBunMeshPoint4_g83 = MudBunMeshPoint( VertexID4_g83 , PositionLs4_g83 , NormalWs4_g83 , NormalLs4_g83 , Color4_g83 , EmissionHash4_g83 , Metallic4_g83 , Smoothness4_g83 , TextureWeight4_g83 , SdfValue4_g83 , Outward2dNormalLs4_g83 , Outward2dNormalWs4_g83 );
				float Hash20_g228 = (EmissionHash4_g83).w;
				float AlphaIn20_g228 = (temp_output_25_0_g83).a;
				float AlphaOut20_g228 = 0;
				float AlphaThreshold20_g228 = 0;
				sampler2D DitherNoiseTexture20_g228 = _DitherTexture;
				int DitherNoiseTextureSize20_g228 = _DitherTextureSize;
				int UseRandomDither20_g228 = (int)_RandomDither;
				float AlphaCutoutThreshold20_g228 = _AlphaCutoutThreshold;
				float DitherBlend20_g228 = _Dithering;
				{
				float alpha = AlphaIn20_g228;
				computeOpaqueTransparency(ScreenPos20_g228, VertPos20_g228, Hash20_g228, DitherNoiseTexture20_g228, DitherNoiseTextureSize20_g228, UseRandomDither20_g228 > 0, AlphaCutoutThreshold20_g228, DitherBlend20_g228,  alpha, AlphaThreshold20_g228);
				AlphaOut20_g228 = alpha;
				}
				float temp_output_224_0 = ( (temp_output_175_0).w * AlphaOut20_g228 );
				
				float temp_output_221_25 = AlphaThreshold20_g228;
				
				surfaceDescription.Alpha = temp_output_224_0;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = temp_output_221_25;
				#endif

				#ifdef _ALPHATEST_SHADOW_ON
				surfaceDescription.AlphaClipThresholdShadow = 0.5;
				#endif

				#ifdef _DEPTHOFFSET_ON
				surfaceDescription.DepthOffset = 0;
				#endif

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);

				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				#endif

				#ifdef WRITE_NORMAL_BUFFER
				EncodeIntoNormalBuffer( ConvertSurfaceDataToNormalData( surfaceData ), posInput.positionSS, outNormalBuffer );
				#ifdef WRITE_MSAA_DEPTH
				depthColor = packedInput.positionCS.z;
				#endif
				#elif defined(WRITE_MSAA_DEPTH)
				outNormalBuffer = float4( 0.0, 0.0, 0.0, 1.0 );
				depthColor = packedInput.positionCS.z;
				#elif defined(SCENESELECTIONPASS)
				outColor = float4( _ObjectId, _PassValue, 1.0, 1.0 );
				#endif
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "SceneSelectionPass"
			Tags { "LightMode"="SceneSelectionPass" }
			ColorMask 0

			HLSLPROGRAM

			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define HAVE_MESH_MODIFICATION
			#define ASE_SRP_VERSION 70301


			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _DOUBLESIDED_ON
			#pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
			#pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT
			#pragma shader_feature_local _ALPHATEST_ON

			#define SHADERPASS SHADERPASS_DEPTH_ONLY
			#define SCENESELECTIONPASS
			#pragma editor_sync_compilation

			#pragma vertex Vert
			#pragma fragment Frag

			//#define UNITY_MATERIAL_LIT

			#if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
			#endif

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#ifdef DEBUG_DISPLAY
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
			#endif
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define SHADER_GRAPH
			#pragma multi_compile _ MUDBUN_PROCEDURAL
			#include "Assets/MudBun/Shader/Render/ShaderCommon.cginc"
			#include "Assets/MudBun/Shader/Render/MeshCommon.cginc"


			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
				#define ASE_NEED_CULLFACE 1
			#endif

			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				uint ase_vertexID : SV_VertexID;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				float4 positionCS : SV_Position;
				float3 interp00 : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			int _ObjectId;
			int _PassValue;

			CBUFFER_START( UnityPerMaterial )
			float _UseTex0;
			float _RandomDither;
			int _DitherTextureSize;
			float _IsMeshRenderMaterial;
			float _Tex3Z;
			float _Tex3Y;
			float _Tex3X;
			float _Tex2Z;
			float _Tex2Y;
			float _AlphaCutoutThreshold;
			float _Tex2X;
			float _Tex1Y;
			float _Tex1X;
			float _MainTexZ;
			float _MainTexY;
			float _MainTexX;
			float _UseTex3;
			float _UseTex2;
			float _UseTex1;
			float _Tex1Z;
			float _Dithering;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
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
			sampler2D _Tex1;
			sampler2D _Tex2;
			sampler2D _Tex3;
			sampler2D _DitherTexture;


			float3 MudBunMeshPoint( int VertexID, out float3 PositionLs, out float3 NormalWs, out float3 NormalLs, out float4 Color, out float4 EmissionHash, out float Metallic, out float Smoothness, out float4 TextureWeight, out float SdfValue, out float3 Outward2dNormalLs, out float3 Outward2dNormalWs )
			{
				float4 positionWs;
				float2 metallicSmoothness;
				mudbun_mesh_vert(VertexID, positionWs, PositionLs, NormalWs, NormalLs, Color, EmissionHash, metallicSmoothness, TextureWeight, SdfValue, Outward2dNormalLs, Outward2dNormalWs);
				Metallic = metallicSmoothness.x;
				Smoothness = metallicSmoothness.y;
				return positionWs.xyz;
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout SceneSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				// surface data

				// refraction
				#ifdef _HAS_REFRACTION
				if( _EnableSSRefraction )
				{
					surfaceData.transmittanceMask = ( 1.0 - surfaceDescription.Alpha );
					surfaceDescription.Alpha = 1.0;
				}
				else
				{
					surfaceData.ior = 1.0;
					surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
					surfaceData.atDistance = 1.0;
					surfaceData.transmittanceMask = 0.0;
					surfaceDescription.Alpha = 1.0;
				}
				#else
				surfaceData.ior = 1.0;
				surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
				surfaceData.atDistance = 1.0;
				surfaceData.transmittanceMask = 0.0;
				#endif


				// material features
				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif
				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif
				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
				#endif
				#ifdef ASE_LIT_CLEAR_COAT
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				// others
				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
				surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif
				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				// normals
				float3 normalTS = float3(0.0f, 0.0f, 1.0f);
				GetNormalWS( fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants );

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];

				bentNormalWS = surfaceData.normalWS;

				surfaceData.tangentWS = normalize( fragInputs.tangentToWorld[ 0 ].xyz );
				surfaceData.tangentWS = Orthonormalize( surfaceData.tangentWS, surfaceData.normalWS );

				// decals
				#if HAVE_DECALS
				if( _EnableDecals )
				{
					DecalSurfaceData decalSurfaceData = GetDecalSurfaceData( posInput, surfaceDescription.Alpha );
					ApplyDecalToSurfaceData( decalSurfaceData, surfaceData );
				}
				#endif

				#if defined(_SPECULAR_OCCLUSION_CUSTOM)
				#elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO( V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness( surfaceData.perceptualSmoothness ) );
				#elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion( ClampNdotV( dot( surfaceData.normalWS, V ) ), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness( surfaceData.perceptualSmoothness ) );
				#endif

				// debug
				#if defined(DEBUG_DISPLAY)
				if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
				{
					surfaceData.metallic = 0;
				}
				ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
				#endif
			}

			void GetSurfaceAndBuiltinData(SceneSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
				LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				ApplyDoubleSidedFlipOrMirror( fragInputs, doubleSidedConstants );

				#ifdef _ALPHATEST_ON
				DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
				builtinData.depthOffset = surfaceDescription.DepthOffset;
				ApplyDepthOffsetPositionInput( V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput );
				#endif

				float3 bentNormalWS;
				BuildSurfaceData( fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS );

				InitBuiltinData( posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[ 2 ], fragInputs.texCoord1, fragInputs.texCoord2, builtinData );

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh )
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS;
				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				int VertexID4_g83 = inputMesh.ase_vertexID;
				float3 PositionLs4_g83 = float3( 0,0,0 );
				float3 NormalWs4_g83 = float3( 0,0,0 );
				float3 NormalLs4_g83 = float3( 0,0,0 );
				float4 Color4_g83 = float4( 0,0,0,0 );
				float4 EmissionHash4_g83 = float4( 0,0,0,0 );
				float Metallic4_g83 = 0.0;
				float Smoothness4_g83 = 0.0;
				float4 TextureWeight4_g83 = float4( 1,0,0,0 );
				float SdfValue4_g83 = 0.0;
				float3 Outward2dNormalLs4_g83 = float3( 0,0,0 );
				float3 Outward2dNormalWs4_g83 = float3( 0,0,0 );
				float3 localMudBunMeshPoint4_g83 = MudBunMeshPoint( VertexID4_g83 , PositionLs4_g83 , NormalWs4_g83 , NormalLs4_g83 , Color4_g83 , EmissionHash4_g83 , Metallic4_g83 , Smoothness4_g83 , TextureWeight4_g83 , SdfValue4_g83 , Outward2dNormalLs4_g83 , Outward2dNormalWs4_g83 );
				float3 temp_output_198_0 = localMudBunMeshPoint4_g83;
				
				float3 vertexToFrag213 = NormalLs4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord1.xyz = vertexToFrag213;
				float3 vertexToFrag212 = PositionLs4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord2.xyz = vertexToFrag212;
				float4 vertexToFrag216 = TextureWeight4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord3 = vertexToFrag216;
				float4 vertexToFrag5_g83 = Color4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord4 = vertexToFrag5_g83;
				float3 vertexToFrag16_g83 = localMudBunMeshPoint4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord5.xyz = vertexToFrag16_g83;
				float3 vertexToFrag27_g228 = temp_output_198_0;
				outputPackedVaryingsMeshToPS.ase_texcoord6.xyz = vertexToFrag27_g228;
				
				outputPackedVaryingsMeshToPS.ase_texcoord1.w = inputMesh.ase_vertexID;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord2.w = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord5.w = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord6.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = temp_output_198_0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS = NormalWs4_g83;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				outputPackedVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
				outputPackedVaryingsMeshToPS.interp00.xyz = positionRWS;
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				uint ase_vertexID : SV_VertexID;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.ase_vertexID = v.ase_vertexID;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
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
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_vertexID = patch[0].ase_vertexID * bary.x + patch[1].ase_vertexID * bary.y + patch[2].ase_vertexID * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			void Frag( PackedVaryingsMeshToPS packedInput
						#ifdef WRITE_NORMAL_BUFFER
						, out float4 outNormalBuffer : SV_Target0
							#ifdef WRITE_MSAA_DEPTH
							, out float1 depthColor : SV_Target1
							#endif
						#elif defined(WRITE_MSAA_DEPTH)
						, out float4 outNormalBuffer : SV_Target0
						, out float1 depthColor : SV_Target1
						#elif defined(SCENESELECTIONPASS)
						, out float4 outColor : SV_Target0
						#endif
						#ifdef _DEPTHOFFSET_ON
						, out float outputDepth : SV_Depth
						#endif
						
					)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				UNITY_SETUP_INSTANCE_ID( packedInput );

				float3 positionRWS = packedInput.interp00.xyz;

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);

				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				input.positionRWS = positionRWS;

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false );
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);

				SceneSurfaceDescription surfaceDescription = (SceneSurfaceDescription)0;
				float3 vertexToFrag213 = packedInput.ase_texcoord1.xyz;
				float3 weight54_g215 = abs( vertexToFrag213 );
				float3 appendResult83_g215 = (float3((float)(int)_MainTexX , (float)(int)_MainTexY , (float)(int)_MainTexZ));
				float3 weight0119_g215 = ( weight54_g215 * appendResult83_g215 );
				float3 temp_output_11_0_g223 = weight0119_g215;
				float3 break14_g223 = temp_output_11_0_g223;
				float3 vertexToFrag212 = packedInput.ase_texcoord2.xyz;
				float3 temp_output_36_0_g215 = vertexToFrag212;
				float2 uvX56_g215 = (temp_output_36_0_g215).yz;
				float4 appendResult23_g223 = (float4(temp_output_11_0_g223 , 0.0));
				float4 appendResult24_g223 = (float4(temp_output_11_0_g223 , 1.0));
				float4 break10_g224 = ( ( break14_g223.x + break14_g223.y + break14_g223.z ) > 0.0 ? appendResult23_g223 : appendResult24_g223 );
				float2 uvY57_g215 = (temp_output_36_0_g215).zx;
				float2 uvZ58_g215 = (temp_output_36_0_g215).xy;
				float4 color20_g223 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float4 vertexToFrag216 = packedInput.ase_texcoord3;
				float4 break10_g216 = vertexToFrag216;
				float3 appendResult123_g215 = (float3((float)(int)_Tex1X , (float)(int)_Tex1Y , (float)(int)_Tex1Z));
				float3 weight1126_g215 = ( weight54_g215 * appendResult123_g215 );
				float3 temp_output_11_0_g217 = weight1126_g215;
				float3 break14_g217 = temp_output_11_0_g217;
				float4 appendResult23_g217 = (float4(temp_output_11_0_g217 , 0.0));
				float4 appendResult24_g217 = (float4(temp_output_11_0_g217 , 1.0));
				float4 break10_g218 = ( ( break14_g217.x + break14_g217.y + break14_g217.z ) > 0.0 ? appendResult23_g217 : appendResult24_g217 );
				float4 color20_g217 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float3 appendResult130_g215 = (float3((float)(int)_Tex2X , (float)(int)_Tex2Y , (float)(int)_Tex2Z));
				float3 weight2133_g215 = ( weight54_g215 * appendResult130_g215 );
				float3 temp_output_11_0_g219 = weight2133_g215;
				float3 break14_g219 = temp_output_11_0_g219;
				float4 appendResult23_g219 = (float4(temp_output_11_0_g219 , 0.0));
				float4 appendResult24_g219 = (float4(temp_output_11_0_g219 , 1.0));
				float4 break10_g220 = ( ( break14_g219.x + break14_g219.y + break14_g219.z ) > 0.0 ? appendResult23_g219 : appendResult24_g219 );
				float4 color20_g219 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float3 appendResult137_g215 = (float3((float)(int)_Tex3X , (float)(int)_Tex3Y , (float)(int)_Tex3Z));
				float3 weight3140_g215 = ( weight54_g215 * appendResult137_g215 );
				float3 temp_output_11_0_g221 = weight3140_g215;
				float3 break14_g221 = temp_output_11_0_g221;
				float4 appendResult23_g221 = (float4(temp_output_11_0_g221 , 0.0));
				float4 appendResult24_g221 = (float4(temp_output_11_0_g221 , 1.0));
				float4 break10_g222 = ( ( break14_g221.x + break14_g221.y + break14_g221.z ) > 0.0 ? appendResult23_g221 : appendResult24_g221 );
				float4 color20_g221 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float4 color182 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
				float4 vertexToFrag5_g83 = packedInput.ase_texcoord4;
				float4 temp_output_25_0_g83 = ( _IsMeshRenderMaterial * _Color * vertexToFrag5_g83 );
				float4 temp_output_175_0 = ( ( ( _UseTex0 + _UseTex1 + _UseTex2 + _UseTex3 ) > 0.0 ? ( ( ( ( (float)(int)_UseTex0 > 0.0 ? ( ( ( ( break14_g223.x > 0.0 ? tex2D( _MainTex, uvX56_g215 ) : float4( 0,0,0,0 ) ) * break10_g224.x ) + ( ( break14_g223.y > 0.0 ? tex2D( _MainTex, uvY57_g215 ) : float4( 0,0,0,0 ) ) * break10_g224.y ) + ( ( break14_g223.z > 0.0 ? tex2D( _MainTex, uvZ58_g215 ) : float4( 0,0,0,0 ) ) * break10_g224.z ) + ( color20_g223 * break10_g224.w ) ) / ( break10_g224.x + break10_g224.y + break10_g224.z + break10_g224.w ) ) : float4( 0,0,0,0 ) ) * break10_g216.x ) + ( ( (float)(int)_UseTex1 > 0.0 ? ( ( ( ( break14_g217.x > 0.0 ? tex2D( _Tex1, uvX56_g215 ) : float4( 0,0,0,0 ) ) * break10_g218.x ) + ( ( break14_g217.y > 0.0 ? tex2D( _Tex1, uvY57_g215 ) : float4( 0,0,0,0 ) ) * break10_g218.y ) + ( ( break14_g217.z > 0.0 ? tex2D( _Tex1, uvZ58_g215 ) : float4( 0,0,0,0 ) ) * break10_g218.z ) + ( color20_g217 * break10_g218.w ) ) / ( break10_g218.x + break10_g218.y + break10_g218.z + break10_g218.w ) ) : float4( 0,0,0,0 ) ) * break10_g216.y ) + ( ( (float)(int)_UseTex2 > 0.0 ? ( ( ( ( break14_g219.x > 0.0 ? tex2D( _Tex2, uvX56_g215 ) : float4( 0,0,0,0 ) ) * break10_g220.x ) + ( ( break14_g219.y > 0.0 ? tex2D( _Tex2, uvY57_g215 ) : float4( 0,0,0,0 ) ) * break10_g220.y ) + ( ( break14_g219.z > 0.0 ? tex2D( _Tex2, uvZ58_g215 ) : float4( 0,0,0,0 ) ) * break10_g220.z ) + ( color20_g219 * break10_g220.w ) ) / ( break10_g220.x + break10_g220.y + break10_g220.z + break10_g220.w ) ) : float4( 0,0,0,0 ) ) * break10_g216.z ) + ( ( (float)(int)_UseTex3 > 0.0 ? ( ( ( ( break14_g221.x > 0.0 ? tex2D( _Tex3, uvX56_g215 ) : float4( 0,0,0,0 ) ) * break10_g222.x ) + ( ( break14_g221.y > 0.0 ? tex2D( _Tex3, uvY57_g215 ) : float4( 0,0,0,0 ) ) * break10_g222.y ) + ( ( break14_g221.z > 0.0 ? tex2D( _Tex3, uvZ58_g215 ) : float4( 0,0,0,0 ) ) * break10_g222.z ) + ( color20_g221 * break10_g222.w ) ) / ( break10_g222.x + break10_g222.y + break10_g222.z + break10_g222.w ) ) : float4( 0,0,0,0 ) ) * break10_g216.w ) ) / ( break10_g216.x + break10_g216.y + break10_g216.z + break10_g216.w ) ) : color182 ) * temp_output_25_0_g83 );
				float localComputeOpaqueTransparency20_g228 = ( 0.0 );
				float3 vertexToFrag16_g83 = packedInput.ase_texcoord5.xyz;
				float4 unityObjectToClipPos17_g83 = TransformWorldToHClip(TransformObjectToWorld(vertexToFrag16_g83));
				float4 computeScreenPos18_g83 = ComputeScreenPos( unityObjectToClipPos17_g83 , _ProjectionParams.x );
				float2 ScreenPos20_g228 = (( ( computeScreenPos18_g83 / (computeScreenPos18_g83).w ) * _ScreenParams )).xy;
				float3 vertexToFrag27_g228 = packedInput.ase_texcoord6.xyz;
				float3 VertPos20_g228 = vertexToFrag27_g228;
				int VertexID4_g83 = packedInput.ase_texcoord1.w;
				float3 PositionLs4_g83 = float3( 0,0,0 );
				float3 NormalWs4_g83 = float3( 0,0,0 );
				float3 NormalLs4_g83 = float3( 0,0,0 );
				float4 Color4_g83 = float4( 0,0,0,0 );
				float4 EmissionHash4_g83 = float4( 0,0,0,0 );
				float Metallic4_g83 = 0.0;
				float Smoothness4_g83 = 0.0;
				float4 TextureWeight4_g83 = float4( 1,0,0,0 );
				float SdfValue4_g83 = 0.0;
				float3 Outward2dNormalLs4_g83 = float3( 0,0,0 );
				float3 Outward2dNormalWs4_g83 = float3( 0,0,0 );
				float3 localMudBunMeshPoint4_g83 = MudBunMeshPoint( VertexID4_g83 , PositionLs4_g83 , NormalWs4_g83 , NormalLs4_g83 , Color4_g83 , EmissionHash4_g83 , Metallic4_g83 , Smoothness4_g83 , TextureWeight4_g83 , SdfValue4_g83 , Outward2dNormalLs4_g83 , Outward2dNormalWs4_g83 );
				float Hash20_g228 = (EmissionHash4_g83).w;
				float AlphaIn20_g228 = (temp_output_25_0_g83).a;
				float AlphaOut20_g228 = 0;
				float AlphaThreshold20_g228 = 0;
				sampler2D DitherNoiseTexture20_g228 = _DitherTexture;
				int DitherNoiseTextureSize20_g228 = _DitherTextureSize;
				int UseRandomDither20_g228 = (int)_RandomDither;
				float AlphaCutoutThreshold20_g228 = _AlphaCutoutThreshold;
				float DitherBlend20_g228 = _Dithering;
				{
				float alpha = AlphaIn20_g228;
				computeOpaqueTransparency(ScreenPos20_g228, VertPos20_g228, Hash20_g228, DitherNoiseTexture20_g228, DitherNoiseTextureSize20_g228, UseRandomDither20_g228 > 0, AlphaCutoutThreshold20_g228, DitherBlend20_g228,  alpha, AlphaThreshold20_g228);
				AlphaOut20_g228 = alpha;
				}
				float temp_output_224_0 = ( (temp_output_175_0).w * AlphaOut20_g228 );
				
				float temp_output_221_25 = AlphaThreshold20_g228;
				
				surfaceDescription.Alpha = temp_output_224_0;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = temp_output_221_25;
				#endif

				#ifdef _DEPTHOFFSET_ON
				surfaceDescription.DepthOffset = 0;
				#endif

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);

				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				#endif

				#ifdef WRITE_NORMAL_BUFFER
				EncodeIntoNormalBuffer( ConvertSurfaceDataToNormalData( surfaceData ), posInput.positionSS, outNormalBuffer );
				#ifdef WRITE_MSAA_DEPTH
				depthColor = packedInput.positionCS.z;
				#endif
				#elif defined(WRITE_MSAA_DEPTH)
				outNormalBuffer = float4( 0.0, 0.0, 0.0, 1.0 );
				depthColor = packedInput.positionCS.z;
				#elif defined(SCENESELECTIONPASS)
				outColor = float4( _ObjectId, _PassValue, 1.0, 1.0 );
				#endif
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			Cull [_CullMode]

			ZWrite On

			Stencil
			{
				Ref [_StencilRefDepth]
				WriteMask [_StencilWriteMaskDepth]
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}


			HLSLPROGRAM

			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define HAVE_MESH_MODIFICATION
			#define ASE_SRP_VERSION 70301


			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _DOUBLESIDED_ON
			#pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
			#pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT
			#pragma shader_feature_local _ALPHATEST_ON

			#define SHADERPASS SHADERPASS_DEPTH_ONLY
			#pragma multi_compile _ WRITE_NORMAL_BUFFER
			#pragma multi_compile _ WRITE_MSAA_DEPTH

			#pragma vertex Vert
			#pragma fragment Frag

			//#define UNITY_MATERIAL_LIT

			#if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
			#endif

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#ifdef DEBUG_DISPLAY
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
			#endif
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define SHADER_GRAPH
			#pragma multi_compile _ MUDBUN_PROCEDURAL
			#include "Assets/MudBun/Shader/Render/ShaderCommon.cginc"
			#include "Assets/MudBun/Shader/Render/MeshCommon.cginc"


			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
				#define ASE_NEED_CULLFACE 1
			#endif

			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				uint ase_vertexID : SV_VertexID;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				float4 positionCS : SV_Position;
				float3 interp00 : TEXCOORD0;
				float3 interp01 : TEXCOORD1;
				float4 interp02 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			CBUFFER_START( UnityPerMaterial )
			float _UseTex0;
			float _RandomDither;
			int _DitherTextureSize;
			float _IsMeshRenderMaterial;
			float _Tex3Z;
			float _Tex3Y;
			float _Tex3X;
			float _Tex2Z;
			float _Tex2Y;
			float _AlphaCutoutThreshold;
			float _Tex2X;
			float _Tex1Y;
			float _Tex1X;
			float _MainTexZ;
			float _MainTexY;
			float _MainTexX;
			float _UseTex3;
			float _UseTex2;
			float _UseTex1;
			float _Tex1Z;
			float _Dithering;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
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
			sampler2D _Tex1;
			sampler2D _Tex2;
			sampler2D _Tex3;
			sampler2D _DitherTexture;


			float3 MudBunMeshPoint( int VertexID, out float3 PositionLs, out float3 NormalWs, out float3 NormalLs, out float4 Color, out float4 EmissionHash, out float Metallic, out float Smoothness, out float4 TextureWeight, out float SdfValue, out float3 Outward2dNormalLs, out float3 Outward2dNormalWs )
			{
				float4 positionWs;
				float2 metallicSmoothness;
				mudbun_mesh_vert(VertexID, positionWs, PositionLs, NormalWs, NormalLs, Color, EmissionHash, metallicSmoothness, TextureWeight, SdfValue, Outward2dNormalLs, Outward2dNormalWs);
				Metallic = metallicSmoothness.x;
				Smoothness = metallicSmoothness.y;
				return positionWs.xyz;
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout SmoothSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				// surface data
				surfaceData.perceptualSmoothness =		surfaceDescription.Smoothness;

				// refraction
				#ifdef _HAS_REFRACTION
				if( _EnableSSRefraction )
				{
					surfaceData.transmittanceMask = ( 1.0 - surfaceDescription.Alpha );
					surfaceDescription.Alpha = 1.0;
				}
				else
				{
					surfaceData.ior = 1.0;
					surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
					surfaceData.atDistance = 1.0;
					surfaceData.transmittanceMask = 0.0;
					surfaceDescription.Alpha = 1.0;
				}
				#else
				surfaceData.ior = 1.0;
				surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
				surfaceData.atDistance = 1.0;
				surfaceData.transmittanceMask = 0.0;
				#endif


				// material features
				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif
				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif
				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
				#endif
				#ifdef ASE_LIT_CLEAR_COAT
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				// others
				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
				surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif
				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				// normals
				float3 normalTS = float3(0.0f, 0.0f, 1.0f);
				normalTS = surfaceDescription.Normal;
				GetNormalWS( fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants );

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];

				bentNormalWS = surfaceData.normalWS;

				surfaceData.tangentWS = normalize( fragInputs.tangentToWorld[ 0 ].xyz );
				surfaceData.tangentWS = Orthonormalize( surfaceData.tangentWS, surfaceData.normalWS );

				// decals
				#if HAVE_DECALS
				if( _EnableDecals )
				{
					DecalSurfaceData decalSurfaceData = GetDecalSurfaceData( posInput, surfaceDescription.Alpha );
					ApplyDecalToSurfaceData( decalSurfaceData, surfaceData );
				}
				#endif

				#if defined(_SPECULAR_OCCLUSION_CUSTOM)
				#elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO( V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness( surfaceData.perceptualSmoothness ) );
				#elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion( ClampNdotV( dot( surfaceData.normalWS, V ) ), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness( surfaceData.perceptualSmoothness ) );
				#endif

				// debug
				#if defined(DEBUG_DISPLAY)
				if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
				{
					surfaceData.metallic = 0;
				}
				ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
				#endif
			}

			void GetSurfaceAndBuiltinData(SmoothSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
				LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				ApplyDoubleSidedFlipOrMirror( fragInputs, doubleSidedConstants );

				#ifdef _ALPHATEST_ON
				DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
				builtinData.depthOffset = surfaceDescription.DepthOffset;
				ApplyDepthOffsetPositionInput( V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput );
				#endif

				float3 bentNormalWS;
				BuildSurfaceData( fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS );

				InitBuiltinData( posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[ 2 ], fragInputs.texCoord1, fragInputs.texCoord2, builtinData );

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh )
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				int VertexID4_g83 = inputMesh.ase_vertexID;
				float3 PositionLs4_g83 = float3( 0,0,0 );
				float3 NormalWs4_g83 = float3( 0,0,0 );
				float3 NormalLs4_g83 = float3( 0,0,0 );
				float4 Color4_g83 = float4( 0,0,0,0 );
				float4 EmissionHash4_g83 = float4( 0,0,0,0 );
				float Metallic4_g83 = 0.0;
				float Smoothness4_g83 = 0.0;
				float4 TextureWeight4_g83 = float4( 1,0,0,0 );
				float SdfValue4_g83 = 0.0;
				float3 Outward2dNormalLs4_g83 = float3( 0,0,0 );
				float3 Outward2dNormalWs4_g83 = float3( 0,0,0 );
				float3 localMudBunMeshPoint4_g83 = MudBunMeshPoint( VertexID4_g83 , PositionLs4_g83 , NormalWs4_g83 , NormalLs4_g83 , Color4_g83 , EmissionHash4_g83 , Metallic4_g83 , Smoothness4_g83 , TextureWeight4_g83 , SdfValue4_g83 , Outward2dNormalLs4_g83 , Outward2dNormalWs4_g83 );
				float3 temp_output_198_0 = localMudBunMeshPoint4_g83;
				
				float vertexToFrag7_g83 = Smoothness4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord3.x = vertexToFrag7_g83;
				
				float3 vertexToFrag213 = NormalLs4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord3.yzw = vertexToFrag213;
				float3 vertexToFrag212 = PositionLs4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord4.xyz = vertexToFrag212;
				float4 vertexToFrag216 = TextureWeight4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord5 = vertexToFrag216;
				float4 vertexToFrag5_g83 = Color4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord6 = vertexToFrag5_g83;
				float3 vertexToFrag16_g83 = localMudBunMeshPoint4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord7.xyz = vertexToFrag16_g83;
				float3 vertexToFrag27_g228 = temp_output_198_0;
				outputPackedVaryingsMeshToPS.ase_texcoord8.xyz = vertexToFrag27_g228;
				
				outputPackedVaryingsMeshToPS.ase_texcoord4.w = inputMesh.ase_vertexID;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord7.w = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord8.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = temp_output_198_0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS = NormalWs4_g83;
				inputMesh.tangentOS =  inputMesh.tangentOS ;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);
				float4 tangentWS = float4(TransformObjectToWorldDir(inputMesh.tangentOS.xyz), inputMesh.tangentOS.w);

				outputPackedVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
				outputPackedVaryingsMeshToPS.interp00.xyz = positionRWS;
				outputPackedVaryingsMeshToPS.interp01.xyz = normalWS;
				outputPackedVaryingsMeshToPS.interp02.xyzw = tangentWS;
				return outputPackedVaryingsMeshToPS;
			}
			
			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				uint ase_vertexID : SV_VertexID;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.ase_vertexID = v.ase_vertexID;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
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
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.ase_vertexID = patch[0].ase_vertexID * bary.x + patch[1].ase_vertexID * bary.y + patch[2].ase_vertexID * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			void Frag( PackedVaryingsMeshToPS packedInput
						#ifdef WRITE_NORMAL_BUFFER
						, out float4 outNormalBuffer : SV_Target0
							#ifdef WRITE_MSAA_DEPTH
							, out float1 depthColor : SV_Target1
							#endif
						#elif defined(WRITE_MSAA_DEPTH)
						, out float4 outNormalBuffer : SV_Target0
						, out float1 depthColor : SV_Target1
						#elif defined(SCENESELECTIONPASS)
						, out float4 outColor : SV_Target0
						#endif
						#ifdef _DEPTHOFFSET_ON
						, out float outputDepth : SV_Depth
						#endif
						
					)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				UNITY_SETUP_INSTANCE_ID( packedInput );

				float3 positionRWS = packedInput.interp00.xyz;
				float3 normalWS = packedInput.interp01.xyz;
				float4 tangentWS = packedInput.interp02.xyzw;

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);

				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				input.positionRWS = positionRWS;
				input.tangentToWorld = BuildTangentToWorld(tangentWS, normalWS);

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false );
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);

				SmoothSurfaceDescription surfaceDescription = (SmoothSurfaceDescription)0;
				float vertexToFrag7_g83 = packedInput.ase_texcoord3.x;
				
				float3 vertexToFrag213 = packedInput.ase_texcoord3.yzw;
				float3 weight54_g215 = abs( vertexToFrag213 );
				float3 appendResult83_g215 = (float3((float)(int)_MainTexX , (float)(int)_MainTexY , (float)(int)_MainTexZ));
				float3 weight0119_g215 = ( weight54_g215 * appendResult83_g215 );
				float3 temp_output_11_0_g223 = weight0119_g215;
				float3 break14_g223 = temp_output_11_0_g223;
				float3 vertexToFrag212 = packedInput.ase_texcoord4.xyz;
				float3 temp_output_36_0_g215 = vertexToFrag212;
				float2 uvX56_g215 = (temp_output_36_0_g215).yz;
				float4 appendResult23_g223 = (float4(temp_output_11_0_g223 , 0.0));
				float4 appendResult24_g223 = (float4(temp_output_11_0_g223 , 1.0));
				float4 break10_g224 = ( ( break14_g223.x + break14_g223.y + break14_g223.z ) > 0.0 ? appendResult23_g223 : appendResult24_g223 );
				float2 uvY57_g215 = (temp_output_36_0_g215).zx;
				float2 uvZ58_g215 = (temp_output_36_0_g215).xy;
				float4 color20_g223 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float4 vertexToFrag216 = packedInput.ase_texcoord5;
				float4 break10_g216 = vertexToFrag216;
				float3 appendResult123_g215 = (float3((float)(int)_Tex1X , (float)(int)_Tex1Y , (float)(int)_Tex1Z));
				float3 weight1126_g215 = ( weight54_g215 * appendResult123_g215 );
				float3 temp_output_11_0_g217 = weight1126_g215;
				float3 break14_g217 = temp_output_11_0_g217;
				float4 appendResult23_g217 = (float4(temp_output_11_0_g217 , 0.0));
				float4 appendResult24_g217 = (float4(temp_output_11_0_g217 , 1.0));
				float4 break10_g218 = ( ( break14_g217.x + break14_g217.y + break14_g217.z ) > 0.0 ? appendResult23_g217 : appendResult24_g217 );
				float4 color20_g217 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float3 appendResult130_g215 = (float3((float)(int)_Tex2X , (float)(int)_Tex2Y , (float)(int)_Tex2Z));
				float3 weight2133_g215 = ( weight54_g215 * appendResult130_g215 );
				float3 temp_output_11_0_g219 = weight2133_g215;
				float3 break14_g219 = temp_output_11_0_g219;
				float4 appendResult23_g219 = (float4(temp_output_11_0_g219 , 0.0));
				float4 appendResult24_g219 = (float4(temp_output_11_0_g219 , 1.0));
				float4 break10_g220 = ( ( break14_g219.x + break14_g219.y + break14_g219.z ) > 0.0 ? appendResult23_g219 : appendResult24_g219 );
				float4 color20_g219 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float3 appendResult137_g215 = (float3((float)(int)_Tex3X , (float)(int)_Tex3Y , (float)(int)_Tex3Z));
				float3 weight3140_g215 = ( weight54_g215 * appendResult137_g215 );
				float3 temp_output_11_0_g221 = weight3140_g215;
				float3 break14_g221 = temp_output_11_0_g221;
				float4 appendResult23_g221 = (float4(temp_output_11_0_g221 , 0.0));
				float4 appendResult24_g221 = (float4(temp_output_11_0_g221 , 1.0));
				float4 break10_g222 = ( ( break14_g221.x + break14_g221.y + break14_g221.z ) > 0.0 ? appendResult23_g221 : appendResult24_g221 );
				float4 color20_g221 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float4 color182 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
				float4 vertexToFrag5_g83 = packedInput.ase_texcoord6;
				float4 temp_output_25_0_g83 = ( _IsMeshRenderMaterial * _Color * vertexToFrag5_g83 );
				float4 temp_output_175_0 = ( ( ( _UseTex0 + _UseTex1 + _UseTex2 + _UseTex3 ) > 0.0 ? ( ( ( ( (float)(int)_UseTex0 > 0.0 ? ( ( ( ( break14_g223.x > 0.0 ? tex2D( _MainTex, uvX56_g215 ) : float4( 0,0,0,0 ) ) * break10_g224.x ) + ( ( break14_g223.y > 0.0 ? tex2D( _MainTex, uvY57_g215 ) : float4( 0,0,0,0 ) ) * break10_g224.y ) + ( ( break14_g223.z > 0.0 ? tex2D( _MainTex, uvZ58_g215 ) : float4( 0,0,0,0 ) ) * break10_g224.z ) + ( color20_g223 * break10_g224.w ) ) / ( break10_g224.x + break10_g224.y + break10_g224.z + break10_g224.w ) ) : float4( 0,0,0,0 ) ) * break10_g216.x ) + ( ( (float)(int)_UseTex1 > 0.0 ? ( ( ( ( break14_g217.x > 0.0 ? tex2D( _Tex1, uvX56_g215 ) : float4( 0,0,0,0 ) ) * break10_g218.x ) + ( ( break14_g217.y > 0.0 ? tex2D( _Tex1, uvY57_g215 ) : float4( 0,0,0,0 ) ) * break10_g218.y ) + ( ( break14_g217.z > 0.0 ? tex2D( _Tex1, uvZ58_g215 ) : float4( 0,0,0,0 ) ) * break10_g218.z ) + ( color20_g217 * break10_g218.w ) ) / ( break10_g218.x + break10_g218.y + break10_g218.z + break10_g218.w ) ) : float4( 0,0,0,0 ) ) * break10_g216.y ) + ( ( (float)(int)_UseTex2 > 0.0 ? ( ( ( ( break14_g219.x > 0.0 ? tex2D( _Tex2, uvX56_g215 ) : float4( 0,0,0,0 ) ) * break10_g220.x ) + ( ( break14_g219.y > 0.0 ? tex2D( _Tex2, uvY57_g215 ) : float4( 0,0,0,0 ) ) * break10_g220.y ) + ( ( break14_g219.z > 0.0 ? tex2D( _Tex2, uvZ58_g215 ) : float4( 0,0,0,0 ) ) * break10_g220.z ) + ( color20_g219 * break10_g220.w ) ) / ( break10_g220.x + break10_g220.y + break10_g220.z + break10_g220.w ) ) : float4( 0,0,0,0 ) ) * break10_g216.z ) + ( ( (float)(int)_UseTex3 > 0.0 ? ( ( ( ( break14_g221.x > 0.0 ? tex2D( _Tex3, uvX56_g215 ) : float4( 0,0,0,0 ) ) * break10_g222.x ) + ( ( break14_g221.y > 0.0 ? tex2D( _Tex3, uvY57_g215 ) : float4( 0,0,0,0 ) ) * break10_g222.y ) + ( ( break14_g221.z > 0.0 ? tex2D( _Tex3, uvZ58_g215 ) : float4( 0,0,0,0 ) ) * break10_g222.z ) + ( color20_g221 * break10_g222.w ) ) / ( break10_g222.x + break10_g222.y + break10_g222.z + break10_g222.w ) ) : float4( 0,0,0,0 ) ) * break10_g216.w ) ) / ( break10_g216.x + break10_g216.y + break10_g216.z + break10_g216.w ) ) : color182 ) * temp_output_25_0_g83 );
				float localComputeOpaqueTransparency20_g228 = ( 0.0 );
				float3 vertexToFrag16_g83 = packedInput.ase_texcoord7.xyz;
				float4 unityObjectToClipPos17_g83 = TransformWorldToHClip(TransformObjectToWorld(vertexToFrag16_g83));
				float4 computeScreenPos18_g83 = ComputeScreenPos( unityObjectToClipPos17_g83 , _ProjectionParams.x );
				float2 ScreenPos20_g228 = (( ( computeScreenPos18_g83 / (computeScreenPos18_g83).w ) * _ScreenParams )).xy;
				float3 vertexToFrag27_g228 = packedInput.ase_texcoord8.xyz;
				float3 VertPos20_g228 = vertexToFrag27_g228;
				int VertexID4_g83 = packedInput.ase_texcoord4.w;
				float3 PositionLs4_g83 = float3( 0,0,0 );
				float3 NormalWs4_g83 = float3( 0,0,0 );
				float3 NormalLs4_g83 = float3( 0,0,0 );
				float4 Color4_g83 = float4( 0,0,0,0 );
				float4 EmissionHash4_g83 = float4( 0,0,0,0 );
				float Metallic4_g83 = 0.0;
				float Smoothness4_g83 = 0.0;
				float4 TextureWeight4_g83 = float4( 1,0,0,0 );
				float SdfValue4_g83 = 0.0;
				float3 Outward2dNormalLs4_g83 = float3( 0,0,0 );
				float3 Outward2dNormalWs4_g83 = float3( 0,0,0 );
				float3 localMudBunMeshPoint4_g83 = MudBunMeshPoint( VertexID4_g83 , PositionLs4_g83 , NormalWs4_g83 , NormalLs4_g83 , Color4_g83 , EmissionHash4_g83 , Metallic4_g83 , Smoothness4_g83 , TextureWeight4_g83 , SdfValue4_g83 , Outward2dNormalLs4_g83 , Outward2dNormalWs4_g83 );
				float Hash20_g228 = (EmissionHash4_g83).w;
				float AlphaIn20_g228 = (temp_output_25_0_g83).a;
				float AlphaOut20_g228 = 0;
				float AlphaThreshold20_g228 = 0;
				sampler2D DitherNoiseTexture20_g228 = _DitherTexture;
				int DitherNoiseTextureSize20_g228 = _DitherTextureSize;
				int UseRandomDither20_g228 = (int)_RandomDither;
				float AlphaCutoutThreshold20_g228 = _AlphaCutoutThreshold;
				float DitherBlend20_g228 = _Dithering;
				{
				float alpha = AlphaIn20_g228;
				computeOpaqueTransparency(ScreenPos20_g228, VertPos20_g228, Hash20_g228, DitherNoiseTexture20_g228, DitherNoiseTextureSize20_g228, UseRandomDither20_g228 > 0, AlphaCutoutThreshold20_g228, DitherBlend20_g228,  alpha, AlphaThreshold20_g228);
				AlphaOut20_g228 = alpha;
				}
				float temp_output_224_0 = ( (temp_output_175_0).w * AlphaOut20_g228 );
				
				float temp_output_221_25 = AlphaThreshold20_g228;
				
				surfaceDescription.Normal = float3( 0, 0, 1 );
				surfaceDescription.Smoothness = ( _Smoothness * vertexToFrag7_g83 );
				surfaceDescription.Alpha = temp_output_224_0;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = temp_output_221_25;
				#endif

				#ifdef _DEPTHOFFSET_ON
				surfaceDescription.DepthOffset = 0;
				#endif

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);

				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				#endif

				#ifdef WRITE_NORMAL_BUFFER
				EncodeIntoNormalBuffer( ConvertSurfaceDataToNormalData( surfaceData ), posInput.positionSS, outNormalBuffer );
				#ifdef WRITE_MSAA_DEPTH
				depthColor = packedInput.positionCS.z;
				#endif
				#elif defined(WRITE_MSAA_DEPTH)
				outNormalBuffer = float4( 0.0, 0.0, 0.0, 1.0 );
				depthColor = packedInput.positionCS.z;
				#elif defined(SCENESELECTIONPASS)
				outColor = float4( _ObjectId, _PassValue, 1.0, 1.0 );
				#endif
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "Motion Vectors"
			Tags { "LightMode"="MotionVectors" }

			Cull [_CullMode]

			ZWrite On

			Stencil
			{
				Ref [_StencilRefMV]
				WriteMask [_StencilWriteMaskMV]
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}


			HLSLPROGRAM

			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define HAVE_MESH_MODIFICATION
			#define ASE_SRP_VERSION 70301


			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _DOUBLESIDED_ON
			#pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
			#pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT
			#pragma shader_feature_local _ALPHATEST_ON

			#define SHADERPASS SHADERPASS_MOTION_VECTORS
			#pragma multi_compile _ WRITE_NORMAL_BUFFER
			#pragma multi_compile _ WRITE_MSAA_DEPTH

			#pragma vertex Vert
			#pragma fragment Frag

			//#define UNITY_MATERIAL_LIT

			#if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
			#endif

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"


			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#ifdef DEBUG_DISPLAY
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
			#endif
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define SHADER_GRAPH
			#pragma multi_compile _ MUDBUN_PROCEDURAL
			#include "Assets/MudBun/Shader/Render/ShaderCommon.cginc"
			#include "Assets/MudBun/Shader/Render/MeshCommon.cginc"


			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
				#define ASE_NEED_CULLFACE 1
			#endif


			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float3 previousPositionOS : TEXCOORD4;
				#if defined (_ADD_PRECOMPUTED_VELOCITY)
					float3 precomputedVelocity : TEXCOORD5;
				#endif
				uint ase_vertexID : SV_VertexID;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				float4 vmeshPositionCS : SV_Position;
				float3 vmeshInterp00 : TEXCOORD0;
				float3 vpassInterpolators0 : TEXCOORD1; //interpolators0
				float3 vpassInterpolators1 : TEXCOORD2; //interpolators1
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			CBUFFER_START( UnityPerMaterial )
			float _UseTex0;
			float _RandomDither;
			int _DitherTextureSize;
			float _IsMeshRenderMaterial;
			float _Tex3Z;
			float _Tex3Y;
			float _Tex3X;
			float _Tex2Z;
			float _Tex2Y;
			float _AlphaCutoutThreshold;
			float _Tex2X;
			float _Tex1Y;
			float _Tex1X;
			float _MainTexZ;
			float _MainTexY;
			float _MainTexX;
			float _UseTex3;
			float _UseTex2;
			float _UseTex1;
			float _Tex1Z;
			float _Dithering;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
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
			sampler2D _Tex1;
			sampler2D _Tex2;
			sampler2D _Tex3;
			sampler2D _DitherTexture;


			float3 MudBunMeshPoint( int VertexID, out float3 PositionLs, out float3 NormalWs, out float3 NormalLs, out float4 Color, out float4 EmissionHash, out float Metallic, out float Smoothness, out float4 TextureWeight, out float SdfValue, out float3 Outward2dNormalLs, out float3 Outward2dNormalWs )
			{
				float4 positionWs;
				float2 metallicSmoothness;
				mudbun_mesh_vert(VertexID, positionWs, PositionLs, NormalWs, NormalLs, Color, EmissionHash, metallicSmoothness, TextureWeight, SdfValue, Outward2dNormalLs, Outward2dNormalWs);
				Metallic = metallicSmoothness.x;
				Smoothness = metallicSmoothness.y;
				return positionWs.xyz;
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout SmoothSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				// surface data
				surfaceData.perceptualSmoothness =		surfaceDescription.Smoothness;

				// refraction
				#ifdef _HAS_REFRACTION
				if( _EnableSSRefraction )
				{
					surfaceData.transmittanceMask = ( 1.0 - surfaceDescription.Alpha );
					surfaceDescription.Alpha = 1.0;
				}
				else
				{
					surfaceData.ior = 1.0;
					surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
					surfaceData.atDistance = 1.0;
					surfaceData.transmittanceMask = 0.0;
					surfaceDescription.Alpha = 1.0;
				}
				#else
				surfaceData.ior = 1.0;
				surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
				surfaceData.atDistance = 1.0;
				surfaceData.transmittanceMask = 0.0;
				#endif


				// material features
				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif
				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif
				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
				#endif
				#ifdef ASE_LIT_CLEAR_COAT
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				// others
				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
				surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif
				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				// normals
				float3 normalTS = float3(0.0f, 0.0f, 1.0f);
				normalTS = surfaceDescription.Normal;
				GetNormalWS( fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants );

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];

				bentNormalWS = surfaceData.normalWS;

				surfaceData.tangentWS = normalize( fragInputs.tangentToWorld[ 0 ].xyz );
				surfaceData.tangentWS = Orthonormalize( surfaceData.tangentWS, surfaceData.normalWS );

				// decals
				#if HAVE_DECALS
				if( _EnableDecals )
				{
					DecalSurfaceData decalSurfaceData = GetDecalSurfaceData( posInput, surfaceDescription.Alpha );
					ApplyDecalToSurfaceData( decalSurfaceData, surfaceData );
				}
				#endif

				#if defined(_SPECULAR_OCCLUSION_CUSTOM)
				#elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO( V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness( surfaceData.perceptualSmoothness ) );
				#elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion( ClampNdotV( dot( surfaceData.normalWS, V ) ), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness( surfaceData.perceptualSmoothness ) );
				#endif

				// debug
				#if defined(DEBUG_DISPLAY)
				if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
				{
					surfaceData.metallic = 0;
				}
				ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
				#endif
			}

			void GetSurfaceAndBuiltinData(SmoothSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
				LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				ApplyDoubleSidedFlipOrMirror( fragInputs, doubleSidedConstants );

				#ifdef _ALPHATEST_ON
				DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
				builtinData.depthOffset = surfaceDescription.DepthOffset;
				ApplyDepthOffsetPositionInput( V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput );
				#endif

				float3 bentNormalWS;
				BuildSurfaceData( fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS );

				InitBuiltinData( posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[ 2 ], fragInputs.texCoord1, fragInputs.texCoord2, builtinData );

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			AttributesMesh ApplyMeshModification(AttributesMesh inputMesh, float3 timeParameters, inout PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS )
			{
				_TimeParameters.xyz = timeParameters;
				int VertexID4_g83 = inputMesh.ase_vertexID;
				float3 PositionLs4_g83 = float3( 0,0,0 );
				float3 NormalWs4_g83 = float3( 0,0,0 );
				float3 NormalLs4_g83 = float3( 0,0,0 );
				float4 Color4_g83 = float4( 0,0,0,0 );
				float4 EmissionHash4_g83 = float4( 0,0,0,0 );
				float Metallic4_g83 = 0.0;
				float Smoothness4_g83 = 0.0;
				float4 TextureWeight4_g83 = float4( 1,0,0,0 );
				float SdfValue4_g83 = 0.0;
				float3 Outward2dNormalLs4_g83 = float3( 0,0,0 );
				float3 Outward2dNormalWs4_g83 = float3( 0,0,0 );
				float3 localMudBunMeshPoint4_g83 = MudBunMeshPoint( VertexID4_g83 , PositionLs4_g83 , NormalWs4_g83 , NormalLs4_g83 , Color4_g83 , EmissionHash4_g83 , Metallic4_g83 , Smoothness4_g83 , TextureWeight4_g83 , SdfValue4_g83 , Outward2dNormalLs4_g83 , Outward2dNormalWs4_g83 );
				float3 temp_output_198_0 = localMudBunMeshPoint4_g83;
				
				float vertexToFrag7_g83 = Smoothness4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord3.x = vertexToFrag7_g83;
				
				float3 vertexToFrag213 = NormalLs4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord3.yzw = vertexToFrag213;
				float3 vertexToFrag212 = PositionLs4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord4.xyz = vertexToFrag212;
				float4 vertexToFrag216 = TextureWeight4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord5 = vertexToFrag216;
				float4 vertexToFrag5_g83 = Color4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord6 = vertexToFrag5_g83;
				float3 vertexToFrag16_g83 = localMudBunMeshPoint4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord7.xyz = vertexToFrag16_g83;
				float3 vertexToFrag27_g228 = temp_output_198_0;
				outputPackedVaryingsMeshToPS.ase_texcoord8.xyz = vertexToFrag27_g228;
				
				outputPackedVaryingsMeshToPS.ase_texcoord4.w = inputMesh.ase_vertexID;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord7.w = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord8.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = temp_output_198_0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif
				inputMesh.normalOS = NormalWs4_g83;
				return inputMesh;
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh)
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS = (PackedVaryingsMeshToPS)0;
				AttributesMesh defaultMesh = inputMesh;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				inputMesh = ApplyMeshModification( inputMesh, _TimeParameters.xyz, outputPackedVaryingsMeshToPS);

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);

				float3 VMESHpositionRWS = positionRWS;
				float4 VMESHpositionCS = TransformWorldToHClip(positionRWS);

				float4 VPASSpreviousPositionCS;
				float4 VPASSpositionCS = mul(UNITY_MATRIX_UNJITTERED_VP, float4(VMESHpositionRWS, 1.0));

				bool forceNoMotion = unity_MotionVectorsParams.y == 0.0;
				if (forceNoMotion)
				{
					VPASSpreviousPositionCS = float4(0.0, 0.0, 0.0, 1.0);
				}
				else
				{
					bool hasDeformation = unity_MotionVectorsParams.x > 0.0;
					float3 effectivePositionOS = (hasDeformation ? inputMesh.previousPositionOS : defaultMesh.positionOS);
					#if defined(_ADD_PRECOMPUTED_VELOCITY)
					effectivePositionOS -= inputMesh.precomputedVelocity;
					#endif

					#if defined(HAVE_MESH_MODIFICATION)
						AttributesMesh previousMesh = defaultMesh;
						previousMesh.positionOS = effectivePositionOS ;
						PackedVaryingsMeshToPS test = (PackedVaryingsMeshToPS)0;
						float3 curTime = _TimeParameters.xyz;
						previousMesh = ApplyMeshModification(previousMesh, _LastTimeParameters.xyz, test);
						_TimeParameters.xyz = curTime;
						float3 previousPositionRWS = TransformPreviousObjectToWorld(previousMesh.positionOS);
					#else
						float3 previousPositionRWS = TransformPreviousObjectToWorld(effectivePositionOS);
					#endif

					#ifdef ATTRIBUTES_NEED_NORMAL
						float3 normalWS = TransformPreviousObjectToWorldNormal(defaultMesh.normalOS);
					#else
						float3 normalWS = float3(0.0, 0.0, 0.0);
					#endif

					#if defined(HAVE_VERTEX_MODIFICATION)
						//ApplyVertexModification(inputMesh, normalWS, previousPositionRWS, _LastTimeParameters.xyz);
					#endif

					VPASSpreviousPositionCS = mul(UNITY_MATRIX_PREV_VP, float4(previousPositionRWS, 1.0));
				}

				outputPackedVaryingsMeshToPS.vmeshPositionCS = VMESHpositionCS;
				outputPackedVaryingsMeshToPS.vmeshInterp00.xyz = VMESHpositionRWS;

				outputPackedVaryingsMeshToPS.vpassInterpolators0 = float3(VPASSpositionCS.xyw);
				outputPackedVaryingsMeshToPS.vpassInterpolators1 = float3(VPASSpreviousPositionCS.xyw);
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float3 previousPositionOS : TEXCOORD4;
				#if defined (_ADD_PRECOMPUTED_VELOCITY)
					float3 precomputedVelocity : TEXCOORD5;
				#endif
				uint ase_vertexID : SV_VertexID;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.previousPositionOS = v.previousPositionOS;
				#if defined (_ADD_PRECOMPUTED_VELOCITY)
				o.precomputedVelocity = v.precomputedVelocity;
				#endif
				o.ase_vertexID = v.ase_vertexID;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
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
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.previousPositionOS = patch[0].previousPositionOS * bary.x + patch[1].previousPositionOS * bary.y + patch[2].previousPositionOS * bary.z;
				#if defined (_ADD_PRECOMPUTED_VELOCITY)
					o.precomputedVelocity = patch[0].precomputedVelocity * bary.x + patch[1].precomputedVelocity * bary.y + patch[2].precomputedVelocity * bary.z;
				#endif
				o.ase_vertexID = patch[0].ase_vertexID * bary.x + patch[1].ase_vertexID * bary.y + patch[2].ase_vertexID * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			void Frag( PackedVaryingsMeshToPS packedInput
				, out float4 outMotionVector : SV_Target0
				#ifdef WRITE_NORMAL_BUFFER
				, out float4 outNormalBuffer : SV_Target1
					#ifdef WRITE_MSAA_DEPTH
						, out float1 depthColor : SV_Target2
					#endif
				#elif defined(WRITE_MSAA_DEPTH)
				, out float4 outNormalBuffer : SV_Target1
				, out float1 depthColor : SV_Target2
				#endif

				#ifdef _DEPTHOFFSET_ON
					, out float outputDepth : SV_Depth
				#endif
				
				)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				UNITY_SETUP_INSTANCE_ID( packedInput );
				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.vmeshPositionCS;
				input.positionRWS = packedInput.vmeshInterp00.xyz;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);

				SurfaceData surfaceData;
				BuiltinData builtinData;

				SmoothSurfaceDescription surfaceDescription = (SmoothSurfaceDescription)0;
				float vertexToFrag7_g83 = packedInput.ase_texcoord3.x;
				
				float3 vertexToFrag213 = packedInput.ase_texcoord3.yzw;
				float3 weight54_g215 = abs( vertexToFrag213 );
				float3 appendResult83_g215 = (float3((float)(int)_MainTexX , (float)(int)_MainTexY , (float)(int)_MainTexZ));
				float3 weight0119_g215 = ( weight54_g215 * appendResult83_g215 );
				float3 temp_output_11_0_g223 = weight0119_g215;
				float3 break14_g223 = temp_output_11_0_g223;
				float3 vertexToFrag212 = packedInput.ase_texcoord4.xyz;
				float3 temp_output_36_0_g215 = vertexToFrag212;
				float2 uvX56_g215 = (temp_output_36_0_g215).yz;
				float4 appendResult23_g223 = (float4(temp_output_11_0_g223 , 0.0));
				float4 appendResult24_g223 = (float4(temp_output_11_0_g223 , 1.0));
				float4 break10_g224 = ( ( break14_g223.x + break14_g223.y + break14_g223.z ) > 0.0 ? appendResult23_g223 : appendResult24_g223 );
				float2 uvY57_g215 = (temp_output_36_0_g215).zx;
				float2 uvZ58_g215 = (temp_output_36_0_g215).xy;
				float4 color20_g223 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float4 vertexToFrag216 = packedInput.ase_texcoord5;
				float4 break10_g216 = vertexToFrag216;
				float3 appendResult123_g215 = (float3((float)(int)_Tex1X , (float)(int)_Tex1Y , (float)(int)_Tex1Z));
				float3 weight1126_g215 = ( weight54_g215 * appendResult123_g215 );
				float3 temp_output_11_0_g217 = weight1126_g215;
				float3 break14_g217 = temp_output_11_0_g217;
				float4 appendResult23_g217 = (float4(temp_output_11_0_g217 , 0.0));
				float4 appendResult24_g217 = (float4(temp_output_11_0_g217 , 1.0));
				float4 break10_g218 = ( ( break14_g217.x + break14_g217.y + break14_g217.z ) > 0.0 ? appendResult23_g217 : appendResult24_g217 );
				float4 color20_g217 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float3 appendResult130_g215 = (float3((float)(int)_Tex2X , (float)(int)_Tex2Y , (float)(int)_Tex2Z));
				float3 weight2133_g215 = ( weight54_g215 * appendResult130_g215 );
				float3 temp_output_11_0_g219 = weight2133_g215;
				float3 break14_g219 = temp_output_11_0_g219;
				float4 appendResult23_g219 = (float4(temp_output_11_0_g219 , 0.0));
				float4 appendResult24_g219 = (float4(temp_output_11_0_g219 , 1.0));
				float4 break10_g220 = ( ( break14_g219.x + break14_g219.y + break14_g219.z ) > 0.0 ? appendResult23_g219 : appendResult24_g219 );
				float4 color20_g219 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float3 appendResult137_g215 = (float3((float)(int)_Tex3X , (float)(int)_Tex3Y , (float)(int)_Tex3Z));
				float3 weight3140_g215 = ( weight54_g215 * appendResult137_g215 );
				float3 temp_output_11_0_g221 = weight3140_g215;
				float3 break14_g221 = temp_output_11_0_g221;
				float4 appendResult23_g221 = (float4(temp_output_11_0_g221 , 0.0));
				float4 appendResult24_g221 = (float4(temp_output_11_0_g221 , 1.0));
				float4 break10_g222 = ( ( break14_g221.x + break14_g221.y + break14_g221.z ) > 0.0 ? appendResult23_g221 : appendResult24_g221 );
				float4 color20_g221 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float4 color182 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
				float4 vertexToFrag5_g83 = packedInput.ase_texcoord6;
				float4 temp_output_25_0_g83 = ( _IsMeshRenderMaterial * _Color * vertexToFrag5_g83 );
				float4 temp_output_175_0 = ( ( ( _UseTex0 + _UseTex1 + _UseTex2 + _UseTex3 ) > 0.0 ? ( ( ( ( (float)(int)_UseTex0 > 0.0 ? ( ( ( ( break14_g223.x > 0.0 ? tex2D( _MainTex, uvX56_g215 ) : float4( 0,0,0,0 ) ) * break10_g224.x ) + ( ( break14_g223.y > 0.0 ? tex2D( _MainTex, uvY57_g215 ) : float4( 0,0,0,0 ) ) * break10_g224.y ) + ( ( break14_g223.z > 0.0 ? tex2D( _MainTex, uvZ58_g215 ) : float4( 0,0,0,0 ) ) * break10_g224.z ) + ( color20_g223 * break10_g224.w ) ) / ( break10_g224.x + break10_g224.y + break10_g224.z + break10_g224.w ) ) : float4( 0,0,0,0 ) ) * break10_g216.x ) + ( ( (float)(int)_UseTex1 > 0.0 ? ( ( ( ( break14_g217.x > 0.0 ? tex2D( _Tex1, uvX56_g215 ) : float4( 0,0,0,0 ) ) * break10_g218.x ) + ( ( break14_g217.y > 0.0 ? tex2D( _Tex1, uvY57_g215 ) : float4( 0,0,0,0 ) ) * break10_g218.y ) + ( ( break14_g217.z > 0.0 ? tex2D( _Tex1, uvZ58_g215 ) : float4( 0,0,0,0 ) ) * break10_g218.z ) + ( color20_g217 * break10_g218.w ) ) / ( break10_g218.x + break10_g218.y + break10_g218.z + break10_g218.w ) ) : float4( 0,0,0,0 ) ) * break10_g216.y ) + ( ( (float)(int)_UseTex2 > 0.0 ? ( ( ( ( break14_g219.x > 0.0 ? tex2D( _Tex2, uvX56_g215 ) : float4( 0,0,0,0 ) ) * break10_g220.x ) + ( ( break14_g219.y > 0.0 ? tex2D( _Tex2, uvY57_g215 ) : float4( 0,0,0,0 ) ) * break10_g220.y ) + ( ( break14_g219.z > 0.0 ? tex2D( _Tex2, uvZ58_g215 ) : float4( 0,0,0,0 ) ) * break10_g220.z ) + ( color20_g219 * break10_g220.w ) ) / ( break10_g220.x + break10_g220.y + break10_g220.z + break10_g220.w ) ) : float4( 0,0,0,0 ) ) * break10_g216.z ) + ( ( (float)(int)_UseTex3 > 0.0 ? ( ( ( ( break14_g221.x > 0.0 ? tex2D( _Tex3, uvX56_g215 ) : float4( 0,0,0,0 ) ) * break10_g222.x ) + ( ( break14_g221.y > 0.0 ? tex2D( _Tex3, uvY57_g215 ) : float4( 0,0,0,0 ) ) * break10_g222.y ) + ( ( break14_g221.z > 0.0 ? tex2D( _Tex3, uvZ58_g215 ) : float4( 0,0,0,0 ) ) * break10_g222.z ) + ( color20_g221 * break10_g222.w ) ) / ( break10_g222.x + break10_g222.y + break10_g222.z + break10_g222.w ) ) : float4( 0,0,0,0 ) ) * break10_g216.w ) ) / ( break10_g216.x + break10_g216.y + break10_g216.z + break10_g216.w ) ) : color182 ) * temp_output_25_0_g83 );
				float localComputeOpaqueTransparency20_g228 = ( 0.0 );
				float3 vertexToFrag16_g83 = packedInput.ase_texcoord7.xyz;
				float4 unityObjectToClipPos17_g83 = TransformWorldToHClip(TransformObjectToWorld(vertexToFrag16_g83));
				float4 computeScreenPos18_g83 = ComputeScreenPos( unityObjectToClipPos17_g83 , _ProjectionParams.x );
				float2 ScreenPos20_g228 = (( ( computeScreenPos18_g83 / (computeScreenPos18_g83).w ) * _ScreenParams )).xy;
				float3 vertexToFrag27_g228 = packedInput.ase_texcoord8.xyz;
				float3 VertPos20_g228 = vertexToFrag27_g228;
				int VertexID4_g83 = packedInput.ase_texcoord4.w;
				float3 PositionLs4_g83 = float3( 0,0,0 );
				float3 NormalWs4_g83 = float3( 0,0,0 );
				float3 NormalLs4_g83 = float3( 0,0,0 );
				float4 Color4_g83 = float4( 0,0,0,0 );
				float4 EmissionHash4_g83 = float4( 0,0,0,0 );
				float Metallic4_g83 = 0.0;
				float Smoothness4_g83 = 0.0;
				float4 TextureWeight4_g83 = float4( 1,0,0,0 );
				float SdfValue4_g83 = 0.0;
				float3 Outward2dNormalLs4_g83 = float3( 0,0,0 );
				float3 Outward2dNormalWs4_g83 = float3( 0,0,0 );
				float3 localMudBunMeshPoint4_g83 = MudBunMeshPoint( VertexID4_g83 , PositionLs4_g83 , NormalWs4_g83 , NormalLs4_g83 , Color4_g83 , EmissionHash4_g83 , Metallic4_g83 , Smoothness4_g83 , TextureWeight4_g83 , SdfValue4_g83 , Outward2dNormalLs4_g83 , Outward2dNormalWs4_g83 );
				float Hash20_g228 = (EmissionHash4_g83).w;
				float AlphaIn20_g228 = (temp_output_25_0_g83).a;
				float AlphaOut20_g228 = 0;
				float AlphaThreshold20_g228 = 0;
				sampler2D DitherNoiseTexture20_g228 = _DitherTexture;
				int DitherNoiseTextureSize20_g228 = _DitherTextureSize;
				int UseRandomDither20_g228 = (int)_RandomDither;
				float AlphaCutoutThreshold20_g228 = _AlphaCutoutThreshold;
				float DitherBlend20_g228 = _Dithering;
				{
				float alpha = AlphaIn20_g228;
				computeOpaqueTransparency(ScreenPos20_g228, VertPos20_g228, Hash20_g228, DitherNoiseTexture20_g228, DitherNoiseTextureSize20_g228, UseRandomDither20_g228 > 0, AlphaCutoutThreshold20_g228, DitherBlend20_g228,  alpha, AlphaThreshold20_g228);
				AlphaOut20_g228 = alpha;
				}
				float temp_output_224_0 = ( (temp_output_175_0).w * AlphaOut20_g228 );
				
				float temp_output_221_25 = AlphaThreshold20_g228;
				
				surfaceDescription.Normal = float3( 0, 0, 1 );
				surfaceDescription.Smoothness = ( _Smoothness * vertexToFrag7_g83 );
				surfaceDescription.Alpha = temp_output_224_0;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = temp_output_221_25;
				#endif

				#ifdef _DEPTHOFFSET_ON
				surfaceDescription.DepthOffset = 0;
				#endif

				GetSurfaceAndBuiltinData( surfaceDescription, input, V, posInput, surfaceData, builtinData );

				float4 VPASSpositionCS = float4(packedInput.vpassInterpolators0.xy, 0.0, packedInput.vpassInterpolators0.z);
				float4 VPASSpreviousPositionCS = float4(packedInput.vpassInterpolators1.xy, 0.0, packedInput.vpassInterpolators1.z);

				#ifdef _DEPTHOFFSET_ON
				VPASSpositionCS.w += builtinData.depthOffset;
				VPASSpreviousPositionCS.w += builtinData.depthOffset;
				#endif

				float2 motionVector = CalculateMotionVector( VPASSpositionCS, VPASSpreviousPositionCS );
				EncodeMotionVector( motionVector * 0.5, outMotionVector );

				bool forceNoMotion = unity_MotionVectorsParams.y == 0.0;
				if( forceNoMotion )
					outMotionVector = float4( 2.0, 0.0, 0.0, 0.0 );

				#ifdef WRITE_NORMAL_BUFFER
				EncodeIntoNormalBuffer( ConvertSurfaceDataToNormalData( surfaceData ), posInput.positionSS, outNormalBuffer );

				#ifdef WRITE_MSAA_DEPTH
				depthColor = packedInput.vmeshPositionCS.z;
				#endif
				#elif defined(WRITE_MSAA_DEPTH)
				outNormalBuffer = float4( 0.0, 0.0, 0.0, 1.0 );
				depthColor = packedInput.vmeshPositionCS.z;
				#endif

				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				#endif
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "Forward"
			Tags { "LightMode"="Forward" }

			Blend [_SrcBlend] [_DstBlend], [_AlphaSrcBlend] [_AlphaDstBlend]
			Cull [_CullModeForward]
			ZTest [_ZTestDepthEqualForOpaque]
			ZWrite [_ZWrite]

			Stencil
			{
				Ref [_StencilRef]
				WriteMask [_StencilWriteMask]
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}


			ColorMask RGBA 1

			HLSLPROGRAM

			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define HAVE_MESH_MODIFICATION
			#define ASE_SRP_VERSION 70301


			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _DOUBLESIDED_ON
			#pragma shader_feature_local _ _BLENDMODE_ALPHA _BLENDMODE_ADD _BLENDMODE_PRE_MULTIPLY
			#pragma shader_feature_local _ENABLE_FOG_ON_TRANSPARENT
			#pragma shader_feature_local _ALPHATEST_ON

			#if !defined(DEBUG_DISPLAY) && defined(_ALPHATEST_ON)
			#define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
			#endif

			#define SHADERPASS SHADERPASS_FORWARD
			#pragma multi_compile _ DEBUG_DISPLAY
			#pragma multi_compile _ LIGHTMAP_ON
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ DYNAMICLIGHTMAP_ON
			#pragma multi_compile _ SHADOWS_SHADOWMASK
			#pragma multi_compile DECALS_OFF DECALS_3RT DECALS_4RT
			#pragma multi_compile USE_FPTL_LIGHTLIST USE_CLUSTERED_LIGHTLIST
			#pragma multi_compile SHADOW_LOW SHADOW_MEDIUM SHADOW_HIGH

			#pragma vertex Vert
			#pragma fragment Frag

			//#define UNITY_MATERIAL_LIT

			#if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
			#endif

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#ifdef DEBUG_DISPLAY
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
			#endif
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
			#define HAS_LIGHTLOOP
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoop.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define SHADER_GRAPH
			#pragma multi_compile _ MUDBUN_PROCEDURAL
			#include "Assets/MudBun/Shader/Render/ShaderCommon.cginc"
			#include "Assets/MudBun/Shader/Render/MeshCommon.cginc"


			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
				#define ASE_NEED_CULLFACE 1
			#endif

			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					float3 previousPositionOS : TEXCOORD4;
					#if defined (_ADD_PRECOMPUTED_VELOCITY)
						float3 precomputedVelocity : TEXCOORD5;
					#endif
				#endif
				uint ase_vertexID : SV_VertexID;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				float4 positionCS : SV_Position;
				float3 interp00 : TEXCOORD0;
				float3 interp01 : TEXCOORD1;
				float4 interp02 : TEXCOORD2;
				float4 interp03 : TEXCOORD3;
				float4 interp04 : TEXCOORD4;
				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					float3 vpassPositionCS : TEXCOORD5;
					float3 vpassPreviousPositionCS : TEXCOORD6;
				#endif
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_texcoord9 : TEXCOORD9;
				float4 ase_texcoord10 : TEXCOORD10;
				float4 ase_texcoord11 : TEXCOORD11;
				float4 ase_texcoord12 : TEXCOORD12;
				float4 ase_texcoord13 : TEXCOORD13;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			CBUFFER_START( UnityPerMaterial )
			float _UseTex0;
			float _RandomDither;
			int _DitherTextureSize;
			float _IsMeshRenderMaterial;
			float _Tex3Z;
			float _Tex3Y;
			float _Tex3X;
			float _Tex2Z;
			float _Tex2Y;
			float _AlphaCutoutThreshold;
			float _Tex2X;
			float _Tex1Y;
			float _Tex1X;
			float _MainTexZ;
			float _MainTexY;
			float _MainTexX;
			float _UseTex3;
			float _UseTex2;
			float _UseTex1;
			float _Tex1Z;
			float _Dithering;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
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
			sampler2D _Tex1;
			sampler2D _Tex2;
			sampler2D _Tex3;
			sampler2D _DitherTexture;


			float3 MudBunMeshPoint( int VertexID, out float3 PositionLs, out float3 NormalWs, out float3 NormalLs, out float4 Color, out float4 EmissionHash, out float Metallic, out float Smoothness, out float4 TextureWeight, out float SdfValue, out float3 Outward2dNormalLs, out float3 Outward2dNormalWs )
			{
				float4 positionWs;
				float2 metallicSmoothness;
				mudbun_mesh_vert(VertexID, positionWs, PositionLs, NormalWs, NormalLs, Color, EmissionHash, metallicSmoothness, TextureWeight, SdfValue, Outward2dNormalLs, Outward2dNormalWs);
				Metallic = metallicSmoothness.x;
				Smoothness = metallicSmoothness.y;
				return positionWs.xyz;
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout GlobalSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				// surface data
				surfaceData.baseColor =					surfaceDescription.Albedo;
				surfaceData.perceptualSmoothness =		surfaceDescription.Smoothness;
				surfaceData.ambientOcclusion =			surfaceDescription.Occlusion;
				surfaceData.metallic =					surfaceDescription.Metallic;
				surfaceData.coatMask =					surfaceDescription.CoatMask;

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceData.specularOcclusion =			surfaceDescription.SpecularOcclusion;
				#endif
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.subsurfaceMask =			surfaceDescription.SubsurfaceMask;
				#endif
				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceData.thickness =					surfaceDescription.Thickness;
				#endif
				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceData.diffusionProfileHash =		asuint(surfaceDescription.DiffusionProfile);
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.specularColor =				surfaceDescription.Specular;
				#endif
				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.anisotropy =				surfaceDescription.Anisotropy;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.iridescenceMask =			surfaceDescription.IridescenceMask;
				surfaceData.iridescenceThickness =		surfaceDescription.IridescenceThickness;
				#endif

				// refraction
				#ifdef _HAS_REFRACTION
				if( _EnableSSRefraction )
				{
					surfaceData.ior = surfaceDescription.RefractionIndex;
					surfaceData.transmittanceColor = surfaceDescription.RefractionColor;
					surfaceData.atDistance = surfaceDescription.RefractionDistance;

					surfaceData.transmittanceMask = ( 1.0 - surfaceDescription.Alpha );
					surfaceDescription.Alpha = 1.0;
				}
				else
				{
					surfaceData.ior = 1.0;
					surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
					surfaceData.atDistance = 1.0;
					surfaceData.transmittanceMask = 0.0;
					surfaceDescription.Alpha = 1.0;
				}
				#else
				surfaceData.ior = 1.0;
				surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
				surfaceData.atDistance = 1.0;
				surfaceData.transmittanceMask = 0.0;
				#endif


				// material features
				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif
				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif
				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
				#endif
				#ifdef ASE_LIT_CLEAR_COAT
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				// others
				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
				surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif
				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				// normals
				float3 normalTS = float3(0.0f, 0.0f, 1.0f);
				normalTS = surfaceDescription.Normal;
				GetNormalWS( fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants );

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];

				bentNormalWS = surfaceData.normalWS;
				#ifdef ASE_BENT_NORMAL
				GetNormalWS( fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants );
				#endif

				surfaceData.tangentWS = normalize( fragInputs.tangentToWorld[ 0 ].xyz );
				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.tangentWS = TransformTangentToWorld( surfaceDescription.Tangent, fragInputs.tangentToWorld );
				#endif
				surfaceData.tangentWS = Orthonormalize( surfaceData.tangentWS, surfaceData.normalWS );

				// decals
				#if HAVE_DECALS
				if( _EnableDecals )
				{
					DecalSurfaceData decalSurfaceData = GetDecalSurfaceData( posInput, surfaceDescription.Alpha );
					ApplyDecalToSurfaceData( decalSurfaceData, surfaceData );
				}
				#endif

				#if defined(_SPECULAR_OCCLUSION_CUSTOM)
				#elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO( V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness( surfaceData.perceptualSmoothness ) );
				#elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion( ClampNdotV( dot( surfaceData.normalWS, V ) ), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness( surfaceData.perceptualSmoothness ) );
				#endif

				#ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
				surfaceData.perceptualSmoothness = GeometricNormalFiltering( surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[ 2 ], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold );
				#endif

				// debug
				#if defined(DEBUG_DISPLAY)
				if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
				{
					surfaceData.metallic = 0;
				}
				ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
				#endif
			}

			void GetSurfaceAndBuiltinData(GlobalSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
				LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				ApplyDoubleSidedFlipOrMirror( fragInputs, doubleSidedConstants );

				#ifdef _ALPHATEST_ON
				DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
				builtinData.depthOffset = surfaceDescription.DepthOffset;
				ApplyDepthOffsetPositionInput( V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput );
				#endif

				float3 bentNormalWS;
				BuildSurfaceData( fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS );

				InitBuiltinData( posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[ 2 ], fragInputs.texCoord1, fragInputs.texCoord2, builtinData );

				#ifdef _ASE_BAKEDGI
				builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
				#endif
				#ifdef _ASE_BAKEDBACKGI
				builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
				#endif

				builtinData.emissiveColor = surfaceDescription.Emission;

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			AttributesMesh ApplyMeshModification(AttributesMesh inputMesh, float3 timeParameters, inout PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS )
			{
				_TimeParameters.xyz = timeParameters;
				int VertexID4_g83 = inputMesh.ase_vertexID;
				float3 PositionLs4_g83 = float3( 0,0,0 );
				float3 NormalWs4_g83 = float3( 0,0,0 );
				float3 NormalLs4_g83 = float3( 0,0,0 );
				float4 Color4_g83 = float4( 0,0,0,0 );
				float4 EmissionHash4_g83 = float4( 0,0,0,0 );
				float Metallic4_g83 = 0.0;
				float Smoothness4_g83 = 0.0;
				float4 TextureWeight4_g83 = float4( 1,0,0,0 );
				float SdfValue4_g83 = 0.0;
				float3 Outward2dNormalLs4_g83 = float3( 0,0,0 );
				float3 Outward2dNormalWs4_g83 = float3( 0,0,0 );
				float3 localMudBunMeshPoint4_g83 = MudBunMeshPoint( VertexID4_g83 , PositionLs4_g83 , NormalWs4_g83 , NormalLs4_g83 , Color4_g83 , EmissionHash4_g83 , Metallic4_g83 , Smoothness4_g83 , TextureWeight4_g83 , SdfValue4_g83 , Outward2dNormalLs4_g83 , Outward2dNormalWs4_g83 );
				float3 temp_output_198_0 = localMudBunMeshPoint4_g83;
				
				float3 vertexToFrag213 = NormalLs4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord7.xyz = vertexToFrag213;
				float3 vertexToFrag212 = PositionLs4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord8.xyz = vertexToFrag212;
				float4 vertexToFrag216 = TextureWeight4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord9 = vertexToFrag216;
				float4 vertexToFrag5_g83 = Color4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord10 = vertexToFrag5_g83;
				float3 vertexToFrag16_g83 = localMudBunMeshPoint4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord11.xyz = vertexToFrag16_g83;
				float3 vertexToFrag27_g228 = temp_output_198_0;
				outputPackedVaryingsMeshToPS.ase_texcoord12.xyz = vertexToFrag27_g228;
				
				float vertexToFrag8_g83 = Metallic4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord8.w = vertexToFrag8_g83;
				
				float3 vertexToFrag6_g83 = (EmissionHash4_g83).xyz;
				outputPackedVaryingsMeshToPS.ase_texcoord13.xyz = vertexToFrag6_g83;
				
				float vertexToFrag7_g83 = Smoothness4_g83;
				outputPackedVaryingsMeshToPS.ase_texcoord11.w = vertexToFrag7_g83;
				
				outputPackedVaryingsMeshToPS.ase_texcoord7.w = inputMesh.ase_vertexID;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord12.w = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord13.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = temp_output_198_0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif
				inputMesh.normalOS = NormalWs4_g83;
				inputMesh.tangentOS = inputMesh.tangentOS;
				return inputMesh;
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh)
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS = (PackedVaryingsMeshToPS)0;
				AttributesMesh defaultMesh = inputMesh;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				inputMesh = ApplyMeshModification( inputMesh, _TimeParameters.xyz, outputPackedVaryingsMeshToPS);

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);
				float4 tangentWS = float4(TransformObjectToWorldDir(inputMesh.tangentOS.xyz), inputMesh.tangentOS.w);

				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
				float4 VPASSpreviousPositionCS;
				float4 VPASSpositionCS = mul(UNITY_MATRIX_UNJITTERED_VP, float4(positionRWS, 1.0));

				bool forceNoMotion = unity_MotionVectorsParams.y == 0.0;
				if (forceNoMotion)
				{
					VPASSpreviousPositionCS = float4(0.0, 0.0, 0.0, 1.0);
				}
				else
				{
					bool hasDeformation = unity_MotionVectorsParams.x > 0.0;
					float3 effectivePositionOS = (hasDeformation ? inputMesh.previousPositionOS : defaultMesh.positionOS);
					#if defined(_ADD_PRECOMPUTED_VELOCITY)
					effectivePositionOS -= inputMesh.precomputedVelocity;
					#endif

					#if defined(HAVE_MESH_MODIFICATION)
						AttributesMesh previousMesh = defaultMesh;
						previousMesh.positionOS = effectivePositionOS ;
						PackedVaryingsMeshToPS test = (PackedVaryingsMeshToPS)0;
						float3 curTime = _TimeParameters.xyz;
						previousMesh = ApplyMeshModification(previousMesh, _LastTimeParameters.xyz, test);
						_TimeParameters.xyz = curTime;
						float3 previousPositionRWS = TransformPreviousObjectToWorld(previousMesh.positionOS);
					#else
						float3 previousPositionRWS = TransformPreviousObjectToWorld(effectivePositionOS);
					#endif

					#ifdef ATTRIBUTES_NEED_NORMAL
						float3 normalWS = TransformPreviousObjectToWorldNormal(defaultMesh.normalOS);
					#else
						float3 normalWS = float3(0.0, 0.0, 0.0);
					#endif

					#if defined(HAVE_VERTEX_MODIFICATION)
						//ApplyVertexModification(inputMesh, normalWS, previousPositionRWS, _LastTimeParameters.xyz);
					#endif

					VPASSpreviousPositionCS = mul(UNITY_MATRIX_PREV_VP, float4(previousPositionRWS, 1.0));
				}
				#endif

				outputPackedVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
				outputPackedVaryingsMeshToPS.interp00.xyz = positionRWS;
				outputPackedVaryingsMeshToPS.interp01.xyz = normalWS;
				outputPackedVaryingsMeshToPS.interp02.xyzw = tangentWS;
				outputPackedVaryingsMeshToPS.interp03.xyzw = inputMesh.uv1;
				outputPackedVaryingsMeshToPS.interp04.xyzw = inputMesh.uv2;

				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					outputPackedVaryingsMeshToPS.vpassPositionCS = float3(VPASSpositionCS.xyw);
					outputPackedVaryingsMeshToPS.vpassPreviousPositionCS = float3(VPASSpreviousPositionCS.xyw);
				#endif
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					float3 previousPositionOS : TEXCOORD4;
					#if defined (_ADD_PRECOMPUTED_VELOCITY)
						float3 precomputedVelocity : TEXCOORD5;
					#endif
				#endif
				uint ase_vertexID : SV_VertexID;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.uv1 = v.uv1;
				o.uv2 = v.uv2;
				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					o.previousPositionOS = v.previousPositionOS;
					#if defined (_ADD_PRECOMPUTED_VELOCITY)
						o.precomputedVelocity = v.precomputedVelocity;
					#endif
				#endif
				o.ase_vertexID = v.ase_vertexID;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
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
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.uv1 = patch[0].uv1 * bary.x + patch[1].uv1 * bary.y + patch[2].uv1 * bary.z;
				o.uv2 = patch[0].uv2 * bary.x + patch[1].uv2 * bary.y + patch[2].uv2 * bary.z;
				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					o.previousPositionOS = patch[0].previousPositionOS * bary.x + patch[1].previousPositionOS * bary.y + patch[2].previousPositionOS * bary.z;
					#if defined (_ADD_PRECOMPUTED_VELOCITY)
						o.precomputedVelocity = patch[0].precomputedVelocity * bary.x + patch[1].precomputedVelocity * bary.y + patch[2].precomputedVelocity * bary.z;
					#endif
				#endif
				o.ase_vertexID = patch[0].ase_vertexID * bary.x + patch[1].ase_vertexID * bary.y + patch[2].ase_vertexID * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			void Frag(PackedVaryingsMeshToPS packedInput,
					#ifdef OUTPUT_SPLIT_LIGHTING
						out float4 outColor : SV_Target0,
						out float4 outDiffuseLighting : SV_Target1,
						OUTPUT_SSSBUFFER(outSSSBuffer)
					#else
						out float4 outColor : SV_Target0
					#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
						, out float4 outMotionVec : SV_Target1
					#endif
					#endif
					#ifdef _DEPTHOFFSET_ON
						, out float outputDepth : SV_Depth
					#endif
					
						)
			{
				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					outMotionVec = float4(2.0, 0.0, 0.0, 0.0);
				#endif

				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				UNITY_SETUP_INSTANCE_ID( packedInput );
				float3 positionRWS = packedInput.interp00.xyz;
				float3 normalWS = packedInput.interp01.xyz;
				float4 tangentWS = packedInput.interp02.xyzw;

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;
				input.positionRWS = positionRWS;
				input.tangentToWorld = BuildTangentToWorld(tangentWS, normalWS);
				input.texCoord1 = packedInput.interp03.xyzw;
				input.texCoord2 = packedInput.interp04.xyzw;

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE(packedInput.cullFace, true, false);
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				input.positionSS.xy = _OffScreenRendering > 0 ? (input.positionSS.xy * _OffScreenDownsampleFactor) : input.positionSS.xy;
				uint2 tileIndex = uint2(input.positionSS.xy) / GetTileSize ();

				PositionInputs posInput = GetPositionInput( input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS.xyz, tileIndex );

				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);

				GlobalSurfaceDescription surfaceDescription = (GlobalSurfaceDescription)0;
				float3 vertexToFrag213 = packedInput.ase_texcoord7.xyz;
				float3 weight54_g215 = abs( vertexToFrag213 );
				float3 appendResult83_g215 = (float3((float)(int)_MainTexX , (float)(int)_MainTexY , (float)(int)_MainTexZ));
				float3 weight0119_g215 = ( weight54_g215 * appendResult83_g215 );
				float3 temp_output_11_0_g223 = weight0119_g215;
				float3 break14_g223 = temp_output_11_0_g223;
				float3 vertexToFrag212 = packedInput.ase_texcoord8.xyz;
				float3 temp_output_36_0_g215 = vertexToFrag212;
				float2 uvX56_g215 = (temp_output_36_0_g215).yz;
				float4 appendResult23_g223 = (float4(temp_output_11_0_g223 , 0.0));
				float4 appendResult24_g223 = (float4(temp_output_11_0_g223 , 1.0));
				float4 break10_g224 = ( ( break14_g223.x + break14_g223.y + break14_g223.z ) > 0.0 ? appendResult23_g223 : appendResult24_g223 );
				float2 uvY57_g215 = (temp_output_36_0_g215).zx;
				float2 uvZ58_g215 = (temp_output_36_0_g215).xy;
				float4 color20_g223 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float4 vertexToFrag216 = packedInput.ase_texcoord9;
				float4 break10_g216 = vertexToFrag216;
				float3 appendResult123_g215 = (float3((float)(int)_Tex1X , (float)(int)_Tex1Y , (float)(int)_Tex1Z));
				float3 weight1126_g215 = ( weight54_g215 * appendResult123_g215 );
				float3 temp_output_11_0_g217 = weight1126_g215;
				float3 break14_g217 = temp_output_11_0_g217;
				float4 appendResult23_g217 = (float4(temp_output_11_0_g217 , 0.0));
				float4 appendResult24_g217 = (float4(temp_output_11_0_g217 , 1.0));
				float4 break10_g218 = ( ( break14_g217.x + break14_g217.y + break14_g217.z ) > 0.0 ? appendResult23_g217 : appendResult24_g217 );
				float4 color20_g217 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float3 appendResult130_g215 = (float3((float)(int)_Tex2X , (float)(int)_Tex2Y , (float)(int)_Tex2Z));
				float3 weight2133_g215 = ( weight54_g215 * appendResult130_g215 );
				float3 temp_output_11_0_g219 = weight2133_g215;
				float3 break14_g219 = temp_output_11_0_g219;
				float4 appendResult23_g219 = (float4(temp_output_11_0_g219 , 0.0));
				float4 appendResult24_g219 = (float4(temp_output_11_0_g219 , 1.0));
				float4 break10_g220 = ( ( break14_g219.x + break14_g219.y + break14_g219.z ) > 0.0 ? appendResult23_g219 : appendResult24_g219 );
				float4 color20_g219 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float3 appendResult137_g215 = (float3((float)(int)_Tex3X , (float)(int)_Tex3Y , (float)(int)_Tex3Z));
				float3 weight3140_g215 = ( weight54_g215 * appendResult137_g215 );
				float3 temp_output_11_0_g221 = weight3140_g215;
				float3 break14_g221 = temp_output_11_0_g221;
				float4 appendResult23_g221 = (float4(temp_output_11_0_g221 , 0.0));
				float4 appendResult24_g221 = (float4(temp_output_11_0_g221 , 1.0));
				float4 break10_g222 = ( ( break14_g221.x + break14_g221.y + break14_g221.z ) > 0.0 ? appendResult23_g221 : appendResult24_g221 );
				float4 color20_g221 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float4 color182 = IsGammaSpace() ? float4(1,1,1,1) : float4(1,1,1,1);
				float4 vertexToFrag5_g83 = packedInput.ase_texcoord10;
				float4 temp_output_25_0_g83 = ( _IsMeshRenderMaterial * _Color * vertexToFrag5_g83 );
				float4 temp_output_175_0 = ( ( ( _UseTex0 + _UseTex1 + _UseTex2 + _UseTex3 ) > 0.0 ? ( ( ( ( (float)(int)_UseTex0 > 0.0 ? ( ( ( ( break14_g223.x > 0.0 ? tex2D( _MainTex, uvX56_g215 ) : float4( 0,0,0,0 ) ) * break10_g224.x ) + ( ( break14_g223.y > 0.0 ? tex2D( _MainTex, uvY57_g215 ) : float4( 0,0,0,0 ) ) * break10_g224.y ) + ( ( break14_g223.z > 0.0 ? tex2D( _MainTex, uvZ58_g215 ) : float4( 0,0,0,0 ) ) * break10_g224.z ) + ( color20_g223 * break10_g224.w ) ) / ( break10_g224.x + break10_g224.y + break10_g224.z + break10_g224.w ) ) : float4( 0,0,0,0 ) ) * break10_g216.x ) + ( ( (float)(int)_UseTex1 > 0.0 ? ( ( ( ( break14_g217.x > 0.0 ? tex2D( _Tex1, uvX56_g215 ) : float4( 0,0,0,0 ) ) * break10_g218.x ) + ( ( break14_g217.y > 0.0 ? tex2D( _Tex1, uvY57_g215 ) : float4( 0,0,0,0 ) ) * break10_g218.y ) + ( ( break14_g217.z > 0.0 ? tex2D( _Tex1, uvZ58_g215 ) : float4( 0,0,0,0 ) ) * break10_g218.z ) + ( color20_g217 * break10_g218.w ) ) / ( break10_g218.x + break10_g218.y + break10_g218.z + break10_g218.w ) ) : float4( 0,0,0,0 ) ) * break10_g216.y ) + ( ( (float)(int)_UseTex2 > 0.0 ? ( ( ( ( break14_g219.x > 0.0 ? tex2D( _Tex2, uvX56_g215 ) : float4( 0,0,0,0 ) ) * break10_g220.x ) + ( ( break14_g219.y > 0.0 ? tex2D( _Tex2, uvY57_g215 ) : float4( 0,0,0,0 ) ) * break10_g220.y ) + ( ( break14_g219.z > 0.0 ? tex2D( _Tex2, uvZ58_g215 ) : float4( 0,0,0,0 ) ) * break10_g220.z ) + ( color20_g219 * break10_g220.w ) ) / ( break10_g220.x + break10_g220.y + break10_g220.z + break10_g220.w ) ) : float4( 0,0,0,0 ) ) * break10_g216.z ) + ( ( (float)(int)_UseTex3 > 0.0 ? ( ( ( ( break14_g221.x > 0.0 ? tex2D( _Tex3, uvX56_g215 ) : float4( 0,0,0,0 ) ) * break10_g222.x ) + ( ( break14_g221.y > 0.0 ? tex2D( _Tex3, uvY57_g215 ) : float4( 0,0,0,0 ) ) * break10_g222.y ) + ( ( break14_g221.z > 0.0 ? tex2D( _Tex3, uvZ58_g215 ) : float4( 0,0,0,0 ) ) * break10_g222.z ) + ( color20_g221 * break10_g222.w ) ) / ( break10_g222.x + break10_g222.y + break10_g222.z + break10_g222.w ) ) : float4( 0,0,0,0 ) ) * break10_g216.w ) ) / ( break10_g216.x + break10_g216.y + break10_g216.z + break10_g216.w ) ) : color182 ) * temp_output_25_0_g83 );
				float localComputeOpaqueTransparency20_g228 = ( 0.0 );
				float3 vertexToFrag16_g83 = packedInput.ase_texcoord11.xyz;
				float4 unityObjectToClipPos17_g83 = TransformWorldToHClip(TransformObjectToWorld(vertexToFrag16_g83));
				float4 computeScreenPos18_g83 = ComputeScreenPos( unityObjectToClipPos17_g83 , _ProjectionParams.x );
				float2 ScreenPos20_g228 = (( ( computeScreenPos18_g83 / (computeScreenPos18_g83).w ) * _ScreenParams )).xy;
				float3 vertexToFrag27_g228 = packedInput.ase_texcoord12.xyz;
				float3 VertPos20_g228 = vertexToFrag27_g228;
				int VertexID4_g83 = packedInput.ase_texcoord7.w;
				float3 PositionLs4_g83 = float3( 0,0,0 );
				float3 NormalWs4_g83 = float3( 0,0,0 );
				float3 NormalLs4_g83 = float3( 0,0,0 );
				float4 Color4_g83 = float4( 0,0,0,0 );
				float4 EmissionHash4_g83 = float4( 0,0,0,0 );
				float Metallic4_g83 = 0.0;
				float Smoothness4_g83 = 0.0;
				float4 TextureWeight4_g83 = float4( 1,0,0,0 );
				float SdfValue4_g83 = 0.0;
				float3 Outward2dNormalLs4_g83 = float3( 0,0,0 );
				float3 Outward2dNormalWs4_g83 = float3( 0,0,0 );
				float3 localMudBunMeshPoint4_g83 = MudBunMeshPoint( VertexID4_g83 , PositionLs4_g83 , NormalWs4_g83 , NormalLs4_g83 , Color4_g83 , EmissionHash4_g83 , Metallic4_g83 , Smoothness4_g83 , TextureWeight4_g83 , SdfValue4_g83 , Outward2dNormalLs4_g83 , Outward2dNormalWs4_g83 );
				float Hash20_g228 = (EmissionHash4_g83).w;
				float AlphaIn20_g228 = (temp_output_25_0_g83).a;
				float AlphaOut20_g228 = 0;
				float AlphaThreshold20_g228 = 0;
				sampler2D DitherNoiseTexture20_g228 = _DitherTexture;
				int DitherNoiseTextureSize20_g228 = _DitherTextureSize;
				int UseRandomDither20_g228 = (int)_RandomDither;
				float AlphaCutoutThreshold20_g228 = _AlphaCutoutThreshold;
				float DitherBlend20_g228 = _Dithering;
				{
				float alpha = AlphaIn20_g228;
				computeOpaqueTransparency(ScreenPos20_g228, VertPos20_g228, Hash20_g228, DitherNoiseTexture20_g228, DitherNoiseTextureSize20_g228, UseRandomDither20_g228 > 0, AlphaCutoutThreshold20_g228, DitherBlend20_g228,  alpha, AlphaThreshold20_g228);
				AlphaOut20_g228 = alpha;
				}
				float temp_output_224_0 = ( (temp_output_175_0).w * AlphaOut20_g228 );
				float temp_output_221_25 = AlphaThreshold20_g228;
				clip( temp_output_224_0 - temp_output_221_25);
				
				float vertexToFrag8_g83 = packedInput.ase_texcoord8.w;
				
				float3 vertexToFrag6_g83 = packedInput.ase_texcoord13.xyz;
				
				float vertexToFrag7_g83 = packedInput.ase_texcoord11.w;
				
				surfaceDescription.Albedo = temp_output_175_0.xyz;
				surfaceDescription.Normal = float3( 0, 0, 1 );
				surfaceDescription.BentNormal = float3( 0, 0, 1 );
				surfaceDescription.CoatMask = 0;
				surfaceDescription.Metallic = ( _Metallic * vertexToFrag8_g83 );

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceDescription.Specular = 0;
				#endif

				surfaceDescription.Emission = ( vertexToFrag6_g83 * (_Emission).rgb );
				surfaceDescription.Smoothness = ( _Smoothness * vertexToFrag7_g83 );
				surfaceDescription.Occlusion = 1;
				surfaceDescription.Alpha = temp_output_224_0;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = temp_output_221_25;
				#endif

				#ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
				surfaceDescription.SpecularAAScreenSpaceVariance = 0;
				surfaceDescription.SpecularAAThreshold = 0;
				#endif

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceDescription.SpecularOcclusion = 0;
				#endif

				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceDescription.Thickness = 1;
				#endif

				#ifdef _HAS_REFRACTION
				surfaceDescription.RefractionIndex = 1;
				surfaceDescription.RefractionColor = float3( 1, 1, 1 );
				surfaceDescription.RefractionDistance = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceDescription.SubsurfaceMask = 1;
				#endif

				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceDescription.DiffusionProfile = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceDescription.Anisotropy = 1;
				surfaceDescription.Tangent = float3( 1, 0, 0 );
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceDescription.IridescenceMask = 0;
				surfaceDescription.IridescenceThickness = 0;
				#endif

				#ifdef _ASE_BAKEDGI
				surfaceDescription.BakedGI = 0;
				#endif
				#ifdef _ASE_BAKEDBACKGI
				surfaceDescription.BakedBackGI = 0;
				#endif

				#ifdef _DEPTHOFFSET_ON
				surfaceDescription.DepthOffset = 0;
				#endif

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription,input, V, posInput, surfaceData, builtinData);

				BSDFData bsdfData = ConvertSurfaceDataToBSDFData(input.positionSS.xy, surfaceData);

				PreLightData preLightData = GetPreLightData(V, posInput, bsdfData);

				outColor = float4(0.0, 0.0, 0.0, 0.0);
				#ifdef DEBUG_DISPLAY
				#ifdef OUTPUT_SPLIT_LIGHTING
					outDiffuseLighting = 0;
					ENCODE_INTO_SSSBUFFER(surfaceData, posInput.positionSS, outSSSBuffer);
				#endif

				bool viewMaterial = false;
				int bufferSize = int(_DebugViewMaterialArray[0]);
				if (bufferSize != 0)
				{
					bool needLinearToSRGB = false;
					float3 result = float3(1.0, 0.0, 1.0);

					for (int index = 1; index <= bufferSize; index++)
					{
						int indexMaterialProperty = int(_DebugViewMaterialArray[index]);

						if (indexMaterialProperty != 0)
						{
							viewMaterial = true;

							GetPropertiesDataDebug(indexMaterialProperty, result, needLinearToSRGB);
							GetVaryingsDataDebug(indexMaterialProperty, input, result, needLinearToSRGB);
							GetBuiltinDataDebug(indexMaterialProperty, builtinData, result, needLinearToSRGB);
							GetSurfaceDataDebug(indexMaterialProperty, surfaceData, result, needLinearToSRGB);
							GetBSDFDataDebug(indexMaterialProperty, bsdfData, result, needLinearToSRGB);
						}
					}

					if (!needLinearToSRGB)
						result = SRGBToLinear(max(0, result));

					outColor = float4(result, 1.0);
				}

				if (!viewMaterial)
				{
					if (_DebugFullScreenMode == FULLSCREENDEBUGMODE_VALIDATE_DIFFUSE_COLOR || _DebugFullScreenMode == FULLSCREENDEBUGMODE_VALIDATE_SPECULAR_COLOR)
					{
						float3 result = float3(0.0, 0.0, 0.0);

						GetPBRValidatorDebug(surfaceData, result);

						outColor = float4(result, 1.0f);
					}
					else if (_DebugFullScreenMode == FULLSCREENDEBUGMODE_TRANSPARENCY_OVERDRAW)
					{
						float4 result = _DebugTransparencyOverdrawWeight * float4(TRANSPARENCY_OVERDRAW_COST, TRANSPARENCY_OVERDRAW_COST, TRANSPARENCY_OVERDRAW_COST, TRANSPARENCY_OVERDRAW_A);
						outColor = result;
					}
					else
				#endif
					{
				#ifdef _SURFACE_TYPE_TRANSPARENT
						uint featureFlags = LIGHT_FEATURE_MASK_FLAGS_TRANSPARENT;
				#else
						uint featureFlags = LIGHT_FEATURE_MASK_FLAGS_OPAQUE;
				#endif
						float3 diffuseLighting;
						float3 specularLighting;

						LightLoop(V, posInput, preLightData, bsdfData, builtinData, featureFlags, diffuseLighting, specularLighting);

						diffuseLighting *= GetCurrentExposureMultiplier();
						specularLighting *= GetCurrentExposureMultiplier();

				#ifdef OUTPUT_SPLIT_LIGHTING
						if (_EnableSubsurfaceScattering != 0 && ShouldOutputSplitLighting(bsdfData))
						{
							outColor = float4(specularLighting, 1.0);
							outDiffuseLighting = float4(TagLightingForSSS(diffuseLighting), 1.0);
						}
						else
						{
							outColor = float4(diffuseLighting + specularLighting, 1.0);
							outDiffuseLighting = 0;
						}
						ENCODE_INTO_SSSBUFFER(surfaceData, posInput.positionSS, outSSSBuffer);
				#else
						outColor = ApplyBlendMode(diffuseLighting, specularLighting, builtinData.opacity);
						outColor = EvaluateAtmosphericScattering(posInput, V, outColor);
				#endif

				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
						float4 VPASSpositionCS = float4(packedInput.vpassPositionCS.xy, 0.0, packedInput.vpassPositionCS.z);
						float4 VPASSpreviousPositionCS = float4(packedInput.vpassPreviousPositionCS.xy, 0.0, packedInput.vpassPreviousPositionCS.z);

						bool forceNoMotion = any(unity_MotionVectorsParams.yw == 0.0);
						if (!forceNoMotion)
						{
							float2 motionVec = CalculateMotionVector(VPASSpositionCS, VPASSpreviousPositionCS);
							EncodeMotionVector(motionVec * 0.5, outMotionVec);
							outMotionVec.zw = 1.0;
						}
				#endif
					}

				#ifdef DEBUG_DISPLAY
				}
				#endif

				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				#endif
			}
			ENDHLSL
		}
		
	}
	CustomEditor "MudBun.MudMeshMultiTexturedMaterialEditor"
	
	
}
/*ASEBEGIN
Version=18800
-1569;255;1302;771;737.9912;1173.892;2.580883;True;False
Node;AmplifyShaderEditor.FunctionNode;198;-128,-192;Inherit;False;Mud Mesh;0;;83;4f444db5091a94140ab2b15b933d37b6;0;0;15;COLOR;9;FLOAT;13;FLOAT3;10;FLOAT;11;FLOAT;12;FLOAT4;33;FLOAT3;0;FLOAT3;32;FLOAT3;2;FLOAT3;31;FLOAT3;48;FLOAT3;46;FLOAT;45;FLOAT2;15;FLOAT;41
Node;AmplifyShaderEditor.VertexToFragmentNode;216;384,-352;Inherit;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;186;128,-1616;Inherit;False;Property;_Tex1X;Project Texture 1 X;18;1;[Toggle];Create;False;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;192;128,-368;Inherit;False;Property;_Tex3Z;Project Texture 3 Z;30;1;[Toggle];Create;False;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;158;128,-1808;Inherit;True;Property;_Tex1;Texture 1;17;0;Create;False;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RangedFloatNode;187;128,-1536;Inherit;False;Property;_Tex1Y;Project Texture 1 Y;19;1;[Toggle];Create;False;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;180;128,-1344;Inherit;False;Property;_UseTex2;Use Texture 2;21;1;[Toggle];Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;188;128,-1456;Inherit;False;Property;_Tex1Z;Project Texture 1 Z;20;1;[Toggle];Create;False;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexToFragmentNode;213;384,-176;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.VertexToFragmentNode;212;384,-256;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TexturePropertyNode;146;128,-2352;Inherit;True;Property;_MainTex;Texture 0;10;0;Create;False;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RangedFloatNode;194;128,-528;Inherit;False;Property;_Tex3X;Project Texture 3 X;28;1;[Toggle];Create;False;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;190;128,-992;Inherit;False;Property;_Tex2Y;Project Texture 2 Y;24;1;[Toggle];Create;False;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;189;128,-912;Inherit;False;Property;_Tex2Z;Project Texture 2 Z;25;1;[Toggle];Create;False;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;178;128,-2432;Inherit;False;Property;_UseTex0;Use Texture 0;9;1;[Toggle];Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;166;128,-720;Inherit;True;Property;_Tex3;Texture 3;27;0;Create;False;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RangedFloatNode;181;128,-800;Inherit;False;Property;_UseTex3;Use Texture 3;26;1;[Toggle];Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;183;128,-2160;Inherit;False;Property;_MainTexX;Project Texture 0 X;11;1;[Toggle];Create;False;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;193;128,-448;Inherit;False;Property;_Tex3Y;Project Texture 3 Y;29;1;[Toggle];Create;False;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;191;128,-1072;Inherit;False;Property;_Tex2X;Project Texture 2 X;23;1;[Toggle];Create;False;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;184;128,-2080;Inherit;False;Property;_MainTexY;Project Texture 0 Y;13;1;[Toggle];Create;False;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;185;128,-2000;Inherit;False;Property;_MainTexZ;Project Texture 0 Z;15;1;[Toggle];Create;False;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;179;128,-1888;Inherit;False;Property;_UseTex1;Use Texture 1;16;1;[Toggle];Create;False;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;161;128,-1264;Inherit;True;Property;_Tex2;Texture 2;22;0;Create;False;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.FunctionNode;215;1152,-1616;Inherit;False;Mud Spherical Triplanar Texture Blend;-1;;215;d6579a9932e90eb4c8c7f58f55cbd31b;0;23;36;FLOAT3;0,0,0;False;49;FLOAT3;0,0,0;False;9;FLOAT4;1,0,0,0;False;4;INT;0;False;18;SAMPLER2D;0,0,0,0;False;33;INT;1;False;34;INT;1;False;35;INT;1;False;97;INT;0;False;96;SAMPLER2D;0,0,0,0;False;121;INT;1;False;122;INT;1;False;120;INT;1;False;105;INT;0;False;104;SAMPLER2D;0,0,0,0;False;128;INT;1;False;129;INT;1;False;127;INT;1;False;114;INT;0;False;115;SAMPLER2D;0,0,0,0;False;135;INT;1;False;136;INT;1;False;134;INT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;173;1152,-1824;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;182;1488,-1408;Inherit;False;Constant;_White;White;26;0;Create;True;0;0;0;False;0;False;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Compare;171;1792,-1536;Inherit;False;2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT4;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.IntNode;223;-128,480;Inherit;False;Property;_DitherTextureSize;Dither Texture Size;14;0;Create;True;0;0;0;False;0;False;256;256;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;65;-128,768;Inherit;False;Property;_Dithering;Dithering;7;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;218;-128,576;Inherit;False;Property;_RandomDither;Random Dither;8;1;[Toggle];Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;64;-128,672;Inherit;False;Property;_AlphaCutoutThreshold;Alpha Cutout Threshold;6;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;222;-128,256;Inherit;True;Property;_DitherTexture;Dither Texture;12;0;Create;True;0;0;0;False;0;False;f240bbb7854046345b218811e5681a54;f240bbb7854046345b218811e5681a54;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;175;2080,-384;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ComponentMaskNode;176;2336,-288;Inherit;False;False;False;False;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;221;1664,128;Inherit;False;Mud Alpha Threshold;-1;;228;926535703f4c32948ac1f55275a22bf0;0;9;8;FLOAT2;0,0;False;15;FLOAT3;0,0,0;False;18;FLOAT;0;False;22;FLOAT;0;False;19;SAMPLER2D;0;False;26;INT;256;False;9;INT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;2;FLOAT;24;FLOAT;25
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;224;2576,-288;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClipNode;217;2832,-368;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;93;1008,-416;Float;False;False;-1;2;UnityEditor.Rendering.HighDefinition.HDLitGUI;0;2;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;TransparentBackface;0;7;TransparentBackface;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;True;1;0;True;-19;0;True;-20;1;0;True;-21;0;True;-22;False;False;False;False;False;False;False;False;True;1;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;True;0;True;-23;True;0;True;-31;False;True;1;LightMode=TransparentBackface;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;88;1008,-416;Float;False;False;-1;2;UnityEditor.Rendering.HighDefinition.HDLitGUI;0;2;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;False;False;False;False;False;False;False;False;False;True;0;True;-25;True;False;False;False;False;0;False;-1;False;False;False;False;True;1;False;-1;True;3;False;-1;False;True;1;LightMode=ShadowCaster;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;95;1008,-416;Float;False;False;-1;2;UnityEditor.Rendering.HighDefinition.HDLitGUI;0;2;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;TransparentDepthPostpass;0;9;TransparentDepthPostpass;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;True;0;True;-25;True;False;False;False;False;0;False;-1;False;False;False;False;True;1;False;-1;False;False;True;1;LightMode=TransparentDepthPostpass;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;92;1008,-416;Float;False;False;-1;2;UnityEditor.Rendering.HighDefinition.HDLitGUI;0;2;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;Distortion;0;6;Distortion;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;True;4;1;False;-1;1;False;-1;4;1;False;-1;1;False;-1;True;1;False;-1;1;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;True;True;0;True;-10;255;False;-1;255;True;-11;7;False;-1;3;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;2;False;-1;True;3;False;-1;False;True;1;LightMode=DistortionVectors;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;90;1008,-416;Float;False;False;-1;2;UnityEditor.Rendering.HighDefinition.HDLitGUI;0;2;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;DepthOnly;0;4;DepthOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;False;False;False;False;False;False;False;False;False;True;0;True;-25;False;False;False;False;True;True;0;True;-6;255;False;-1;255;True;-7;7;False;-1;3;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;False;False;True;1;LightMode=DepthOnly;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;86;3200,-320;Float;False;True;-1;2;MudBun.MudMeshMultiTexturedMaterialEditor;0;2;MudBun/Mud Mesh Multi-Textured (HDRP);53b46d85872c5b24c8f4f0a1c3fe4c87;True;GBuffer;0;0;GBuffer;35;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;False;False;False;False;False;False;False;False;False;True;0;True;-25;False;False;False;False;True;True;0;True;-13;255;False;-1;255;True;-12;7;False;-1;3;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;0;True;-14;False;True;1;LightMode=GBuffer;False;0;;0;0;Standard;41;Surface Type;0;  Rendering Pass;1;  Refraction Model;0;    Blending Mode;0;    Blend Preserves Specular;1;  Receive Fog;1;  Back Then Front Rendering;0;  Transparent Depth Prepass;0;  Transparent Depth Postpass;0;  Transparent Writes Motion Vector;0;  Distortion;0;    Distortion Mode;0;    Distortion Depth Test;1;  ZWrite;0;  Z Test;4;Double-Sided;0;Alpha Clipping;1;  Use Shadow Threshold;0;Material Type,InvertActionOnDeselection;0;  Energy Conserving Specular;1;  Transmission;1;Receive Decals;1;Receives SSR;1;Motion Vectors;1;  Add Precomputed Velocity;0;Specular AA;0;Specular Occlusion Mode;1;Override Baked GI;0;Depth Offset;0;DOTS Instancing;0;LOD CrossFade;0;Tessellation;0;  Phong;0;  Strength;0.5,False,-1;  Type;0;  Tess;16,False,-1;  Min;10,False,-1;  Max;25,False,-1;  Edge Length;16,False,-1;  Max Displacement;25,False,-1;Vertex Position;0;0;11;True;True;True;True;True;True;False;False;False;False;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;89;1008,-416;Float;False;False;-1;2;UnityEditor.Rendering.HighDefinition.HDLitGUI;0;2;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;SceneSelectionPass;0;3;SceneSelectionPass;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;0;False;-1;False;False;False;False;False;False;False;True;1;LightMode=SceneSelectionPass;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;87;1008,-416;Float;False;False;-1;2;UnityEditor.Rendering.HighDefinition.HDLitGUI;0;2;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;META;0;1;META;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;96;1008,-416;Float;False;False;-1;2;UnityEditor.Rendering.HighDefinition.HDLitGUI;0;2;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;Forward;0;10;Forward;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;True;1;0;True;-19;0;True;-20;1;0;True;-21;0;True;-22;False;False;False;False;False;False;False;False;True;0;True;-28;False;True;True;True;True;True;0;False;-1;False;False;True;True;0;True;-4;255;False;-1;255;True;-5;7;False;-1;3;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;0;True;-23;True;0;True;-30;False;True;1;LightMode=Forward;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;94;1008,-416;Float;False;False;-1;2;UnityEditor.Rendering.HighDefinition.HDLitGUI;0;2;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;TransparentDepthPrepass;0;8;TransparentDepthPrepass;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;True;0;True;-25;True;False;False;False;False;0;False;-1;False;False;False;False;True;1;False;-1;False;False;True;1;LightMode=TransparentDepthPrepass;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;91;1008,-416;Float;False;False;-1;2;UnityEditor.Rendering.HighDefinition.HDLitGUI;0;2;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;Motion Vectors;0;5;Motion Vectors;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;False;False;False;False;False;False;False;False;False;True;0;True;-25;False;False;False;False;True;True;0;True;-8;255;False;-1;255;True;-9;7;False;-1;3;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;False;False;True;1;LightMode=MotionVectors;False;0;;0;0;Standard;0;False;0
WireConnection;216;0;198;33
WireConnection;213;0;198;31
WireConnection;212;0;198;32
WireConnection;215;36;212;0
WireConnection;215;49;213;0
WireConnection;215;9;216;0
WireConnection;215;4;178;0
WireConnection;215;18;146;0
WireConnection;215;33;183;0
WireConnection;215;34;184;0
WireConnection;215;35;185;0
WireConnection;215;97;179;0
WireConnection;215;96;158;0
WireConnection;215;121;186;0
WireConnection;215;122;187;0
WireConnection;215;120;188;0
WireConnection;215;105;180;0
WireConnection;215;104;161;0
WireConnection;215;128;191;0
WireConnection;215;129;190;0
WireConnection;215;127;189;0
WireConnection;215;114;181;0
WireConnection;215;115;166;0
WireConnection;215;135;194;0
WireConnection;215;136;193;0
WireConnection;215;134;192;0
WireConnection;173;0;178;0
WireConnection;173;1;179;0
WireConnection;173;2;180;0
WireConnection;173;3;181;0
WireConnection;171;0;173;0
WireConnection;171;2;215;0
WireConnection;171;3;182;0
WireConnection;175;0;171;0
WireConnection;175;1;198;9
WireConnection;176;0;175;0
WireConnection;221;8;198;15
WireConnection;221;15;198;0
WireConnection;221;18;198;41
WireConnection;221;22;198;13
WireConnection;221;19;222;0
WireConnection;221;26;223;0
WireConnection;221;9;218;0
WireConnection;221;6;64;0
WireConnection;221;7;65;0
WireConnection;224;0;176;0
WireConnection;224;1;221;24
WireConnection;217;0;175;0
WireConnection;217;1;224;0
WireConnection;217;2;221;25
WireConnection;86;0;217;0
WireConnection;86;4;198;11
WireConnection;86;6;198;10
WireConnection;86;7;198;12
WireConnection;86;9;224;0
WireConnection;86;10;221;25
WireConnection;86;11;198;0
WireConnection;86;12;198;2
ASEEND*/
//CHKSM=2764452A9148490722B465F4C70E12B2D73114F9