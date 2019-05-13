using UnityEngine;
using System.Collections;

public class GuessingGame : MonoBehaviour {

  public int guess;
  int randomNumber;

	// Use this for initialization
	void Start () {
    randomNumber = Random.Range(1, 10);
	}
	
  void OnDisable() {
    if (guess >= 1 && guess <= 10) {
      if (guess == randomNumber) {
        Debug.Log("You win!");
      } else if (guess < randomNumber) {
        Debug.Log("Guess higher.");
      } else {
        Debug.Log("Guess lower.");
      }
    } else {
      Debug.Log("Guess a number between 1 and 10");
    }
  }
}
