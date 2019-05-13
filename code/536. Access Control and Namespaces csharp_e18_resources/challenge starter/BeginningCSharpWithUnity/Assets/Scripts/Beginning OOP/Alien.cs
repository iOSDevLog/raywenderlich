using UnityEngine;
using System.Collections;

namespace Raywenderlich.BeginningCSharp.Namespaces {
  struct Alien {
    public int HitPoints;
  }
}


public class Alien : MonoBehaviour {

  public UnityEngine.UI.Text myText;
  public 

	// Use this for initialization
	void Start () {
    Raywenderlich.BeginningCSharp.Namespaces.Alien alien = new Raywenderlich.BeginningCSharp.Namespaces.Alien();
    alien.HitPoints = 100;
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
