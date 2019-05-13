import UIKit

try FileManager.copyPNGSubdirectoriesToDocumentDirectory(subdirectoryNames: "Scenes", "Stickers")

let sticker = Sticker(
  name: "David Meowie",
  birthday: DateComponents(
    calendar: .current,
    year: 1947, month: 1, day: 8
  ).date!,
  normalizedPosition: CGPoint(x: 0.3, y: 0.5),
  imageName: "cat"
)

do {
  let jsonURL = URL(fileURLWithPath: "sticker", relativeTo: FileManager.documentDirectoryURL.appendingPathComponent("Stickers")).appendingPathExtension("json")
  
  let jsonEncoder = JSONEncoder()
  jsonEncoder.outputFormatting = .prettyPrinted
  let jsonData = try jsonEncoder.encode(sticker)
  try jsonData.write(to: jsonURL)
  
  let jsonDecoder = JSONDecoder()
  let savedJSONData = try Data(contentsOf: jsonURL)
  let jsonSticker = try jsonDecoder.decode(Sticker.self, from: savedJSONData)
  jsonSticker == sticker
}
catch {print(error)}

FileManager.documentDirectoryURL
