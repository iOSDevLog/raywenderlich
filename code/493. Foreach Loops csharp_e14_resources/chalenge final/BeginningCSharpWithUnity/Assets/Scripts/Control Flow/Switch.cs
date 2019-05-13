using UnityEngine;
using System.Collections;

public class Switch : MonoBehaviour {

  public int playerCount;

  void OnDisable() {
    switch(playerCount) {
      case 1:
        Debug.Log("Hello player one");
        break;
      case 2:
        Debug.Log("Hello players");
        break;
      default:
        Debug.Log("Please enter 1 or 2 players");
        break;
    }
  }

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
