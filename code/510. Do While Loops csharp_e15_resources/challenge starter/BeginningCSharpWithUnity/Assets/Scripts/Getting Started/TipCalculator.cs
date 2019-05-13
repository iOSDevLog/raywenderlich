using UnityEngine;
using System.Collections;

public class TipCalculator : MonoBehaviour {

  public float tipAmount;
  public float balance;


  void OnDisable() {

    float amountShouldTip = 0;
    amountShouldTip = balance * tipAmount;
    Debug.Log("You should tip: " + amountShouldTip);


  }

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
