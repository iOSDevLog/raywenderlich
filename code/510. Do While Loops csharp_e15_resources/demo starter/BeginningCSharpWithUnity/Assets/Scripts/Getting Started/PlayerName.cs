using UnityEngine;
using System.Collections;

public class PlayerName : MonoBehaviour {

  public string pName;

  void OnDisable() {
    string playerName = (pName != null && pName != "") ? pName : "player one";
    Debug.Log("Hello " + playerName);
  }

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
