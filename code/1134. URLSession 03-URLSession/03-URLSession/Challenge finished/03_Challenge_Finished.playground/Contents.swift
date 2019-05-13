import Foundation
//: ## URLSession Challenge
//: Now we'll look more closely at `URLSessionConfiguration`.
//: ### Session Configurations & Sessions
//: The quickest way to get a session is to use the shared singleton session object:
let sharedSession = URLSession.shared
//: The shared singleton session object uses the __default configuration__,
//: for example, its `allowsCellularAccess` property has the default value `true`:
sharedSession.configuration.allowsCellularAccess
//: You cannot change this value in the session:
sharedSession.configuration.allowsCellularAccess = false
// check the value:
sharedSession.configuration.allowsCellularAccess
//: DONE: To create a session that doesn't allow cellular access,
//: first create a configuration object:
let myDefaultConfiguration = URLSessionConfiguration.default
// check the value:
myDefaultConfiguration.allowsCellularAccess
myDefaultConfiguration.waitsForConnectivity
//: DONE: Then change its `allowsCellularAccess` property to `false`:
myDefaultConfiguration.allowsCellularAccess = false
// check the value:
myDefaultConfiguration.allowsCellularAccess
//: DONE: Apple recommends setting `waitsForConnectivity` to `true`, for all non-background configurations:
myDefaultConfiguration.waitsForConnectivity = true
//: DONE: Set `multipathServiceType` to `.handover` or `.interactive`, and update `allowsCellularAccess` to match:
myDefaultConfiguration.multipathServiceType = .handover
myDefaultConfiguration.allowsCellularAccess = true
//: DONE: Now create a session with this configuration:
let myDefaultSession = URLSession(configuration: myDefaultConfiguration)
// check the values:
myDefaultSession.configuration.allowsCellularAccess
myDefaultSession.configuration.waitsForConnectivity
//: You can also create a session with the default configuration, if you don't need to change any properties:
let defaultSession = URLSession(configuration: .default)
//: And the value of `allowsCellularAccess` is the default value `true`:
defaultSession.configuration.allowsCellularAccess
//: ### Customize the Cache
//: The disk capacity of the default configuration is 10 million bytes:
myDefaultConfiguration.urlCache?.diskCapacity
//: DONE: Look at the memory capacity of the cache:
myDefaultConfiguration.urlCache?.memoryCapacity
//: DONE: Create a new ephemeral configuration, and check the disk and memory capacity of its cache:
let ephemeralConfiguration = URLSessionConfiguration.ephemeral
ephemeralConfiguration.urlCache?.diskCapacity
ephemeralConfiguration.urlCache?.memoryCapacity
//: An ephemeral configuration has no persistent storage for cache, cookies or credentials,
//: but there might be a situation where you want a persistent cache, 
//: and are happy with not persisting cookies or credentials.
//:
//: DONE: Create a URLCache object with `memoryCapacity` 512000 and `diskCapacity` 10000000, and
//: assign it to the configuration's `urlCache` property:
let cache = URLCache(memoryCapacity: 512000, diskCapacity: 10000000, diskPath: nil)
ephemeralConfiguration.urlCache = cache
// check the value of diskCapacity:
ephemeralConfiguration.urlCache?.diskCapacity
