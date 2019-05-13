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

FileManager.documentDirectoryURL
