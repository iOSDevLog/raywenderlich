/// Copyright (c) 2018 Razeware LLC
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

import Foundation
import UIKit
import SceneKit


class CatalogViewController: UIViewController {

  @IBOutlet var furnitureCollectionView: UICollectionView!
  
  var furnitureSettings: FurnitureSettings!

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    let customTabBarController = self.tabBarController as! CustomTabBarController
    furnitureSettings = customTabBarController.furnitureSettings

    furnitureCollectionView.dataSource = self
    furnitureCollectionView.delegate = self
  }

}

extension CatalogViewController : UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    furnitureSettings.furniture = indexPath.row
    tabBarController?.selectedIndex = 0
  }
  
}

extension CatalogViewController : UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return furnitureSettings.furnitureNames.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = furnitureCollectionView.dequeueReusableCell(withReuseIdentifier: "furnitureCollectionViewCell", for: indexPath)
    print("indexPath.row: \(indexPath.row)")
    
    let furniturePic = cell.viewWithTag(1000) as! UIImageView
    furniturePic.image = furnitureSettings.furniturePictures[indexPath.row]
    
    let nameLabel = cell.viewWithTag(1001) as! UILabel
    nameLabel.text = furnitureSettings.furnitureNames[indexPath.row]
    
    let descriptionLabel = cell.viewWithTag(1002) as! UILabel
    descriptionLabel.text = furnitureSettings.furnitureDescriptions[indexPath.row]
    
    return cell
  }
  
}
