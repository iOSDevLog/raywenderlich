import Foundation

try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)

FileManager.documentDirectoryURL
