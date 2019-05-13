/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import KooberKit
import RxSwift

public class DropoffLocationPickerContentViewController: NiblessViewController {
  // MARK: State
  let pickupLocation: Location
  var currentSearchUseCase: CancelableUseCase?
  let stateObservable: Observable<DropoffLocationPickerState>
  let disposeBag = DisposeBag()
  // MARK: Factories
  let useCaseFactory: DropoffLocationPickerUseCaseFactory
  // MARK: Root View
  let rootView = DropoffLocationPickerContentRootView()

  init(pickupLocation: Location,
       useCaseFactory: DropoffLocationPickerUseCaseFactory,
       stateObservable: Observable<DropoffLocationPickerState>) {
    self.pickupLocation = pickupLocation
    self.useCaseFactory = useCaseFactory
    self.stateObservable = stateObservable
    super.init()
    self.navigationItem.title = "Where To?"
    self.navigationItem.largeTitleDisplayMode = .automatic
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                            target: self,
                                                            action: #selector(DropoffLocationPickerContentViewController.exit))
  }

  public override func loadView() {
    rootView.ixResponder = self
    subscribe(to: stateObservable)

    view = rootView

    setUpSearchController()
  }

  public override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    currentSearchUseCase?.cancel()
    currentSearchUseCase = {
      let useCase = useCaseFactory.makeSearchLocationsUseCase(query: "",
                                                              pickupLocation: pickupLocation)
      useCase.start()
      return useCase
    }()
  }

  func subscribe(to stateObservable: Observable<DropoffLocationPickerState>) {
    stateObservable.subscribe(onNext: { [weak self] state in
      self?.rootView.update(state: state.searchResults)
    }).disposed(by: disposeBag)
  }

  @objc
  func exit() {
    useCaseFactory.makeCancelDropoffLocationSelectionUseCase().start()
  }

  func setUpSearchController() {
    let searchController = ObservableUISearchController(searchResultsController: nil)
    searchController.delegate = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.observable
      .debounce(0.9, scheduler: MainScheduler.instance)
      .subscribe(onNext: { [weak self] query in
        guard let strongSelf = self else { return }
        strongSelf.on(next: query)
      }).disposed(by: self.disposeBag)

    navigationItem.searchController = searchController
    definesPresentationContext = true
  }

  func on(next query: String) {
    currentSearchUseCase?.cancel()
    currentSearchUseCase = {
      let useCase = useCaseFactory.makeSearchLocationsUseCase(query: query,
                                                              pickupLocation: pickupLocation)
      useCase.start()
      return useCase
    }()
  }
}

extension DropoffLocationPickerContentViewController: DropoffPickerIxResponder {
  func didSelect(dropoffLocation: NamedLocation) {
    useCaseFactory.makeSelectDropoffLocationUseCase(dropoffLocation: dropoffLocation.location).start()
  }
}

// TODO: Fix this animation hack.
extension DropoffLocationPickerContentViewController: UISearchControllerDelegate {
  public func willPresentSearchController(_ searchController: UISearchController) {
    DispatchQueue.main.async {
      self.rootView.tableView.contentInset = UIEdgeInsets(top: 98, left: 0, bottom: 0, right: 0)
    }
    DispatchQueue.main.async {
      self.transitionCoordinator?.animate(alongsideTransition: { context in
        self.rootView.tableView.contentInset = .zero
      }, completion: nil)
    }
  }
}

protocol DropoffLocationPickerUseCaseFactory {
  func makeCancelDropoffLocationSelectionUseCase() -> UseCase
  func makeSearchLocationsUseCase(query: String, pickupLocation: Location) -> CancelableUseCase
  func makeSelectDropoffLocationUseCase(dropoffLocation: Location) -> UseCase
}
