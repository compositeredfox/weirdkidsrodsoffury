using UnityEngine;
using System.Collections;

public class TriggerFlash : MonoBehaviour {


	public KeyCode key;
	public Vector2 cutoffRange = new Vector2(0.35f,0.85f);
	public float speed = 0.35f;

	// Use this for initialization
	void Start () {
		renderer.material.SetFloat("_Cutoff", cutoffRange.y);
	}
	
	// Update is called once per frame
	void Update () {
		if (renderer.material.GetFloat("_Cutoff") < cutoffRange.y)
			renderer.material.SetFloat("_Cutoff", renderer.material.GetFloat("_Cutoff") + Time.deltaTime * speed);
		if(Input.GetKeyDown(key))
		{
			renderer.material.SetFloat("_Cutoff", cutoffRange.x);
		}
	}
}
