/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # All the Source
 This page contains all the source so that you can explore the entire example inside the playground.
 */
import Foundation
import UIKit
import PromiseKit
import RxSwift
import ReSwift
//: ## AppState
struct AppState: StateType, Equatable {
  var settingsViewState: SettingsViewState

  init(_ userProfile: UserProfile) {
    self.settingsViewState = SettingsViewState(userProfile: userProfile)
  }

  static func ==(lhs: AppState, rhs: AppState) -> Bool {
    return lhs.settingsViewState == rhs.settingsViewState
  }
}

//: ## SettingsViewState
struct SettingsViewState: Equatable {
  var userProfile: UserProfile
  var loadingUserProfile: Bool

  init(userProfile: UserProfile) {
    self.userProfile = userProfile
    self.loadingUserProfile = false
  }

  static func ==(lhs: SettingsViewState, rhs: SettingsViewState) -> Bool {
    return lhs.userProfile == rhs.userProfile &&
      lhs.loadingUserProfile == rhs.loadingUserProfile
  }
}

//: ## UserProfile
struct UserProfile: StateType, Equatable, Codable {
  var name: String
  var mobileNumber: String
  var email: String
  var clawed: Bool

  init(name: String,
       mobileNumber: String,
       email: String,
       clawed: Bool) {
    self.name = name
    self.mobileNumber = mobileNumber
    self.email = email
    self.clawed = clawed
  }

  static func ==(lhs: UserProfile, rhs: UserProfile) -> Bool {
    return lhs.name == rhs.name &&
      lhs.mobileNumber == rhs.mobileNumber &&
      lhs.email == rhs.email &&
      lhs.clawed == rhs.clawed
  }
}

//: ## Use Case
protocol UseCase {
  func start()
}

//: ## LoadPersistedStateUseCase
class LoadPersistedStateUseCase: UseCase {
  let userStore: PersistentUserStore
  let reduxStore: Store<AppState>
  let statePersister: StatePersister

  init(userStore: PersistentUserStore,
       reduxStore: Store<AppState>,
       statePersister: StatePersister) {
    self.userStore = userStore
    self.reduxStore = reduxStore
    self.statePersister = statePersister
  }

  func start() {
    userStore.readUserProfile()
      .then(execute: dispatchLoadedAction(userProfile:))
      .then(execute: startPersistingStateChanges)
      .catch { error in }
  }

  func dispatchLoadedAction(userProfile: UserProfile) {
    let appState = AppState(userProfile)
    let action = LoadedPersistedState(appState: appState)
    reduxStore.dispatch(action)
  }

  func startPersistingStateChanges() {
    statePersister.startPersistingStateChanges(to: userStore)
  }
}

//: ## LoadPersistedStateUseCaseFactory
protocol LoadPersistedStateUseCaseFactory {
  func makeLoadPersistedStateUseCase() -> UseCase
}

//: ## LoadUserProfileUseCase
class LoadUserProfileUseCase: UseCase {
  let remoteAPI: UserRemoteAPI
  let reduxStore: Store<AppState>

  init(remoteAPI: UserRemoteAPI,
       reduxStore: Store<AppState>) {
    self.remoteAPI = remoteAPI
    self.reduxStore = reduxStore
  }

  func start() {
    dispatchLoadingAction()
      .then(execute: remoteAPI.getUserProfile)
      .then(execute: dispatchLoadedAction(userProfile:))
      .catch { error in }
  }

  func dispatchLoadingAction() -> Promise<Void> {
    let action = LoadingUserProfile()
    reduxStore.dispatch(action)
    return Promise()
  }

  func dispatchLoadedAction(userProfile: UserProfile) {
    let action = LoadedUserProfile(userProfile: userProfile)
    reduxStore.dispatch(action)
  }
}

//: ## LoadUserProfileUseCaseFactory
protocol LoadUserProfileUseCaseFactory {
  func makeLoadUserProfileUseCase() -> UseCase
}

//: ## UpdateClawedUseCase
class UpdateClawedUseCase: UseCase {
  // MARK: Input
  let clawed: Bool
  // MARK: Dependencies
  let remoteAPI: UserRemoteAPI
  let reduxStore: Store<AppState>

  init(clawed: Bool,
       remoteAPI: UserRemoteAPI,
       reduxStore: Store<AppState>) {
    self.clawed = clawed
    self.remoteAPI = remoteAPI
    self.reduxStore = reduxStore
  }

