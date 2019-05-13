using UnityEngine;
using System.Collections;
using UnityEngine.UI;

namespace RayWenderlich.BeginningCSharp.Demonstration {
  struct Alien {
    public int HitPoints;
  }
}


public class Alien : MonoBehaviour {

  public Text playerName;

	// Use this for initialization
	void Start () {
    RayWenderlich.BeginningCSharp.Demonstration.Alien alien = new RayWenderlich.BeginningCSharp.Demonstration.Alien();
    alien.HitPoints = 100;
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
