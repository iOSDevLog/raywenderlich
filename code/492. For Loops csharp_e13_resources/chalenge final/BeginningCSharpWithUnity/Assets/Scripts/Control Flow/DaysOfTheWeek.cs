using UnityEngine;
using System.Collections;

public class DaysOfTheWeek : MonoBehaviour {

  public enum DayOfWeek {  Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday };
  public DayOfWeek currentDay;

  void OnDisable() {
    switch (currentDay) {
      case DayOfWeek.Monday:
        Debug.Log("You can fall apart");
        break;
      case DayOfWeek.Tuesday:
      case DayOfWeek.Wednesday:
        Debug.Log("Break my heart.");
        break;
      case DayOfWeek.Thursday:
        Debug.Log("Doesn't even start");
        break;
      case DayOfWeek.Friday:
        Debug.Log("I'm in love");
        break;
      case DayOfWeek.Saturday:
        Debug.Log("Wait");
        break;
      case DayOfWeek.Sunday:
        Debug.Log("Always comes too late");
        break;
    }
  }

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