  func start() {
    remoteAPI.putUserProfile(clawed: clawed)
      .then(execute: dispatchUpdateAction(userProfile:))
      .catch { error in }
  }

  func dispatchUpdateAction(userProfile: UserProfile) {
    let action = UpdateClawed(userProfile: userProfile)
    self.reduxStore.dispatch(action)
  }
}

//: ## UpdateClawedUseCaseFactory
protocol UpdateClawedUseCaseFactory {
  func makeUpdateClawedUseCase(clawed: Bool) -> UseCase
}

//: ## Redux Reducer
func reduce(action: Action, state: AppState?) -> AppState {
  var appState = state ?? AppState(UserProfile.makeEmpty())

  switch action {
  case let action as LoadedPersistedState:
    appState = action.appState
  case _ as LoadingUserProfile:
    appState.settingsViewState.loadingUserProfile = true
  case let action as LoadedUserProfile:
    appState.settingsViewState.userProfile = action.userProfile
    appState.settingsViewState.loadingUserProfile = false
  case let action as UpdateClawed:
    appState.settingsViewState.userProfile = action.userProfile
  default:
    break
  }

  return appState
}

//: ## Redux Actions
struct LoadedPersistedState: Action {
  let appState: AppState
}

struct LoadingUserProfile: Action {}

struct LoadedUserProfile: Action {
  let userProfile: UserProfile
}

struct UpdateClawed: Action {
  let userProfile: UserProfile
}

//: ## UserRemoteAPI
protocol UserRemoteAPI {
  func getUserProfile() -> Promise<UserProfile>
  func putUserProfile(clawed: Bool) -> Promise<UserProfile>
}

//: ## KooberUserRemoteAPI
var remoteUserSession = UserProfile(name: "Johnny Fox Net",
                                    mobileNumber: "+1 (512) 874 9938",
                                    email: "johnny@aple.com",
                                    clawed: true)

class KooberUserRemoteAPI: UserRemoteAPI {
  func getUserProfile() -> Promise<UserProfile> {
    return Promise { fulfill, reject in
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
        fulfill(remoteUserSession)
      }
    }
  }

  func putUserProfile(clawed: Bool) -> Promise<UserProfile> { // New
    return Promise { fulfill, reject in
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
        remoteUserSession.clawed = clawed
        fulfill(remoteUserSession)
      }
    }
  }
}

//: ## PersistentUserStore
protocol PersistentUserStore {
  func readUserProfile() -> Promise<UserProfile>
  func save(userProfile: UserProfile) -> Promise<UserProfile>
}

//: ## FakePersistentUserStore
class FakePersistentUserStore: PersistentUserStore {
  var userProfile: UserProfile

  init() {
    // Simulate initial read from disk.
    self.userProfile = UserProfile.make()
  }

  func readUserProfile() -> Promise<UserProfile> {
    return Promise { fulfill, reject in
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
        fulfill(self.userProfile)
      }
    }
  }

  func save(userProfile: UserProfile) -> Promise<UserProfile> {
    return Promise { fulfill, reject in
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
        self.userProfile = userProfile
        fulfill(())
      }
      }.then(execute: readUserProfile)
  }
}

//: ## StatePersister
protocol StatePersister {
  func startPersistingStateChanges(to userStore: PersistentUserStore)
}

//: ## ReduxStatePersister
class ReduxStatePersister: StatePersister {
  let userProfileObservable: Observable<UserProfile>
  let disposeBag = DisposeBag()

  init(reduxStore: Store<AppState>) {
    self.userProfileObservable = reduxStore
      .makeObservable(getUserProfile)
      .distinctUntilChanged()
      .skip(1)
  }

  func startPersistingStateChanges(to userStore: PersistentUserStore) {
    userProfileObservable.subscribe(onNext: { [weak self] userProfile in
      self?.persist(userProfile, to: userStore)
    }).disposed(by: disposeBag)
  }

  func persist(_ userProfile: UserProfile, to userStore: PersistentUserStore) {
    userStore
      .save(userProfile: userProfile)
      .catch { error in fatalError("Handle Error") }
  }
}

private func getUserProfile(appState: AppState) -> UserProfile {
  return appState.settingsViewState.userProfile
}

