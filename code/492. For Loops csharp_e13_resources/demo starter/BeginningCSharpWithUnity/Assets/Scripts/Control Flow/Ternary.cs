using UnityEngine;
using System.Collections;

public class Ternary : MonoBehaviour {

  int[] scores = new int[3];

	// Use this for initialization
	void Start () {
    scores[0] = Random.Range(0, 100);
    scores[1] = Random.Range(0, 100);
    scores[2] = Random.Range(0, 100);
  }
	
  void OnDisable() {
    string result;
    result = (scores[0] % 2 == 0) ? "even" : "odd";
    Debug.Log(scores[0] + " is " + result);
    result = (scores[1] % 2 == 0) ? "even" : "odd";
    Debug.Log(scores[1] + " is " + result);
    result = (scores[2] % 2 == 0) ? "even" : "odd";
    Debug.Log(scores[2] + " is " + result);

  }

	// Update is called once per frame
	void Update () {
	
	}
}
