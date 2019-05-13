import Foundation

public extension FileManager {
  static var documentDirectoryURL: URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  }
}
