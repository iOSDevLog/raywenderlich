using UnityEngine;
using System.Collections;

public class ScopeDemo : MonoBehaviour {

  bool isTrue = true;

  void OnDisable() {
    int randomNumber = 0;
    if (isTrue) {
      Debug.Log("is true");
      randomNumber = Random.Range(1, 100);
    }
    Debug.Log("The random number is: " + randomNumber);

  }

	// Use this for initialization
	void Start () {
    if (isTrue) {
      Debug.Log("is true");
    }
  }
	
	// Update is called once per frame
	void Update () {
	
	}
}
