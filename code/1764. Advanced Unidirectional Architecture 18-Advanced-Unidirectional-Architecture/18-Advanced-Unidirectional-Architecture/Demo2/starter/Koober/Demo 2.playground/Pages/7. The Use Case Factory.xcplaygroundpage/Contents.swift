/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # The Use Case Factory
 The `HomeViewController` will need to be able to create a new `LoadPersistedStateUseCase` whenever it loads. Becuase the use case has external dependencies that the view controller should not need to know about, the view controller cannot simply instantiate a new use case by itself. Instead, the view controller can use the dependency container to ask for a new use case instance. The best way to accomplish this without giving the view controller access to the whole dependency container is to define a factory protocol. The view controller will then have a property for the use case factory to create new use cases.

 An alternative to using a protocol is to define the factory as a closure property on the view controller. Something like: `let useCaseFactory: () -> UseCase`. Then, the view controller would be instantiated with the closure.
 */
import Foundation

protocol LoadPersistedStateUseCaseFactory {
  func makeLoadPersistedStateUseCase() -> UseCase
}
/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
