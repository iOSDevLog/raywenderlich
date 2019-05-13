import UIKit

try FileManager.copyPNGSubdirectoriesToDocumentDirectory(subdirectoryNames: "Scenes", "Stickers")

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
          year: 1014,
          month: 10,
          day: 7
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
          year: 2,
          month: 3,
          day: 17
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
          year: 1209,
          month: 2,
          day: 15
        ).date,
        normalizedPosition: CGPoint(x: 0.2, y: 0.6),
        imageName: "dog"
      )
    ]
  ),
  Scene(
    width: 700,
    hasReverseGravity: true,
    backgroundName: "space",
    stickers: [
      Sticker(
        name: "Space Count Monkula",
        birthday: DateComponents(
          calendar: .current,
          year: 3006,
          month: 1,
          day: 1
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
    relativeTo: FileManager.documentDirectoryURL.appendingPathComponent("Scenes")
  )
  
  let jsonURL = scenesURL.appendingPathExtension("json")
  
  let jsonEncoder = JSONEncoder()
  jsonEncoder.dateEncodingStrategy = .iso8601
  jsonEncoder.outputFormatting = .prettyPrinted
  let jsonData = try jsonEncoder.encode(scenes)
  try jsonData.write(to: jsonURL)
  
  let jsonDecoder = JSONDecoder()
  jsonDecoder.dateDecodingStrategy = .iso8601
  let savedJSONData = try Data(contentsOf: jsonURL)
  let jsonScenes = try jsonDecoder.decode([Scene].self, from: savedJSONData)
  
  jsonScenes == scenes
  
  let plistURL = scenesURL.appendingPathExtension("plist")
  
  let propertyListEncoder = PropertyListEncoder()
  propertyListEncoder.outputFormat = .xml
  let propertyListData = try propertyListEncoder.encode(scenes)
  try propertyListData.write(to: plistURL)
  
  let propertyListDecoder = PropertyListDecoder()
  let savedPropertyListData = try Data(contentsOf: plistURL)
  let plistScenes = try propertyListDecoder.decode([Scene].self, from: savedPropertyListData)
  
  plistScenes == jsonScenes
  plistScenes.map {$0.view}
}
catch {print(error)}

FileManager.documentDirectoryURL













