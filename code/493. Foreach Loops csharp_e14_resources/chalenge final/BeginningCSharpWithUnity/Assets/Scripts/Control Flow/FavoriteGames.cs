using UnityEngine;
using System.Collections;

public class FavoriteGames : MonoBehaviour {

  public string[] favoriteGames;

  void OnDisable() {
    foreach (string game in favoriteGames) {
      Debug.Log(game);
    }
  }

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
