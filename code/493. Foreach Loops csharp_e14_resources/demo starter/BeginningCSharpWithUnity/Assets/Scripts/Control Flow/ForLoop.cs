using UnityEngine;
using System.Collections;

public class ForLoop : MonoBehaviour {

  public int[] score;

  void OnDisable() {
    for (int i = 0; i < 10; i++) {
      //Debug.Log("Unity Rocks!");
    }
    for (int i=0; i < 10; i++) {
      if (i % 2 != 0) {
        continue;
      }
     // Debug.Log("i is " + i);
    }
    for (int i = 0; i < 10; i++) {
      if (i % 2 != 0) {
        continue;
      }
      for (int j = 0; j < 10; j++) {
        if (j % 2 != 0) {
          continue;
        }
       // Debug.Log(i + " + " + j + " = " + (i + j));
      }
    }
    // Infinite Loop
    //    for (int i = 0; i < 10; i--) {
    //      Debug.Log("Unity Rocks!");
    //    }

    Debug.Log(score[0]);
    Debug.Log(score[1]);
    Debug.Log(score[2]);
    Debug.Log(score[3]);
    Debug.Log(score[4]);

    for (int i=0; i < score.Length; i++) {
      Debug.Log("The " + i + " element is " + score[i]);
    }


  }

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {

	}
}
