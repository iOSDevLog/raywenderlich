/// Copyright (c) 2017 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import CoreMotion
import CoreLocation

class CatFeedViewController: UIViewController, CLLocationManagerDelegate {
  private let kCatCellIdentifier = "CatCell"
  private let screensFromBottomToLoadMoreCats: CGFloat = 2.5
  
  private var photoFeed: PhotoFeedManager?
  private let tableView = UITableView(frame: CGRect.zero, style: .plain)
  private let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
  private let lastY = 0.0
  
  private let motionManager = CMMotionManager()
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  init() {
    super.init(nibName: nil, bundle: nil)
    navigationItem.title = "Catstagram"
    
    tableView.autoresizingMask = UIViewAutoresizing.flexibleWidth
    tableView.delegate = self
    tableView.dataSource = self
  }
    
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    photoFeed = PhotoFeedManager(imageSize: imageSizeForScreenWidth())
    view.backgroundColor = .white
    
    refreshFeed()
    
    view.addSubview(tableView)
    tableView.allowsSelection = false
    tableView.separatorStyle = .none
    tableView.register(CatPhotoTableViewCell.classForCoder(), forCellReuseIdentifier: kCatCellIdentifier)
    
    tableView.addSubview(activityIndicatorView)
    
    motionManager.startDeviceMotionUpdates(to: .main, withHandler:{ deviceMotion, error in
      guard let deviceMotion = deviceMotion else { return }
      
      let xRotationRate = CGFloat(deviceMotion.rotationRate.x)
      let yRotationRate = CGFloat(deviceMotion.rotationRate.y)
      let zRotationRate = CGFloat(deviceMotion.rotationRate.z)

      print("x \(xRotationRate) and y \(yRotationRate) and z \(zRotationRate)")
      
      if abs(yRotationRate) > (abs(xRotationRate) + abs(zRotationRate)) {
        for cell in self.tableView.visibleCells as! [CatPhotoTableViewCell] {
          cell.panImage(with: yRotationRate)
        }
      }
    })
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
    activityIndicatorView.center = CGPoint(x: view.bounds.size.width/2.0, y: view.bounds.size.height/2.0)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  //MARK: Helpers
  func imageSizeForScreenWidth() -> CGSize {
    let screenRect = UIScreen.main.bounds
    let scale = UIScreen.main.scale
    
    return CGSize(width: screenRect.width * scale, height: screenRect.width * scale)
  }
}

extension CatFeedViewController: UITableViewDataSource, UITableViewDelegate {
  //MARK: Table View Delegate
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: kCatCellIdentifier, for: indexPath) as! CatPhotoTableViewCell
    
    cell.updateCell(with: photoFeed?.object(at: indexPath.row))
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if let photo = photoFeed?.object(at: indexPath.row) {
      return CatPhotoTableViewCell.height(forPhoto: photo, with: view.bounds.size.width)
    }
    return 0
  }
  
  //MARK: Table View DataSource
  @available(iOS 2.0, *)
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return photoFeed?.numberOfItemsInFeed() ?? 0
  }
  
  //MARK: Scroll View Delegate
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let screensFromBottom = (scrollView.contentSize.height - scrollView.contentOffset.y)/UIScreen.main.bounds.size.height
    
    if screensFromBottom < screensFromBottomToLoadMoreCats {
      loadPage()
    }
  }
  
  //MARK: Table Helpers
  func refreshFeed() {
    guard let photoFeed = photoFeed else { return }
    
    activityIndicatorView.startAnimating()
    photoFeed.refreshFeed(with: 4) { (photos) in
      self.activityIndicatorView.stopAnimating()
      self.insert(newRows: photos)
      self.loadPage()
    }
  }
  
  func loadPage() {
    guard let photoFeed = photoFeed else { return }
    
    photoFeed.requestPage(with: 20) { (photos) in
      self.insert(newRows: photos)
    }
  }
  
  func insert(newRows photos: [Photo]) {
    guard let photoFeed = photoFeed else { return }
    
    var indexPaths = [IndexPath]()
    
    let newTotal = photoFeed.numberOfItemsInFeed()
    for i in (newTotal - photos.count)..<newTotal {
      indexPaths.append(IndexPath(row: i, section: 0))
    }
    tableView.insertRows(at: indexPaths, with: .none)
  }
}
