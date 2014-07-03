using UnityEngine;
using System.Collections;

public class RodManager : MonoBehaviour
{
	const int RESOLUTION = 1024;

	public Material _rodMaterial;
	public Material _drawMaterial;
	public Material _pushMaterial;
	public Material _clearMaterial;
	public Texture _drawTex;

	RenderTexture _rodTexture;

	void Start () 
	{
		_rodTexture = new RenderTexture(RESOLUTION, RESOLUTION, 24);
		_rodTexture.wrapMode = TextureWrapMode.Clamp;
		_rodMaterial.mainTexture = _rodTexture;

		_drawMaterial.SetTexture("_DrawTex", _drawTex);
		_drawMaterial.SetTexture("_MainTex", _rodTexture);
		_pushMaterial.SetTexture("_MainTex", _rodTexture);
		_clearMaterial.SetTexture("_MainTex", _rodTexture);
	}

	void LateUpdate()
	{
		Shader.SetGlobalFloat("_DeltaTime", Time.deltaTime);

		Graphics.Blit(null, _rodTexture, _pushMaterial);

		Graphics.Blit(null, _rodTexture, _clearMaterial);

		if (Input.GetKeyDown(KeyCode.D))
			Graphics.Blit(null, _rodTexture, _drawMaterial);
	}
}
