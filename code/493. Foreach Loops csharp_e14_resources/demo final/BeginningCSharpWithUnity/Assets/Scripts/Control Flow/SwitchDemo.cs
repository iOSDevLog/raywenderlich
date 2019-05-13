using UnityEngine;
using System.Collections;

public class SwitchDemo : MonoBehaviour {

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

  void OnDisable() {
    string greeting = "both";
    switch (greeting) {
      case "hi":
      case "hello":
        Debug.Log("You are arriving");
        if (greeting == "both") {
          goto case "goodbye";
        }
        break;
      case "goodbye":
        Debug.Log("You are leaving");
        break;
      case "both":
        goto case "hello";
      default:
        Debug.Log("Another greeting");
        break;
    }
  }
}
