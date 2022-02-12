///
/// Origin: http://www.shaderslab.com/demo-94---wireframe-without-diagonal.html
///
Shader "Custom/Geometry/Wireframe"
{
	Properties
	{
		[PowerSlider(3.0)] _WireframeVal ("Wireframe width", Range(0., 0.5)) = 0.05
	}
	SubShader
	{
		Tags { "Queue"="Geometry" "RenderType"="Opaque" }

		Pass
		{
			Cull Back
			Blend One OneMinusSrcAlpha

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma geometry geom

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				fixed4 color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct v2g
			{
				float4 color : COLOR;
				float4 worldPos : SV_POSITION;
			};

			struct g2f
			{
				float3 bary : TEXCOORD0;
				float4 color : TEXCOORD1;

				float4 pos : SV_POSITION;
			};

			v2g vert(appdata v)
			{
				v2g o;
				o.worldPos = mul(unity_ObjectToWorld, v.vertex);
				o.color = v.color;
				return o;
			}

			[maxvertexcount(3)]
			void geom(triangle v2g IN[3], inout TriangleStream<g2f> triStream)
			{
				float3 param = float3(0., 0., 0.);

				g2f o;
				o.pos = mul(UNITY_MATRIX_VP, IN[0].worldPos);
				o.bary = float3(1., 0., 0.) + param;
				o.color = IN[0].color;
				triStream.Append(o);
				o.pos = mul(UNITY_MATRIX_VP, IN[1].worldPos);
				o.bary = float3(0., 0., 1.) + param;
				o.color = IN[1].color;
				triStream.Append(o);
				o.pos = mul(UNITY_MATRIX_VP, IN[2].worldPos);
				o.bary = float3(0., 1., 0.) + param;
				o.color = IN[2].color;
				triStream.Append(o);
			}

			float _WireframeVal;

			fixed4 frag(g2f i) : SV_Target {
			if(!any(bool3(i.bary.x <= _WireframeVal, i.bary.y <= _WireframeVal, i.bary.z <= _WireframeVal)))
				 discard;

				return i.color;
			}

			ENDCG
		}
	}
}