//: ## DependencyProvider
protocol DependencyProvider: SettingsViewControllerFactory,
                             LoadPersistedStateUseCaseFactory,
                             LoadUserProfileUseCaseFactory,
                             UpdateClawedUseCaseFactory { // New
  var reduxStore: Store<AppState> { get }
  var userStore: PersistentUserStore { get }
  var statePersister: StatePersister { get }

  func makeSettingsViewController() -> UIViewController

  func makeSettingsViewStateObservable() -> Observable<SettingsViewState>
  func makeLoadPersistedStateUseCase () -> UseCase
  func makeLoadUserProfileUseCase() -> UseCase
  func makeUpdateClawedUseCase(clawed: Bool) -> UseCase // New

  func makeUserRemoteAPI() -> UserRemoteAPI
}

//: ## Initial State
extension UserProfile {
  static func make() -> UserProfile {
    return UserProfile(name: "Johnny Fox",
                       mobileNumber: "+1 (512) 874 9938",
                       email: "johnny@aple.com",
                       clawed: true)
  }

  static func makeEmpty() -> UserProfile {
    return UserProfile(name: "",
                       mobileNumber: "",
                       email: "",
                       clawed: true)
  }
}

//: ## SettingsViewControllerFactory
protocol SettingsViewControllerFactory {
  func makeSettingsViewController() -> UIViewController
}

//: ## DependencyContainer
class DependencyContainer: DependencyProvider {
  let reduxStore: Store<AppState> = Store(reducer: reduce, state: nil)
  let userStore: PersistentUserStore = FakePersistentUserStore()
  let statePersister: StatePersister

  init() {
    statePersister = ReduxStatePersister(reduxStore: reduxStore)
  }

  func makeSettingsViewController() -> UIViewController {
    let observable = makeSettingsViewStateObservable()
    return SettingsViewController(stateObservable: observable,
                                  loadUserProfileUseCaseFactory: self,
                                  updateClawedUseCaseFactory: self) // New
  }

  func makeSettingsViewStateObservable() -> Observable<SettingsViewState> {
    let observable =
      reduxStore
        .makeObservable { appState in
          return appState.settingsViewState
        }.distinctUntilChanged()
    return observable
  }

  func makeLoadPersistedStateUseCase() -> UseCase {
    return LoadPersistedStateUseCase(userStore: userStore,
                                     reduxStore: reduxStore,
                                     statePersister: statePersister)
  }

  func makeLoadUserProfileUseCase() -> UseCase {
    let remoteAPI = makeUserRemoteAPI()
    return LoadUserProfileUseCase(remoteAPI: remoteAPI,
                                  reduxStore: reduxStore)
  }

  func makeUpdateClawedUseCase(clawed: Bool) -> UseCase { // New
    let userRemoteAPI = makeUserRemoteAPI()
    return UpdateClawedUseCase(clawed: clawed,
                               remoteAPI: userRemoteAPI,
                               reduxStore: reduxStore)
  }

  func makeUserRemoteAPI() -> UserRemoteAPI {
    return KooberUserRemoteAPI()
  }
}

//: ## HomeViewController
class HomeViewController: NiblessViewController {
  let settingsViewControllerFactory: SettingsViewControllerFactory
  let loadPersistedStateUseCaseFactory: LoadPersistedStateUseCaseFactory

  init(settingsViewControllerFactory: SettingsViewControllerFactory,
       loadPersistedStateUseCaseFactory: LoadPersistedStateUseCaseFactory) {
    self.settingsViewControllerFactory = settingsViewControllerFactory
    self.loadPersistedStateUseCaseFactory = loadPersistedStateUseCaseFactory
    super.init()
  }

  override func loadView() {
    self.view = HomeRootView(ixResponder: self)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    restorePersistedState()
  }

  func restorePersistedState() {
    let useCase = loadPersistedStateUseCaseFactory.makeLoadPersistedStateUseCase()
    useCase.start()
  }
}

extension HomeViewController: HomeIXResponder {
  func goToSettings() {
    let settingsViewController = settingsViewControllerFactory.makeSettingsViewController()
    present(settingsViewController, animated: true)
  }
}

//: ## HomeIXResponder
protocol HomeIXResponder: class {
  func goToSettings()
}

//: ## HomeRootView
class HomeRootView: UIView {
  unowned var ixResponder: HomeIXResponder
  let goToSettingsButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Go To Settings", for: .normal)
    button.frame = CGRect(x: 80, y: 200, width: 200, height: 20)
    return button
  }()

  init(ixResponder: HomeIXResponder, frame: CGRect = .zero) {
    self.ixResponder = ixResponder

    super.init(frame: frame)

    build()
    style()
    wireControls()
  }

  private func build() {
    addSubview(goToSettingsButton)
  }

  private func style() {
    backgroundColor = .white
  }

  private func wireControls() {
    goToSettingsButton.addTarget(self,
                                 action: #selector(handleButtonPress),
                                 for: .touchUpInside)
  }

  @objc
  private func handleButtonPress() {
    ixResponder.goToSettings()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) is not supported by this class.")
  }
}

