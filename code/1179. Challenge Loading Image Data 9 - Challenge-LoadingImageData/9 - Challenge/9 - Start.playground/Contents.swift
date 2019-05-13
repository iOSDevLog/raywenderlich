import Foundation

try FileManager.copyPNGSubdirectoriesToDocumentDirectory(subdirectoryNames: "Scenes", "Stickers")

FileManager.documentDirectoryURL

extension FileManager {
  static func getPNGFromDocumentDirectory(subdirectoryName: String, imageName: String) -> UIImage? {
    return UIImage(contentsOfFile: "path")
  }
}
