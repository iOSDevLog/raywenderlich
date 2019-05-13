using UnityEngine;
using System.Collections;

public class HighScore : MonoBehaviour {

  public string[] names;
  public int[] scores;

	// Use this for initialization
	void Start () {
	
	}
	
  void OnDisable() {


    Debug.Log("The people who work at Razeware are:");
    Debug.Log(names[0]);
    Debug.Log(names[1]);
    Debug.Log(names[2]);
    Debug.Log(names[3]);
    Debug.Log(names[4]);
    Debug.Log(names[5]);
    Debug.Log(names[6]);
    Debug.Log(names[7]);

    int average = scores[0] + scores[1] + scores[2] + scores[3] + scores[4] + scores[5] + scores[6] + scores[7];
    average /= 8;
    Debug.Log("The high score average is " + average);
    
  }


	// Update is called once per frame
	void Update () {
	
	}
}
