Shader "Custom/Draw" {
	Properties { 
	_MainTex ("", any) = "" {}
	_DrawTex ("", 2D) = "" {}
	_Speed ("Speed", Float) = 1
	 }
	CGINCLUDE
	#include "UnityCG.cginc"
	struct v2f {
		float4 pos : POSITION;
		float2 uv : TEXCOORD0;
	};
	
	sampler2D _MainTex;
	sampler2D _DrawTex;
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
	  
	  half4 c = tex2D(_MainTex, uv);
	  half4 c2 = tex2D(_DrawTex, uv);
	  c = half4(max(c.r, c2.r), max(c.g, c2.g), max(c.b, c2.b), 1);
	  
	  //if (grabTexcoord.x < 0 || grabTexcoord.x > 1 ||
	  	//grabTexcoord.y < 0 || grabTexcoord.y > 1)
	  	//g = (1, 1, 1, 0);
		
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