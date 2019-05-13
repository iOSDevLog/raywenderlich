// swift-tools-version:4.2
import PackageDescription

let name = "DataStructures"
let testsString = "Tests"

let package = Package(
  name: name,
  targets: [
    .target(name: name, path: "Sources"),
    .testTarget(
      name: "\(name)\(testsString)",
      dependencies: [Target.Dependency(stringLiteral: name)],
      path: testsString
    )
  ]
)