//: ## SettingsViewController
public class SettingsViewController: NiblessViewController {
  let stateObservable: Observable<SettingsViewState>
  let disposeBag = DisposeBag()
  let loadUserProfileUseCaseFactory: LoadUserProfileUseCaseFactory
  let updateClawedUseCaseFactory: UpdateClawedUseCaseFactory // New

  var rootView: SettingsRootView {
    return view as! SettingsRootView
  }

  init(stateObservable: Observable<SettingsViewState>,
       loadUserProfileUseCaseFactory: LoadUserProfileUseCaseFactory,
       updateClawedUseCaseFactory: UpdateClawedUseCaseFactory) { // New
    self.stateObservable = stateObservable
    self.loadUserProfileUseCaseFactory = loadUserProfileUseCaseFactory
    self.updateClawedUseCaseFactory = updateClawedUseCaseFactory // New
    super.init()
  }

  public override func loadView() {
    view = SettingsRootView(ixResponder: self)
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    subscribe(to: stateObservable)
  }

  func subscribe(to observable: Observable<SettingsViewState>) {
    observable.subscribe(
      onNext: { [weak self] viewModel in
        self?.updateView(withViewModel: viewModel)
      }, onError: { [weak self] error in
        self?.handle(stateError: error)
    }).disposed(by: disposeBag)
  }

  func updateView(withViewModel viewModel: SettingsViewState) {
    rootView.update(with: viewModel)
  }

  func handle(stateError error: Error) {
    print("Handle error by for example displaying an error message or screen.")
  }
}

extension SettingsViewController: SettingsIXResponder {
  public func loadUserProfile() {
    let useCase = loadUserProfileUseCaseFactory.makeLoadUserProfileUseCase()
    useCase.start()
  }

  public func update(clawed: Bool) { // New
    let useCase = updateClawedUseCaseFactory.makeUpdateClawedUseCase(clawed: clawed)
    useCase.start()
  }
}


//: ## SettingsIXResponder
@objc
protocol SettingsIXResponder: class {
  func loadUserProfile()
  func update(clawed: Bool) // New
}

//: ## SettingsRootView
class SettingsRootView: UIView {
  private let tableView: SettingsTableView
  private let navBar = UINavigationBar()
  private unowned let ixResponder: SettingsIXResponder

  init(frame: CGRect = .zero,
       ixResponder: SettingsIXResponder) {
    self.ixResponder = ixResponder
    self.tableView = SettingsTableView(ixResponder: ixResponder)
    super.init(frame: frame)

    build()
    configureNav()
  }

  private func build() {
    addSubview(tableView)
    addSubview(navBar)
  }

  private func configureNav() {
    navBar.prefersLargeTitles = true
    let item = UINavigationItem(title: "Settings")
    navBar.setItems([item], animated: false)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    layoutNavBar()
    layoutTableView()
  }

  private func layoutNavBar() {
    navBar.sizeToFit()
  }

  private func layoutTableView() {
    tableView.frame = bounds
    tableView.contentInset = UIEdgeInsets(top: navBar.frame.size.height,
                                          left: 0, bottom: 0, right: 0)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) is not supported by this class.")
  }

  func update(with viewModel: SettingsViewState) {
    tableView.viewModel = viewModel
  }
}

//: ## SettingsTableView
class SettingsTableView: UITableView {
  private unowned let ixResponder: SettingsIXResponder
  var viewModel: SettingsViewState? {
    didSet { reloadState() }
  }

  init(frame: CGRect = .zero,
       style: UITableViewStyle = .grouped,
       ixResponder: SettingsIXResponder) {
    self.ixResponder = ixResponder

    super.init(frame: frame, style: style)

    installRefreshControl()
    configureTableView()
  }

  private func configureTableView() {
    self.dataSource = self
    self.delegate = self

    register(AccountTableViewCell.self,
             forCellReuseIdentifier: CellID.userProfile.id)
    register(UITableViewCell.self,
             forCellReuseIdentifier: CellID.theSwitch.id)
  }

  private func installRefreshControl() {
    refreshControl = UIRefreshControl()
    refreshControl?.addTarget(ixResponder,
                              action: #selector(SettingsIXResponder.loadUserProfile),
                              for: .valueChanged)
  }

