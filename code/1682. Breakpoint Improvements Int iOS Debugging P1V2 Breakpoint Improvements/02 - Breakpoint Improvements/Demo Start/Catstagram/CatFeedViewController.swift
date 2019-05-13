/**
 * Copyright (c) 2018 Razeware LLC
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
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
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

class CatFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  private let kCatCellIdentifier = "CatCell"
  private let screensFromBottomToLoadMoreCats: CGFloat = 2.5
  
  private var photoFeed: PhotoFeedModel?
  private let tableView = UITableView(frame: CGRect.zero, style: .plain)
  private let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  init() {
    super.init(nibName: nil, bundle: nil)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }

  private func commonInit() {
    navigationItem.title = "Catstagram".localized(comment: "Application title")

    tableView.autoresizingMask = UIViewAutoresizing.flexibleWidth;
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    photoFeed = PhotoFeedModel(imageSize: imageSizeForScreenWidth())
    view.backgroundColor = .white
    
    refreshFeed()
    
    view.addSubview(tableView)
    tableView.allowsSelection = false
    tableView.separatorStyle = .none
    tableView.register(CatPhotoTableViewCell.classForCoder(), forCellReuseIdentifier: kCatCellIdentifier)
    
    tableView.addSubview(activityIndicatorView)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
    activityIndicatorView.center = CGPoint(x: view.bounds.size.width/2.0, y: view.bounds.size.height/2.0)
  }

  @IBAction func exitAddModal(segue: UIStoryboardSegue) {
    // Exit segue doesn't do anything other than dismiss the view
  }

  func refreshFeed() {
    guard let photoFeed = photoFeed else { return }
    
    activityIndicatorView.startAnimating()
    photoFeed.refreshFeed(with: 4) { (photoModels) in
      self.activityIndicatorView.stopAnimating()
      self.insert(newRows: photoModels)
      self.requestComments(forPhotos: photoModels)
      self.loadPage()
    }
  }
  
  func loadPage() {
    guard let photoFeed = photoFeed else { return }
    
    photoFeed.requestPage(with: 20) { (photoModels) in
      self.insert(newRows: photoModels)
      self.requestComments(forPhotos: photoModels)
    }
  }
  
  func insert(newRows photoModels: [PhotoModel]) {
    guard let photoFeed = photoFeed else { return }
    
    var indexPaths = [IndexPath]()
    
    let newTotal = photoFeed.numberOfItemsInFeed()
    for i in (newTotal - photoModels.count)...newTotal {
      indexPaths.append(IndexPath(row: i, section: 0))
    }
    tableView.insertRows(at: indexPaths, with: .none)
  }
  
  func requestComments(forPhotos photoModels: [PhotoModel]) {
    guard let photoFeed = photoFeed else { return }
    
    for photoModel in photoModels {
      photoModel.commentFeed.refreshFeed(with: { (commentModels) in
        let rowNum = photoFeed.index(of: photoModel)
        let indexPath = IndexPath(row: rowNum, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) as? CatPhotoTableViewCell {
          cell.loadComments(forPhoto: photoModel)

          if let firstCell = tableView.visibleCells.first,
            let visibleCellPath = tableView.indexPath(for: firstCell) {
            if indexPath.row < visibleCellPath.row {
              let width = view.bounds.size.width
              let commentViewHeight = CommentView.height(forCommentFeed: photoModel.commentFeed, withWidth:width)
              
              tableView.contentOffset = CGPoint(x: tableView.contentOffset.x, y: tableView.contentOffset.y + commentViewHeight)
            }
          }
        }
      })
    }
  }
  
  //MARK: Table View Delegate
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: kCatCellIdentifier, for: indexPath) as! CatPhotoTableViewCell
    
    cell.updateCell(with: photoFeed?.object(at: indexPath.row))
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if let photoModel = photoFeed?.object(at: indexPath.row) {
      return CatPhotoTableViewCell.height(forPhoto: photoModel, with: view.bounds.size.width)
    }
    return 0
  }
  
  //MARK: Table View DataSource
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return photoFeed?.numberOfItemsInFeed() ?? 0
  }
  
  //MARK: Scroll View Delegate
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let screensFromBottom = (scrollView.contentSize.height - scrollView.contentOffset.y)/UIScreen.main.bounds.size.height;
    
    if screensFromBottom == screensFromBottomToLoadMoreCats {
      loadPage()
    }
  }
  
  //MARK: Helpers
  func imageSizeForScreenWidth() -> CGSize {
    let screenRect = UIScreen.main.bounds
    let scale = UIScreen.main.scale
    
    return CGSize(width: screenRect.width * scale, height: screenRect.width * scale)
  }
  
  func resetAllData() {
    photoFeed?.clearFeed()
    tableView.reloadData()
    refreshFeed()
  }
}

