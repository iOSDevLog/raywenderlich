import Foundation

public func example(of description: String, action: () -> Void) {
  print("\n--- Example of:", description, "---")
  action()
}

public let landOfDroids = "Land of Droids"
public let wookieWorld = "Wookie World"
public let detours = "Detours"

public let mayTheOdds = "And may the odds be ever in your favor"
public let liveLongAndProsper = "Live long and prosper"
public let mayTheForce = "May the Force be with you"

public let episodeI = (title: "The Phantom Menace", rating: 55)
public let episodeII = (title: "Attack of the Clones", rating: 66)
public let episodeIII = (title: "Revenge of the Sith", rating: 79)
public let rogueOne = (title: "Rogue One", rating: 85)
public let episodeIV = (title: "A New Hope", rating: 93)
public let episodeV = (title: "The Empire Strikes Back", rating: 94)
public let episodeVI = (title: "Return Of The Jedi", rating: 80)
public let episodeVII = (title: "The Force Awakens", rating: 93)
public let episodeVIII = (title: "The Last Jedi", rating: 91)
public let tomatometerRatings = [episodeI, episodeII, episodeIII, rogueOne, episodeIV, episodeV, episodeVI, episodeVII, episodeVIII]

public enum Droid {
  case C3PO, R2D2
}
