Shader "Custom/Clear" {
	Properties { 
	_MainTex ("", any) = "" {}
	_Clear ("Main Color", Color) = (1.0, 1.0, 1.0, 0.0)
	_Speed ("Speed", Float) = 1
	 }
	CGINCLUDE
	#include "UnityCG.cginc"
	struct v2f {
		float4 pos : POSITION;
		float2 uv : TEXCOORD0;
	};
	sampler2D _MainTex;
	fixed4 _Clear;
	float _Speed;
	half4 _MainTex_TexelSize;
	
	v2f vert( appdata_img v ) {
		v2f o;
		o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
		o.uv =  v.texcoord.xy;
		
		#if SHADER_API_D3D9 || SHADER_API_D3D11 || SHADER_API_XBOX360
		if(_MainTex_TexelSize.y<0.0)
			o.uv.y = 1.0-o.uv.y;
		#endif
		
		return o;
	}
	half4 frag(v2f i) : COLOR {
		half4 c = tex2D(_MainTex, i.uv);
		c = lerp(c, _Clear, _Speed);
		
		return c;
	}
	ENDCG
	SubShader {
		 Pass {
			  ZTest Always Cull Off ZWrite Off
			  Fog { Mode off }      

			  CGPROGRAM
			  #pragma fragmentoption ARB_precision_hint_fastest
			  #pragma vertex vert
			  #pragma fragment frag
			  ENDCG
		  }
	}
	Fallback off
}