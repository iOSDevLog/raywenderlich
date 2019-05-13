import UIKit

public struct Scene: Codable {
  public init(
    width: Int,
    hasReverseGravity: Bool,
    backgroundName: String,
    stickers: [Sticker]
  ) {
    self.width = width
    self.hasReverseGravity = hasReverseGravity
    self.backgroundName = backgroundName
    self.stickers = stickers
  }
  
  public let width: Int
  public let hasReverseGravity: Bool
  public let backgroundName: String
  public let stickers: [Sticker]
}

//MARK: public
public extension Scene {
  public var background: UIImage? {
    return FileManager.getPNGFromDocumentDirectory(
      subdirectoryName: "Scenes",
      imageName: backgroundName
    )
  }

  var view: UIImageView? {
    guard let background = background
    else {return nil}
    
    let sceneWidth = CGFloat(width)
    let sceneHeight = background.size.height / background.size.width * sceneWidth

    let sceneView = UIImageView(
      frame: CGRect(
        x: 0, y: 0,
        width: sceneWidth, height: sceneHeight
      )
    )
    sceneView.image = background

    for sticker in stickers {
      guard let stickerImage = sticker.image
      else {continue}
      
      let size = stickerImage.size
      let height = sceneHeight / 3
      let view = UIImageView(
        frame: CGRect(
          x: sticker.normalizedPosition.x * sceneWidth,
          y: sticker.normalizedPosition.y * sceneHeight,
          width: size.width / size.height * height,
          height: height
        )
      )
      view.image = stickerImage
      view.transform = CGAffineTransform(
        rotationAngle: hasReverseGravity ? .pi : 0
      )

      sceneView.addSubview(view)
    }

    return sceneView
  }
}

//MARK: Equatable
extension Scene: Equatable {
  public static func == (scene0: Scene, scene1: Scene) -> Bool {
    return
      scene0.width == scene1.width
      && scene0.hasReverseGravity == scene1.hasReverseGravity
      && scene0.backgroundName == scene1.backgroundName
      && scene0.stickers == scene1.stickers
  }
}
