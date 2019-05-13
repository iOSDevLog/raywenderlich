using UnityEngine;
using System.Collections;

public class Enumeration : MonoBehaviour {

  public enum Direction { Up = 1, Down = -1 };
  public Direction playerMovement;

  void OnDisable() {
    float yMovement = 10.0f;
    yMovement *= (int)playerMovement;
    Debug.Log(yMovement);

    if (playerMovement == Direction.Up) {

    }
  }

	// Use this for initialization
	void Start () {
    const float pi = 3.141f;
    //pi *= 100;
    const string name = "Brian";
    //name = "Ray";
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
