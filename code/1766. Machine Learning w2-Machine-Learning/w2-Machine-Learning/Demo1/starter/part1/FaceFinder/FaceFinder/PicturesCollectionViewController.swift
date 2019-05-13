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

import UIKit

class PicturesCollectionViewController: UICollectionViewController {

  var images: [UIImage] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadHardCodedPictures()
    loadSavedPictures()
  }
  
  private func loadHardCodedPictures() {
    //This is for development and debugging purposes.
    //Just add any JPG image to the resource bundle and it will be loaded in the collection view, to start
    let imagePaths = Bundle.main.paths(forResourcesOfType: "jpg", inDirectory: nil)
    imagePaths
      .compactMap { UIImage(named: $0)}
      .forEach { images.append($0)}
  }
  
  private func loadSavedPictures() {
    let documentDirectoryURL =  try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    let imageUrls = try! FileManager.default.contentsOfDirectory(at: documentDirectoryURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles).filter { $0.pathExtension == "jpg"}
    imageUrls.forEach { url in
      if let data = try? Data(contentsOf: url),
        let image = UIImage(data: data) {
        images.append(image)
      }
    }
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == "imageDetail" else { return }
    let cell = sender as! PictureCollectionViewCell
    let indexPath = collectionView!.indexPath(for: cell)!
    let image = images[indexPath.row]
    let imageController = segue.destination as! ImageViewController
    imageController.image = image
  }

  // MARK: UICollectionViewDataSource

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! PictureCollectionViewCell
    cell.imageView.image = images[indexPath.row]

    return cell
  }
}

extension PicturesCollectionViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  @IBAction func addImage(_ sender: Any) {
    let picker = UIImagePickerController()
    picker.delegate = self
    picker.sourceType = .savedPhotosAlbum
    present(picker, animated: true)
  }

  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    picker.dismiss(animated: true)

    guard let uiImage = info[UIImagePickerControllerOriginalImage] as? UIImage
      else { fatalError("no image from image picker") }
    images.append(uiImage)
    collectionView?.insertItems(at: [IndexPath(row: images.count - 1, section: 0)])
    saveImage(image: uiImage)
  }
  
  func saveImage(image: UIImage) {
    let data = UIImageJPEGRepresentation(image, 1.0)!
    let documentDirectoryURL =  try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    let url = documentDirectoryURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("jpg")
    try! data.write(to: url)
  }
}
