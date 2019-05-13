using UnityEngine;
using System.Collections;

public class MadLibs : MonoBehaviour {

  public string myName;
  public string favoriteFood;
  public double amount;
  public bool likesToShare;

  void OnDisable() {
    Debug.Log(myName + "'s favorite food is " + favoriteFood + ". " + myName + " eats " + amount + " per day. Does " + myName + " like to share? " + likesToShare);
  }

}
