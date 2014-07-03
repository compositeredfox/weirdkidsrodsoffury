Shader "Custom/Rod Shader" {
	Properties {
	_MainColor ("Main Color", Color) = (1, 1, 1, 1)
	_MainTex ("", 2D) = "white" {}
    }
    
    SubShader {
      Tags {"Queue"="Geometry" "IgnoreProjector"="True" "RenderType"="Opaque"}
      Cull Off
      CGPROGRAM
      #pragma surface surf Simple vertex:vert
      #pragma target 3.0
      #pragma glsl
      
      half4 _MainColor;
      sampler2D _MainTex;

      struct Input {
          float2 uv_MainTex;
      };
      
      half4 LightingSimple(SurfaceOutput s, half3 lightDir, half atten)
      {
      	half NdotL = dot (s.Normal, lightDir);
          half diff = NdotL * 0.5 + 0.5;
          half4 c;
          c.rgb = s.Albedo * _LightColor0.rgb * (diff * atten * 2);
          c.a = s.Alpha;
          return c;
      }
      
      void vert ( inout appdata_full v, out Input o )
		{
			v.vertex = mul ( _Object2World, v.vertex );
			
			half4 c = tex2Dlod(_MainTex, v.texcoord);
			
			v.vertex = v.vertex + float4(0, c.g * 0.5, 0, 0);
			
			v.vertex = mul ( _World2Object, v.vertex );
			v.vertex.xyz *= unity_Scale.w;
			
			float3 n = v.normal;
			//n.z = -abs(n.z) * c.g;
			n = normalize(n);
			
			v.vertex.xyz += n * c.g * 1.5;
			
			o.uv_MainTex = v.texcoord.xy;
		}
		
      void surf (Input IN, inout SurfaceOutput o) {
			half4 c = tex2D(_MainTex, IN.uv_MainTex);
      		
          o.Albedo = lerp(_MainColor, c, c.g);
      }
      ENDCG
    }
	FallBack "Diffuse"
}
