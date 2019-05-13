using UnityEngine;
using System.Collections;

public class FavoriteGamesWhile : MonoBehaviour {

  public string[] favoriteGames;

  void OnDisable() {
    int i = 0;
    while (i < favoriteGames.Length) {
      Debug.Log(favoriteGames[i]);
      i += 1;
    }
  }

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
