import UIKit

public struct Sticker: Codable {
  public init(
    name: String,
    birthday: Date?,
    normalizedPosition: CGPoint,
    imageName: String
  ) {
    self.name = name
    self.birthday = birthday
    self.normalizedPosition = normalizedPosition
    self.imageName = imageName
  }
  
  public let name: String
  public let birthday: Date?
  public let normalizedPosition: CGPoint
  public let imageName: String
  
  public var image: UIImage? {
    return FileManager.getPNGFromDocumentDirectory(
      subdirectoryName: "Stickers",
      imageName: imageName
    )
  }
}

//MARK: Equatable
extension Sticker: Equatable {
  public static func == (sticker0: Sticker, sticker1: Sticker) -> Bool {
    return
      sticker0.name == sticker1.name
      && sticker0.birthday == sticker1.birthday
      && sticker0.normalizedPosition == sticker1.normalizedPosition
      && sticker0.imageName == sticker1.imageName
  }
}
