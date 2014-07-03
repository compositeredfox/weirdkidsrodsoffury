using UnityEngine;
using System.Collections;

public class BlobParticle : MonoBehaviour {

	public KeyCode bobKey;
	public float shrinkSpeed = 2;
	public AnimationCurve bobCurve = AnimationCurve.Linear(0,0,1,1);
	float sizeRatio = 1;

	ParticleSystem ps; 
	float originalSize = 1;
	// Use this for initialization
	void Start () {
		ps = GetComponentInChildren<ParticleSystem>();
		originalSize = ps.startSize;

		sizeRatio = 1;
		ps.startSize = bobCurve.Evaluate(sizeRatio) * originalSize;
	}
	
	// Update is called once per frame
	void Update () {

		if(sizeRatio < 1)
			sizeRatio += Time.deltaTime*shrinkSpeed;
		if(Input.GetKey(bobKey))
			sizeRatio = 0;
		ps.startSize = bobCurve.Evaluate(sizeRatio) * originalSize;
	}
}
