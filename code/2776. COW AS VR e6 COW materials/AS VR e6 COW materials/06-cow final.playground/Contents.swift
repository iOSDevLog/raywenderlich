// Copyright (c) 2019 Razeware LLC
// See Copyright Notice page for details about the license.

import Foundation

let owlBear = RWMonster(name: "Owl Bear", hitPoints: 30)
var enemies: [RWMonster] = [owlBear]
owlBear.hitPoints += 10
print(enemies)  // Reference semantics :[

final class SwiftReference<T> {
  var object: T
  init(_ object: T) {
    self.object = object
  }
}

struct Monster: CustomStringConvertible {
  
  private var _monster: SwiftReference<RWMonster>
  
  private var _mutatingMonster: RWMonster {
    
    mutating get {
      if !isKnownUniquelyReferenced(&_monster) {
        print("making copy")
        _monster = SwiftReference(_monster.object.copy() as! RWMonster)
      }
      else {
        print("no copy")
      }
      return _monster.object
    }
  }
  
  init(name: String, hitPoints: Int) {
    _monster = SwiftReference(RWMonster(name: name, hitPoints: hitPoints))
  }
  
  var description: String {
    return String(describing: _monster.object)
  }
  
  var name: String {
    get {
      return _monster.object.name
    }
    set {
      _mutatingMonster.name = newValue
    }
  }
  
  var hitPoints: Int {
    get {
      return _monster.object.hitPoints
    }
    set {
      _mutatingMonster.hitPoints = newValue
    }
  }
}

var troll = Monster(name: "Troll", hitPoints: 30)
var monsters: [Monster] = [troll]
troll.hitPoints += 100
troll.hitPoints += 1000
troll.hitPoints += 1000
troll.hitPoints += 1000
print(monsters)  // Value semantics :]
print(troll)
