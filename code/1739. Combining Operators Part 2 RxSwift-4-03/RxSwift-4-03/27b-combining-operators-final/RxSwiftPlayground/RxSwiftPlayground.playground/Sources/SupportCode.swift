import Foundation

public func example(of description: String, action: () -> Void) {
  print("\n--- Example of:", description, "---")
  action()
}

public let episodeI = "The Phantom Menace"
public let episodeII = "Attack of the Clones"
public let theCloneWars = "The Clone Wars"
public let episodeIII = "Revenge of the Sith"
public let solo = "Solo"
public let rogueOne = "Rogue One"
public let episodeIV = "A New Hope"
public let episodeV = "The Empire Strikes Back"
public let episodeVI = "Return Of The Jedi"
public let episodeVII = "The Force Awakens"
public let episodeVIII = "The Last Jedi"
public let episodeIX = "Episode IX"

public let luke = "Luke Skywalker"
public let hanSolo = "Han Solo"
public let leia = "Princess Leia"
public let chewbacca = "Chewbacca"

public let lightsaber = "Lightsaber"
public let dl44 = "DL-44 Blaster"
public let defender = "Defender Sporting Blaster"
public let bowcaster = "Bowcaster"

let formatter = DateComponentsFormatter()

public func stringFrom(_ minutes: Int) -> String {
  let interval = TimeInterval(minutes)
  return formatter.string(from: interval) ?? ""
}

public let runtimes = [
  episodeI: 136,
  episodeII: 142,
  theCloneWars: 98,
  episodeIII: 140,
  solo: 142,
  rogueOne: 142,
  episodeIV: 121,
  episodeV: 124,
  episodeVI: 134,
  episodeVII: 136,
  episodeVIII: 152
]
