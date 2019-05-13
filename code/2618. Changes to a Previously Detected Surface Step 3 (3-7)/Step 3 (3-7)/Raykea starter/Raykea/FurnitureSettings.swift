/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import UIKit
import ARKit

class FurnitureSettings {

  let furniturePictures = [
    UIImage(named: "bookshelf-pic"),
    UIImage(named: "chair-pic"),
    UIImage(named: "couch-pic"),
    UIImage(named: "table-pic"),
    ]
  let furnitureNames = [
    "BIBLIOTEK",
    "BÜTTPLAIZE",
    "DERP",
    "TEBBEL",
    ]
  let furnitureDescriptions = [
    "Do you have a thing called...books? Do you have a place to put them? No? You need this.",
    "Standing is for suckers. Sitting is the new standing. Park your butt in...BÜTTPLAIZE!",
    "Need a place to eat chips and binge-watch Netflix for hours? You need DERP.",
    "Free your hands by putting your plate and glass on TEBBEL.",
    ]
  let furnitureOffsets = [
    SCNVector3(0, 0, 0),
    SCNVector3(0, 0.32, 0),
    SCNVector3(0, 0, 0),
    SCNVector3(0, 0, 0),
    ]

  var furniture = 0

  func currentFurniturePiece() -> SCNNode {
    switch furniture {
    case 0:
      return createBookshelf()
    case 1:
      return createChair()
    case 2:
      return createCouch()
    case 3:
      return createTable()
    default:
      return createBookshelf()
    }
  }

  func currentFurnitureOffset() -> SCNVector3 {
    return furnitureOffsets[furniture]
  }

  func createBookshelf() -> SCNNode {
    let scene = SCNScene(named: "SceneAssets.scnassets/furniture.scn")
    let node = (scene?.rootNode.childNode(withName: "bookcase", recursively: false))!
    return node
  }

  func createChair() -> SCNNode {
    let scene = SCNScene(named: "SceneAssets.scnassets/furniture.scn")
    let node = (scene?.rootNode.childNode(withName: "chair", recursively: false))!
    return node
  }

  func createCouch() -> SCNNode {
    let scene = SCNScene(named: "SceneAssets.scnassets/furniture.scn")
    let node = (scene?.rootNode.childNode(withName: "couch", recursively: false))!
    return node
  }

  func createTable() -> SCNNode {
    let scene = SCNScene(named: "SceneAssets.scnassets/furniture.scn")
    let node = (scene?.rootNode.childNode(withName: "table", recursively: false))!
    return node
  }

}

