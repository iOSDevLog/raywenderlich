// swift-tools-version:4.1
import PackageDescription

let package = Package(
  name: "EmojiJournalServer",
  dependencies: [
    .package(url: "https://github.com/IBM-Swift/Kitura.git", .upToNextMinor(from: "2.2.0")),
    .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", .upToNextMinor(from: "1.7.1")),
    .package(url: "https://github.com/IBM-Swift/Kitura-CouchDB.git", .upToNextMinor(from: "2.0.1")),
    .package(url: "https://github.com/IBM-Swift/Kitura-StencilTemplateEngine.git", .upToNextMinor(from: "1.9.1")),
    .package(url: "https://github.com/IBM-Swift/CloudEnvironment.git", from: "6.0.0"),
    .package(url: "https://github.com/IBM-Swift/Configuration.git", from: "3.0.0"),
    .package(url: "https://github.com/RuntimeTools/SwiftMetrics.git", from: "2.0.0"),
    .package(url: "https://github.com/IBM-Swift/Health.git", from: "1.0.0"),
    ],
  targets: [
    .target(name: "EmojiJournalServer", dependencies: ["Configuration", "CloudEnvironment", "SwiftMetrics", "Health", "Kitura", "HeliumLogger", "CouchDB", "KituraStencil"])
  ]
)
