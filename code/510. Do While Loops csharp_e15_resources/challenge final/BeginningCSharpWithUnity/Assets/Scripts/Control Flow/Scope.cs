using UnityEngine;
using System.Collections;

public class Scope : MonoBehaviour {

  bool shouldProceed = true;

  void OnDisable() {
    int value = 36;
    int additionalValue = 0;
    if (shouldProceed) {
      additionalValue = 6;
    }
    Debug.Log((value + additionalValue) + " = 42");
  }

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
