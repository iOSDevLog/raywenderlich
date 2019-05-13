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

class CatPhotoTableViewCell: UITableViewCell {
  let userImageHeight: CGFloat = 30
  
  var photo: Photo? = nil
  
  var userAvatarImageView = RoundedImageView()
  var photoImageView = AsyncImageView()
  
  var userNameLabel = UILabel()
  var photoTimeIntervalSincePostLabel = UILabel()
  var photoLikesLabel = UILabel()
  var likersView = LikersView()
  
  var photoDescriptionLabel = UILabel()
  
  var userNameYPositionWithoutPhotoLocation = NSLayoutConstraint()
  var photoLocationYPosition = NSLayoutConstraint()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
  }
  
  //MARK: Motion
  func panImage(with yRotation: CGFloat) {
    let lowerLimit = bounds.size.width/2 - 10
    let upperLimit = bounds.size.width/2 + 10
    let rotationMult: CGFloat = 5.0
    
    var possibleXOffset = photoImageView.center.x + ((yRotation * -1) * rotationMult * 1)
    var possibleAvatarXOffset = userAvatarImageView.center.x + ((yRotation * -1) * rotationMult * 1)
    
    possibleXOffset = (possibleXOffset < lowerLimit) ? lowerLimit : possibleXOffset
    possibleXOffset = (possibleXOffset > upperLimit) ? upperLimit : possibleXOffset
    
    let avatarLowerLimit = userAvatarImageView.bounds.size.width/2.0
    let avatarUpperLimit = userAvatarImageView.bounds.size.width/2.0 + 10
    
    possibleAvatarXOffset = min(avatarUpperLimit, max(avatarLowerLimit, possibleAvatarXOffset))
    
    UIView.animate(withDuration: 0.3, delay: 0.0, options: [.beginFromCurrentState, .allowUserInteraction, .curveEaseOut], animations: {
      self.photoImageView.center = CGPoint(x: possibleXOffset, y: self.photoImageView.center.y)
      self.userAvatarImageView.center = CGPoint(x: possibleAvatarXOffset, y: self.userAvatarImageView.center.y)
    }, completion: nil)
  }
  
  //MARK: Setup
  func downloadAndProcessUserAvatar(forPhoto avatarPhotoURL: URL) {
    let photoRef = photo
    UIImage.downloadImage(with: avatarPhotoURL) { (image) in
      guard let photoRef = photoRef, let photo = self.photo, photo == photoRef else { return }
      
      //Create circular images in background instead of using .cornerRadius
      self.userAvatarImageView.clipsToBounds = true
      self.userAvatarImageView.image = image
    }
  }
  
  func setupViews() {
    addSubview(userAvatarImageView)
    addSubview(photoImageView)
    addSubview(userNameLabel)
    addSubview(photoTimeIntervalSincePostLabel)
    addSubview(photoLikesLabel)
    addSubview(photoDescriptionLabel)
    addSubview(likersView)
    
    userAvatarImageView.backgroundColor = .white
    photoImageView.backgroundColor = .lightGray
    photoImageView.clipsToBounds = true
    photoImageView.contentMode = .scaleAspectFill
    
    //Set background colors for labels to white instead of clear
    userNameLabel.backgroundColor = .white
    photoTimeIntervalSincePostLabel.backgroundColor = .white
    photoLikesLabel.backgroundColor = .white
    photoDescriptionLabel.backgroundColor = .white
    
    userNameLabel.layer.shouldRasterize = true
    photoTimeIntervalSincePostLabel.layer.shouldRasterize = true
    photoLikesLabel.layer.shouldRasterize = true
    photoDescriptionLabel.layer.shouldRasterize = true
    
    photoImageView.layer.shouldRasterize = true
    userAvatarImageView.layer.shouldRasterize = true
    
    userAvatarImageView.translatesAutoresizingMaskIntoConstraints             = false
    photoImageView.translatesAutoresizingMaskIntoConstraints                  = false
    userNameLabel.translatesAutoresizingMaskIntoConstraints                   = false
    photoTimeIntervalSincePostLabel.translatesAutoresizingMaskIntoConstraints = false
    photoLikesLabel.translatesAutoresizingMaskIntoConstraints                 = false
    photoDescriptionLabel.translatesAutoresizingMaskIntoConstraints           = false
    
    setupConstraints()
    updateConstraints()
  }
  
  //MARK: Cell Reuse
  func updateCell(with photo: Photo?) {
    self.photo = photo
    
    guard let photo = photo else { return }
    
    userNameLabel.attributedText = photo.user.usernameAttributedString(withFontSize: 14.0)
    photoTimeIntervalSincePostLabel.attributedText = photo.uploadDateAttributedString(withFontSize: 14.0)
    photoLikesLabel.attributedText = photo.likesAttributedString(withFontSize: 14.0)
    photoDescriptionLabel.attributedText = photo.descriptionAttributedString(withFontSize: 14.0)
    
    userNameLabel.sizeToFit()
    photoTimeIntervalSincePostLabel.sizeToFit()
    photoLikesLabel.sizeToFit()
    photoDescriptionLabel.sizeToFit()
    
    applyShadow(to: userNameLabel)
    applyShadow(to: photoTimeIntervalSincePostLabel)
    applyShadow(to: photoLikesLabel)
    applyShadow(to: photoDescriptionLabel)

    var rect = photoDescriptionLabel.frame
    let availableWidth = bounds.size.width - 20
    rect.size = photoDescriptionLabel.sizeThatFits(CGSize(width: availableWidth, height: CGFloat.greatestFiniteMagnitude))
    
    photoDescriptionLabel.frame = rect
    
    let photoRef = self.photo
    UIImage.downloadImage(with: photo.urls.first) { (image) in
      guard let photo = self.photo, let photoRef = photoRef, photo == photoRef else { return }
      self.photoImageView.image = image
    }
    
    downloadAndProcessUserAvatar(forPhoto: photo.urls.first!)
    
    likersView.reloadLikers()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    likersView.bounds = CGRect(x: 0, y: 0, width: 75, height: 25)
    likersView.center = CGPoint(x: bounds.width - likersView.bounds.width/2.0 - 8.0, y: photoLikesLabel.center.y)
  }
    
  func applyShadow(to label: UILabel) {
    guard let text = label.text else { return }
    
    let shadow = NSShadow()
    shadow.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    shadow.shadowOffset = CGSize(width: 2.0, height: 2.0)
    shadow.shadowBlurRadius = 5.0
    
    let attributes = [NSAttributedStringKey.shadow: shadow, NSAttributedStringKey.font: label.font] as [NSAttributedStringKey : Any]
    let attributedString = NSAttributedString(string: text, attributes: attributes)
    
    label.attributedText = attributedString
  }
  
  override func prepareForReuse() {
    clearImages()
    
    userNameLabel.attributedText                   = nil
    photoTimeIntervalSincePostLabel.attributedText = nil
    photoLikesLabel.attributedText                 = nil
    photoDescriptionLabel.attributedText           = nil
  }
  
  func clearImages() {
    photoImageView.layer.contents = nil
    userAvatarImageView.layer.contents = nil
    
    photoImageView.image = UIImage(named: "placeholder")
  }
  
  //MARK: Obligatory init you don't use.
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


