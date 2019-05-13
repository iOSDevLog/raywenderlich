using UnityEngine;
using System.Collections;

public class HelloWorld : MonoBehaviour {

  public string gameName = "Half Life";
  public int price = 10;
  public string anotherGameName = "Minecraft";
  public int score = 5;
  public double myDouble = 10.1;
  public float myFloat = 10.1f;
  public bool likesGame = false;

  // This is for demonstration purposes only.
  public byte overflowError = 255;


  void OnEnable() {
    Debug.Log("I am enabled.");
  }

  // This will fire on the OnDisable event

  void OnDisable() {
    // string gameName = "Half Life";
    //int price = 10;
    /**
    Debug.Log("The game " + gameName + " is " + price + " dollars.");
    Debug.Log("The game " + gameName + " is rated at " + score + " stars.");
    **/
    overflowError = (byte)(overflowError + 3);
    Debug.Log("The result of the overflow error is: " + overflowError);
  }

}
