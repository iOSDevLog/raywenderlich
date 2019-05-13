import UIKit

try FileManager.copyPNGSubdirectoriesToDocumentDirectory(subdirectoryNames: "Scenes", "Stickers")

FileManager.documentDirectoryURL

extension FileManager {
 
}

FileManager.getPNGFromDocumentDirectory(subdirectoryName: "Stickers", imageName: "frog")
FileManager.getPNGFromDocumentDirectory(subdirectoryName: "Scenes", imageName: "Forest")
