// Copyright (c) 2019 Razeware LLC
// See Copyright Notice page for details about the license.

struct Named<T>: Hashable, ExpressibleByStringLiteral {
  var name: String
  
  init(_ name: String) {
    self.name = name
  }
  
  init(stringLiteral value: String) {
    name = value
  }
}

enum StateTag {}
enum CapitalTag {}
typealias State = Named<StateTag>
typealias Capital = Named<CapitalTag>

var lookup: [State: Capital] = ["Alabama": "Montgomery",
                                "Alaska":  "Juneau",
                                "Arizona": "Phoenix"]

func printStateAndCapital(_ state: State, _ capital: Capital) {
  print("The capital of \(state.name) is \(capital.name).")
}

func test() {
  
  let alaska = State("Alaska")
  
  guard let capital = lookup[alaska] else {
    return
  }
  printStateAndCapital(alaska, capital)
}

test()


