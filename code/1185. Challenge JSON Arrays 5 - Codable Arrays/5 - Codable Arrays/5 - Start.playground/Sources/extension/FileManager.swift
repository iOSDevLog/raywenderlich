import UIKit

public extension FileManager {
  static func copyPNGSubdirectoriesToDocumentDirectory(subdirectoryNames: String...) throws {
    for subdirectoryName in subdirectoryNames {
      let documentSubdirectoryURL = URL(
        fileURLWithPath: subdirectoryName,
        relativeTo: FileManager.documentDirectoryURL
      )
      
      try? FileManager.default.createDirectory(
        at: documentSubdirectoryURL,
        withIntermediateDirectories: false
      )
      
      guard let pngURLs = Bundle.main.urls(
        forResourcesWithExtension: "png",
        subdirectory: subdirectoryName
      )
      else {continue}
      
      for pngURL in pngURLs {
        let data = try Data(contentsOf: pngURL)
        try data.write(
          to: documentSubdirectoryURL.appendingPathComponent(pngURL.lastPathComponent),
          options: .atomic
        )
      }
    }
  }
  
  static var documentDirectoryURL: URL {
    return try! FileManager.default.url(
      for: .documentDirectory,
      in: .userDomainMask,
      appropriateFor: nil,
      create: false
    )
  }
  
  static func getPNGFromDocumentDirectory(subdirectoryName: String, imageName: String) -> UIImage? {
    return UIImage(
      contentsOfFile:
        FileManager.documentDirectoryURL
        .appendingPathComponent(subdirectoryName)
        .appendingPathComponent(imageName)
        .appendingPathExtension("png")
        .path
    )
  }
}