  private func reloadState() {
    reloadData()
    reloadRefreshControlState()
  }

  private func reloadRefreshControlState() {
    if viewModel?.loadingUserProfile == false {
      refreshControl?.endRefreshing()
    }
  }

  @objc
  func onValueChanged(control: UISwitch) { // New
    let activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    activity.startAnimating()
    let cell = cellForRow(at: IndexPath(item: 0, section: 1))!
    cell.accessoryView = activity

    ixResponder.update(clawed: control.isOn)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) is not supported by this class.")
  }
}

extension SettingsTableView: UITableViewDataSource, UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    if let _ = viewModel {
      return 2
    } else {
      return 0
    }
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.section {
    case 0:
      return UserProfileSectionStrategy().rowHeight
    case 1:
      return ClawedSectionStrategy().rowHeight
    default:
      fatalError()
    }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return UserProfileSectionStrategy().numberOfRows
    case 1:
      return ClawedSectionStrategy().numberOfRows
    default:
      fatalError()
    }
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 0:
      return UserProfileSectionStrategy().headerTitle
    case 1:
      return ClawedSectionStrategy().headerTitle
    default:
      fatalError()
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    assert(tableView === self)
    switch indexPath.section {
    case 0:
      return UserProfileSectionStrategy().dequeueCell(from: self,
                                                      with: viewModel!)
    case 1:
      return ClawedSectionStrategy().dequeueCell(from: self,
                                                 with: viewModel!)
    default:
      fatalError()
    }
  }
}

protocol SettingsTableViewStrategy {
  var rowHeight: CGFloat { get }
  var numberOfRows: Int { get }
  var headerTitle: String? { get }

  func dequeueCell(from tableView: SettingsTableView,
                   with viewModel: SettingsViewState) -> UITableViewCell
}

class UserProfileSectionStrategy: SettingsTableViewStrategy {
  let rowHeight: CGFloat = 90
  let numberOfRows = 1
  let headerTitle: String? = "User Profile"

  func dequeueCell(from tableView: SettingsTableView,
                   with viewModel: SettingsViewState) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CellID.userProfile.id)! as! AccountTableViewCell
    cell.nameLabel.text = viewModel.userProfile.name
    cell.phoneNumberLabel.text = viewModel.userProfile.mobileNumber
    cell.emailLabel.text = viewModel.userProfile.email
    cell.selectionStyle = .none
    return cell
  }
}

class ClawedSectionStrategy: SettingsTableViewStrategy {
  let rowHeight: CGFloat = 44
  let numberOfRows = 1
  let headerTitle: String? = nil

  func dequeueCell(from tableView: SettingsTableView,
                   with viewModel: SettingsViewState) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CellID.theSwitch.id)!
    cell.textLabel?.text = "Clawed"
    cell.selectionStyle = .none

    let theSwitch = UISwitch()
    theSwitch.isOn = viewModel.userProfile.clawed
    theSwitch.addTarget(tableView,
                        action: #selector(SettingsTableView.onValueChanged(control:)),
                        for: .valueChanged) // New

    cell.accessoryView = theSwitch
    return cell
  }
}

private enum CellID: String {
  case userProfile
  case theSwitch

  var id: String {
    return rawValue
  }
}

//: ## AccountTableViewCell
class AccountTableViewCell: UITableViewCell {
  private lazy var contentStackView: UIStackView = {
    var stackView = UIStackView(arrangedSubviews: [labelStackView])
    stackView.axis = .horizontal
    return stackView
  }()

  private lazy var labelStackView: UIStackView = {
    var stackView = UIStackView(arrangedSubviews: [nameLabel,
                                                   phoneNumberLabel,
                                                   emailLabel])
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    return stackView
  }()

  let nameLabel: UILabel = {
    var label = UILabel()
    label.text = "John Doe"
    return label
  }()

  let phoneNumberLabel: UILabel = {
    var label = UILabel()
    label.text = "(000) 000-0000"
    return label
  }()

  let emailLabel: UILabel = {
    var label = UILabel()
    label.text = "address@email.com"
    return label
  }()

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(contentStackView)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    contentStackView.frame = contentView.bounds
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) is not supported by this class.")
  }
}

//: ## Playground
import PlaygroundSupport

let dependencyContainer: DependencyProvider = DependencyContainer()
let homeViewController: HomeViewController =
  HomeViewController(settingsViewControllerFactory: dependencyContainer,
                     loadPersistedStateUseCaseFactory: dependencyContainer)

PlaygroundPage.current.liveView = homeViewController
/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
