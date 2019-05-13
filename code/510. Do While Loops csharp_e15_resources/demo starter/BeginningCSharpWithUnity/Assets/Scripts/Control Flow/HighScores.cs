using UnityEngine;
using System.Collections;

public class HighScores : MonoBehaviour {

  public string[] players;
  public int[] scores;

  void OnDisable() {
    for (int i=0; i < players.Length; i++) {
      Debug.Log(players[i] + " scored " + scores[i] + " points.");
    }
  }

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
