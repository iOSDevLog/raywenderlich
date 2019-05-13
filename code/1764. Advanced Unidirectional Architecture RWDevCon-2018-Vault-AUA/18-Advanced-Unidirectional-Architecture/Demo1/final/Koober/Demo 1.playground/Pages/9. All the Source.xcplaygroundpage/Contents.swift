/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # All the Source
 This page contains all the source so that you can explore the entire example inside the playground.
 */

import Foundation
import UIKit
import RxSwift
import ReSwift

import PlaygroundSupport

let dependencyContainer: DependencyProvider = DependencyContainer()
let homeViewController: HomeViewController =
  HomeViewController(settingsViewControllerFactory: dependencyContainer)
PlaygroundPage.current.liveView = homeViewController

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

  init(userProfile: UserProfile) {
    self.userProfile = userProfile
  }

  static func ==(lhs: SettingsViewState, rhs: SettingsViewState) -> Bool {
    return lhs.userProfile == rhs.userProfile
  }
}

//: ## UserProfile
struct UserProfile: StateType, Equatable {
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

//: ## SettingsViewControllerFactory
protocol SettingsViewControllerFactory {
  func makeSettingsViewController() -> UIViewController
}

//: ## DependencyProvider
protocol DependencyProvider: SettingsViewControllerFactory {
  var reduxStore: Store<AppState> { get }

  func makeSettingsViewController() -> UIViewController
  func makeSettingsViewStateObservable() -> Observable<SettingsViewState>
}

//: ## Initial State
extension UserProfile {
  static func makeEmpty() -> UserProfile {
    return UserProfile(name: "",
                       mobileNumber: "",
                       email: "",
                       clawed: true)
  }
}

//: ## Reducer
func reduce(action: Action, state: AppState?) -> AppState {
  let appState = state ?? AppState(UserProfile.makeEmpty())
  return appState
}

//: ## DependencyContainer
class DependencyContainer: DependencyProvider {
  let reduxStore = Store<AppState>(reducer: reduce,
                                   state: nil)

  func makeSettingsViewController() -> UIViewController {
    let observable = makeSettingsViewStateObservable()
    return SettingsViewController(stateObservable: observable)
  }

  func makeSettingsViewStateObservable() -> Observable<SettingsViewState> {
    let observable =
      reduxStore
        .makeObservable { appState in
          return appState.settingsViewState
        }.distinctUntilChanged()
    return observable
  }
}

//: ## HomeViewController
class HomeViewController: NiblessViewController {
  let settingsViewControllerFactory: SettingsViewControllerFactory

  init(settingsViewControllerFactory: SettingsViewControllerFactory) {
    self.settingsViewControllerFactory = settingsViewControllerFactory
    super.init()
  }

  override func loadView() {
    self.view = HomeRootView(ixResponder: self)
  }
}

extension HomeViewController: HomeIXResponder {
  public func goToSettings() {
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

  init(ixResponder: HomeIXResponder,
              frame: CGRect = .zero) {
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
    goToSettingsButton
      .addTarget(self,
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
class SettingsViewController: NiblessViewController {
  let stateObservable: Observable<SettingsViewState>
  let disposeBag = DisposeBag()

  var rootView: SettingsRootView {
    return view as! SettingsRootView
  }

  init(stateObservable: Observable<SettingsViewState>) {
    self.stateObservable = stateObservable
    super.init()
  }

  override func loadView() {
    view = SettingsRootView()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    subscribe(to: stateObservable)
  }

  func subscribe(to observable: Observable<SettingsViewState>) {
    observable.subscribe(
      onNext: { [weak self] viewModel in
        self?.updateView(with: viewModel)
      }, onError: { [weak self] error in
        self?.handle(stateError: error)
    }).disposed(by: disposeBag)
  }

  func updateView(with viewState: SettingsViewState) {
    rootView.update(with: viewState)
  }

  func handle(stateError error: Error) {
    print("Handle error by for example displaying an error message or screen.")
  }
}

//: ## SettingsRootView
class SettingsRootView: UIView {
  private let tableView: SettingsTableView
  private let navBar = UINavigationBar()

  override init(frame: CGRect = .zero) {
    self.tableView = SettingsTableView(style: .grouped)
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
  var viewModel: SettingsViewState? {
    didSet { reloadState() }
  }

  override init(frame: CGRect = .zero,
                style: UITableViewStyle = .grouped) {
    super.init(frame: frame, style: style)
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

  private func reloadState() {
    reloadData()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) is not supported by this class.")
  }
}

extension SettingsTableView: UITableViewDataSource, UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    if let _ = viewModel {
      return 1
    } else {
      return 0
    }
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.section {
    case 0:
      return UserProfileSectionStrategy().rowHeight
    default:
      fatalError()
    }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return UserProfileSectionStrategy().numberOfRows
    default:
      fatalError()
    }
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 0:
      return UserProfileSectionStrategy().headerTitle
    default:
      fatalError()
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      return UserProfileSectionStrategy().dequeueCell(from: tableView,
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

  func dequeueCell(from tableView: UITableView,
                   with viewModel: SettingsViewState) -> UITableViewCell
}

class UserProfileSectionStrategy: SettingsTableViewStrategy {
  let rowHeight: CGFloat = 90
  let numberOfRows = 1
  let headerTitle: String? = "User Profile"

  func dequeueCell(from tableView: UITableView,
                   with viewModel: SettingsViewState) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CellID.userProfile.id)! as! AccountTableViewCell
    cell.nameLabel.text = viewModel.userProfile.name
    cell.phoneNumberLabel.text = viewModel.userProfile.mobileNumber
    cell.emailLabel.text = viewModel.userProfile.email
    cell.selectionStyle = .none
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
/*:
 ****
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
