import UIKit

try FileManager.copyPNGSubdirectoriesToDocumentDirectory(subdirectoryNames: "Scenes", "Stickers")

let stickers = [
  Sticker(
    name: "David Meowie",
    birthday: DateComponents(
      calendar: .current,
      year: 1947, month: 1, day: 8
    ).date!,
    normalizedPosition: CGPoint(x: 0.3, y: 0.5),
    imageName: "cat"
  ),
  Sticker(
    name: "Samouse",
    birthday: DateComponents(
      calendar: .current,
      year: 2000, month: 1, day: 1
    ).date!,
    normalizedPosition: CGPoint(x: 0.7, y: 0.5),
    imageName: "rocketmouse"
  )
]

let scene = Scene(width: 900, hasReverseGravity: true, backgroundName: "Space", stickers: stickers)
scene.view

do {
  let jsonURL = URL(
    fileURLWithPath: "stickers",
    relativeTo: FileManager.documentDirectoryURL.appendingPathComponent("Stickers")
  ).appendingPathExtension("json")
  
  let jsonEncoder = JSONEncoder()
  jsonEncoder.outputFormatting = .prettyPrinted
  let jsonData = try jsonEncoder.encode(stickers)
  try jsonData.write(to: jsonURL)
  
  let jsonDecoder = JSONDecoder()
  let savedJSONData = try Data(contentsOf: jsonURL)
  let jsonStickers = try jsonDecoder.decode([Sticker].self, from: savedJSONData)
  
  jsonStickers == stickers
  jsonStickers.map {$0.image}
}
catch {print(error)}

do {
  let jsonURL = URL(fileURLWithPath: "scene", relativeTo: FileManager.documentDirectoryURL.appendingPathComponent("Scenes")).appendingPathExtension("json")
  
  let jsonEncoder = JSONEncoder()
  jsonEncoder.outputFormatting = .prettyPrinted
  let jsonData = try jsonEncoder.encode(scene)
  try jsonData.write(to: jsonURL)
  
  let jsonDecoder = JSONDecoder()
  let savedJSONData = try Data(contentsOf: jsonURL)
  let jsonScene = try jsonDecoder.decode(Scene.self, from: savedJSONData)
  
  jsonScene == scene
}
catch {print(error)}

FileManager.documentDirectoryURL














