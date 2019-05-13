import Foundation
import RxSwift

public func example(of description: String, action: () -> Void) {
  print("\n--- Example of:", description, "---")
  action()
}

public let episodeI = "Episode I - The Phantom Menace"
public let episodeII = "Episode II - Attack of the Clones"
public let episodeIII = "Episode III - Revenge of the Sith"
public let episodeIV = "Episode IV - A New Hope"
public let episodeV = "Episode V - The Empire Strikes Back"
public let episodeVI = "Episode VI - Return Of The Jedi"
public let episodeVII = "Episode VII - The Force Awakens"
public let episodeVIII = "Episode VIII - The Last Jedi"
public let episodeIX = "Episode IX"

public let episodes = [episodeI, episodeII, episodeIII, episodeIV, episodeV, episodeVI, episodeVII, episodeVIII, episodeIX]

public extension String {
  
  /// https://stackoverflow.com/a/36949832/616764
  func romanNumeralIntValue() throws -> Int  {
    if range(of: "^(?=[MDCLXVI])M*(C[MD]|D?C{0,3})(X[CL]|L?X{0,3})(I[XV]|V?I{0,3})$", options: .regularExpression) == nil  {
      throw NSError(domain: "NotValidRomanNumber", code: -1, userInfo: nil)
    }
    
    var result = 0
    var maxValue = 0
    
    uppercased().reversed().forEach {
      let value: Int
      switch $0 {
      case "M":
        value = 1000
      case "D":
        value = 500
      case "C":
        value = 100
      case "L":
        value = 50
      case "X":
        value = 10
      case "V":
        value = 5
      case "I":
        value = 1
      default:
        value = 0
      }
      
      maxValue = max(value, maxValue)
      result += value == maxValue ? value : -value
    }
    
    return result
  }
}

public struct Jedi {
  
  public var rank: BehaviorSubject<JediRank>
  
  public init(rank: BehaviorSubject<JediRank>) {
    self.rank = rank
  }
}

public enum JediRank: String {
  
  case youngling = "Youngling"
  case padawan = "Padawan"
  case jediKnight = "Jedi Knight"
  case jediMaster = "Jedi Master"
  case jediGrandMaster = "Jedi Grand Master"
}
