using UnityEngine;
using System.Collections;

struct Player {
  public string FirstName;
  public string LastName;
}

public class Players : MonoBehaviour {

	// Use this for initialization
	void Start () {
	  
	}

  void OnDisable() {
    Player myPlayer = new Player();
    myPlayer.FirstName = "Ray";
    myPlayer.LastName = "Wenderlich";

    RayWenderlich.BeginningCSharp.Example.Player anotherPlayer = new RayWenderlich.BeginningCSharp.Example.Player();
    anotherPlayer.Initials = "BDM";
    anotherPlayer.Score = 100;

  }
	
	// Update is called once per frame
	void Update () {
	
	}
}
