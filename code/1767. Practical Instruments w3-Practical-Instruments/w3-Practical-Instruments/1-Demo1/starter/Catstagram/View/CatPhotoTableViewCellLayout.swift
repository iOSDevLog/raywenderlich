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

extension CatPhotoTableViewCell {
  func setupConstraints() {
    addConstraintsForAvatar()
    addConstraintsForUserNameLabel()
    addConstraintsForPhotoTimeIntervalSincePostLabel()
    addConstraintsForPhotoImageView()
    addConstraintsForLikesLabel()
    addConstraintsForDescriptionLabel()
  }
  
  func addConstraintsForAvatar() {
    let horizontalBuffer:CGFloat = 8.0
    
    userAvatarImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: horizontalBuffer).isActive = true
    userAvatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: horizontalBuffer).isActive = true

    userAvatarImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
    userAvatarImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
  }
  
  func addConstraintsForUserNameLabel() {
    let horizontalBuffer:CGFloat = 10.0

    userNameLabel.leftAnchor.constraint(equalTo: userAvatarImageView.rightAnchor, constant: horizontalBuffer).isActive = true
    userNameLabel.rightAnchor.constraint(lessThanOrEqualTo: photoTimeIntervalSincePostLabel.leftAnchor).isActive = true
    
    userNameLabel.centerYAnchor.constraint(equalTo: userAvatarImageView.centerYAnchor, constant: 1.0).isActive = true
  }
  
  func addConstraintsForPhotoTimeIntervalSincePostLabel() {
    let horizontalBuffer:CGFloat = 10.0

    photoTimeIntervalSincePostLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -horizontalBuffer).isActive = true
    photoTimeIntervalSincePostLabel.centerYAnchor.constraint(equalTo: userAvatarImageView.centerYAnchor, constant: 1.0).isActive = true
  }
  
  func addConstraintsForPhotoImageView() {
    let headerHeight:CGFloat = 50.0
    
    photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: headerHeight).isActive = true
    photoImageView.widthAnchor.constraint(equalTo: widthAnchor, constant: 1.1).isActive = true
    photoImageView.heightAnchor.constraint(equalTo: widthAnchor, constant: 1.0).isActive = true
  }
  
  func addConstraintsForLikesLabel() {
    let verticalBuffer:CGFloat = 5.0
    let horizontalBuffer:CGFloat = 10.0
    
    photoLikesLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: verticalBuffer).isActive = true
    photoLikesLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: horizontalBuffer).isActive = true
  }
  
  func addConstraintsForDescriptionLabel() {
    let verticalBuffer:CGFloat = 5.0
    let horizontalBuffer:CGFloat = 10.0

    
    photoDescriptionLabel.topAnchor.constraint(equalTo: photoLikesLabel.bottomAnchor, constant: verticalBuffer).isActive = true
    photoDescriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: horizontalBuffer).isActive = true
    photoDescriptionLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -horizontalBuffer).isActive = true
  }
  
  class func height(forPhoto photo: Photo, with width: CGFloat) -> CGFloat {
    let headerHeight:CGFloat = 50.0
    let horizontalBuffer:CGFloat = 10.0
    let verticalBuffer:CGFloat = 5.0
    let fontSize:CGFloat = 14.0
    
    let photoHeight = width * 1.1
    
    let font = UIFont.systemFont(ofSize: 14)
    
    let descriptionAttrString = photo.descriptionAttributedString(withFontSize: fontSize)
    let availableWidth = width - (horizontalBuffer * 2)
    
    let descriptionHeight = descriptionAttrString.boundingRect(with: CGSize(width: availableWidth, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil).size.height
    
    return headerHeight + photoHeight + font.lineHeight + descriptionHeight + (4 * verticalBuffer)
  }
}

