using UnityEngine;
using System.Collections;

public class CoolCat : MonoBehaviour {

	public KeyCode cutoffKey;
	public Vector2 cutoffRange = new Vector2(0.35f,0.85f);
	public float cutoffSpeed = 0.35f;
	public KeyCode bobKey;
	public float bobSpeed;
	public AnimationCurve bobCurve = AnimationCurve.Linear(0,0,1,1);
	float bobvalue = 1;

	SkinnedMeshRenderer smr; 
	// Use this for initialization
	void Start () {
		renderer.material.mainTextureOffset = new Vector2(Random.value, Random.value);
		smr = gameObject.GetComponent<SkinnedMeshRenderer>();
		renderer.material.SetFloat("_Cutoff", cutoffRange.x);
		bobvalue = 1;
		smr.SetBlendShapeWeight(1,bobCurve.Evaluate(bobvalue) * 100);
	}
	
	// Update is called once per frame
	void Update () {
		if (renderer.material.GetFloat("_Cutoff") > cutoffRange.x)
			renderer.material.SetFloat("_Cutoff", renderer.material.GetFloat("_Cutoff") - Time.deltaTime * cutoffSpeed);
		if(Input.GetKeyDown(cutoffKey))
		{
			renderer.material.SetFloat("_Cutoff", cutoffRange.y);
		}

		if(bobvalue < 1)
			bobvalue += Time.deltaTime*bobSpeed;
		if(Input.GetKey(bobKey))
			bobvalue = 0;
		smr.SetBlendShapeWeight(1,bobCurve.Evaluate(bobvalue) * 100);
		renderer.material.mainTextureOffset = renderer.material.mainTextureOffset + Vector2.up * Time.deltaTime * 0.002f;
	}
}
