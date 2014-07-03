Shader "Custom/Push" {
	Properties { 
	_MainTex ("", any) = "" {}
	_Speed ("Speed", Float) = 1
	 }
	CGINCLUDE
	#include "UnityCG.cginc"
	struct v2f {
		float4 pos : POSITION;
		float2 uv : TEXCOORD0;
	};
	
	sampler2D _MainTex;
	float _DeltaTime;
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
		float2 uv = i.uv;

 #if UNITY_UV_STARTS_AT_TOP
          uv.y = 1.0 - uv.y;
 #endif
	  
	  half4 g = tex2D(_MainTex, float2(uv.x, uv.y + _DeltaTime * _Speed));
	  
	  //g = lerp(g, half4(0.0, 0.0, 0.0, 1), _Speed * _DeltaTime * 0.2);
	  
	  //if (grabTexcoord.x < 0 || grabTexcoord.x > 1 ||
	  	//grabTexcoord.y < 0 || grabTexcoord.y > 1)
	  	//g = (0, 0, 0, 1);
		
		return g;
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