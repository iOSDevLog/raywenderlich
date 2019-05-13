import Foundation


public final class PseudoConnection: NSObject {
  public enum State {
    case disconnected
    case connecting
    case connected
  }
  private var state: State = .disconnected {
    didSet {
      stateChangeCallback(state)
    }
  }
  
  public typealias StateChange = ((State) -> ())
  private let stateChangeCallback: StateChange
  private let connectionTime: Double
  
  public init(connectionTime: TimeInterval = 1, stateChangeCallback: @escaping StateChange) {
    self.stateChangeCallback = stateChangeCallback
    self.connectionTime = connectionTime
  }
  
  public func connect() {
    state = .connecting
    Timer.scheduledTimer(withTimeInterval: connectionTime, repeats: false) { [weak self] _ in
      self?.state = .connected
    }
  }
  
  public func disconnect() {
    state = .disconnected
  }
  
  @objc public func toggle() {
    switch state {
    case .disconnected:
      connect()
    default:
      disconnect()
    }
  }
}
