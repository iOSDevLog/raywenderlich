/*:
 Copyright (c) 2018 Razeware LLC
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 distribute, sublicense, create a derivative work, and/or sell copies of the
 Software in any work that is designed, intended, or marketed for pedagogical or
 instructional purposes related to programming, coding, application development,
 or information technology.  Permission for such use, copying, modification,
 merger, publication, distribution, sublicensing, creation of derivative works,
 or sale is expressly withheld.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 ---
 */
import UIKit

for image in try! [Image](fileName: "images") {
  try! image.save(directory: .documentDirectory)
}

let scenes = [
  Scene(
    width: 700,
    hasReverseGravity: false,
    backgroundName: "Forest",
    stickers: [
      Sticker(
        name: "Catwarts",
        birthday: DateComponents(
          calendar: .current,
          year: 1014, month: 10, day: 7
        ).date,
        normalizedPosition: CGPoint(x: 0.27, y: 0.25),
        imageName: "castle"
      ),
      Sticker(
        name: "Professor Froggonagle",
        birthday: nil,
        normalizedPosition: CGPoint(x: 0.15, y: 0.65),
        imageName: "frog"
      ),
      Sticker(
        name: "Mr. Basilisk",
        birthday: DateComponents(
          calendar: .current,
          year: 2, month: 3, day: 17
        ).date,
        normalizedPosition: CGPoint(x: 0.7, y: 0.38),
        imageName: "coiled snake"
      )
    ]
  ),
  Scene(
    width: 700,
    hasReverseGravity: false,
    backgroundName: "Winterfence",
    stickers: [
      Sticker(
        name: "House Bark",
        birthday: nil,
        normalizedPosition: CGPoint(x: 0.8, y: 0.05),
        imageName: "castle"
      ),
      Sticker(
        name: "Doggh Snow",
        birthday: DateComponents(
          calendar: .current,
          year: 1209, month: 2, day: 15
        ).date,
        normalizedPosition: CGPoint(x: 0.2, y: 0.6),
        imageName: "dog"
      )
    ]
  ),
  Scene(
    width: 700,
    hasReverseGravity: true,
    backgroundName: "Space",
    stickers: [
      Sticker(
        name: "Space Count Monkula",
        birthday: DateComponents(
          calendar: .current,
          year: 3006, month: 1, day: 1
        ).date,
        normalizedPosition: CGPoint(x: 0.7, y: 0.45),
        imageName: "space monkey"
      ),
      Sticker(
        name: "Castle Monkula",
        birthday: nil,
        normalizedPosition: CGPoint(x: 0.2, y: 0.2),
        imageName: "castle"
      )
    ]
  )
]

do {
  let scenesURL = URL(
    fileURLWithPath: "scenes",
    relativeTo: FileManager.documentDirectoryURL.appendingPathComponent(Image.Kind.scene.rawValue)
  )
  
  let jsonURL = scenesURL.appendingPathExtension("json")
  
  let jsonEncoder = JSONEncoder()
  let jsonData = try jsonEncoder.encode(scenes)
  try jsonData.write(to: jsonURL)
  
  let jsonDecoder = JSONDecoder()
  let savedJSONData = try Data(contentsOf: jsonURL)
  let jsonScenes = try jsonDecoder.decode([Scene].self, from: savedJSONData)
  
  jsonScenes == scenes
  
  let plistURL = scenesURL.appendingPathExtension("plist")
  
  let propertyListEncoder = PropertyListEncoder()
  let propertyListData = try propertyListEncoder.encode(scenes)
  try propertyListData.write(to: plistURL)
  
  let propertyListDecoder = PropertyListDecoder()
  let savedPropertyListData = try Data(contentsOf: plistURL)
  let plistScenes = try propertyListDecoder.decode([Scene].self, from: savedPropertyListData)
  
  plistScenes == jsonScenes
  plistScenes.map { $0.view }
}
catch { print(error) }

FileManager.documentDirectoryURL
