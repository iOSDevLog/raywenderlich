using UnityEngine;
using System.Collections;

struct MyFavoriteMovies {
  public string GenreType;
  public int StarRating;
  public string[] MovieNames;
}

public class FavoriteMovies : MonoBehaviour {

  public string genreType;
  public int starRating;
  public string[] movies;

  void OnDisable() {
    MyFavoriteMovies myFavoriteMovies = new MyFavoriteMovies();
    myFavoriteMovies.GenreType = genreType;
    myFavoriteMovies.StarRating = starRating;
    myFavoriteMovies.MovieNames = movies;

    Debug.Log("genre type: " + myFavoriteMovies.GenreType);
    Debug.Log("star rating: " + myFavoriteMovies.StarRating);
    Debug.Log("movies: ");
    foreach (string movieName in myFavoriteMovies.MovieNames) {
      Debug.Log(movieName);
    }
  }
	
	// Update is called once per frame
	void Update () {
	
	}
}
