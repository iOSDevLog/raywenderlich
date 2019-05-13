using UnityEngine;
using System.Collections;

public class Operators : MonoBehaviour {

  public int value = 0;

	// Use this for initialization
	void Start () {
	
	}
	
  void OnDisable() {

    Debug.Log("value is " + value % 2);


  }

	// Update is called once per frame
	void Update () {
	
	}
}
