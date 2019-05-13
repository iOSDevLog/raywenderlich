//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

enum Coin: Int {
  case penny = 1
  case nickel = 5
  case dime = 10
  case quarter = 25
}

var coin = Coin.quarter

switch coin {
case .penny:
  print("You have a penny")
case .nickel:
  print("You have a nickel")
case .dime:
  print("You have a nickel")
case .quarter:
  print("You have a nickel")
}

var coins: [Coin] = [.quarter, Coin.quarter, Coin.nickel, Coin.nickel, Coin.dime, Coin.penny]

var value = 0
for coin in coins {
    value += coin.rawValue
}
value

enum Icon: String {
  case music
  case sports
  case weather
  
  var fileName: String {
    return "\(rawValue.capitalized).png"
  }
}

let icon = Icon.weather
icon.fileName

enum HTTPMethod {
  case get(address: String)
  case post(body: String)
}

func makeRequest(method: HTTPMethod) {
  switch method {
  case .get(let address):
    print("Address: \(address)")
  case .post(let body):
    print("Body: \(body)")
  }
}

makeRequest(method: .get(address: "http://www.raywenderlich.com"))
makeRequest(method: .post(body: "Hello world"))

