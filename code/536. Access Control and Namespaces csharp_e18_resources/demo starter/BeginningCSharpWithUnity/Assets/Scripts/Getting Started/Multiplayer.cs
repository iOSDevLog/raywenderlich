using UnityEngine;
using System.Collections;

public class Multiplayer : MonoBehaviour {

  public int players;
  public string[] names;
  public bool validateNames;
  public bool isOnline;

  void OnDisable() {
    if (players > -1 && players < 3) {
      if (players == 0) {
        Debug.Log("Please join the game.");
      } else if (players == 1) {
        Debug.Log("Hello player one!");
      } else {
        Debug.Log("Hello players!");
      }
    } else {
      Debug.Log("Please enter 0-2 players");
    }
    if (validateNames || (isOnline && players > 1)) {
      // code runs here
    }
  }
}
