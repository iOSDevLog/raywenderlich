using UnityEngine;
using System.Collections;

public class WhileLoop : MonoBehaviour {

  public int[] score;

  void OnDisable() {

    int i = 10;
    while (i < score.Length) {
      Debug.Log("The " + i + " element is " + score[i]);
      i += 1;
    }

    do {
      Debug.Log("The " + i + " element is " + score[i]);
      i += 1;
    } while (i < score.Length);

  }

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {

	}
}
