import UIKit

try FileManager.copyPNGSubdirectoriesToDocumentDirectory(subdirectoryNames: "Scenes", "Stickers")



let name = "David Meowie"
let birthday = DateComponents(calendar: .current, year: 1947, month: 1, day: 8).date!
let normalizedPosition = CGPoint(x: 0.3, y: 0.5)
let imageName = "cat"

let sticker = Sticker(name: name, birthday: birthday, normalizedPosition: normalizedPosition, imageName: imageName)
sticker == sticker
sticker.image
