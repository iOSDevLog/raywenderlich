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

class LikersView: UIView {
  let firstLikeImageView = UIImageView()
  let secondLikeImageView = UIImageView()
  let thirdLikeImageView = UIImageView()

  init() {
    super.init(frame: .zero)
    
    addSubview(firstLikeImageView)
    addSubview(secondLikeImageView)
    addSubview(thirdLikeImageView)

    reloadLikers()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let likerViews = [firstLikeImageView, secondLikeImageView, thirdLikeImageView]

    var i: CGFloat = 1.0
    for likerView in likerViews {
      likerView.layer.cornerRadius = 12.0
      likerView.backgroundColor = .lightGray
      
      layout(likerView: likerView, at: i)
      i += 2
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK - Helpers

extension LikersView {
  func layout(likerView: UIView, at position: CGFloat) {
    // we want 1/6 -- 3/6 ---5/6
    let center = CGPoint(x: ((position/6.0) * self.bounds.width), y: self.bounds.height/2.0)
    likerView.bounds = CGRect(x: 0, y: 0, width: 25, height: 25)
    likerView.center = center
    likerView.clipsToBounds = true
  }
  
  func reloadLikers() {
    let imageViews = [firstLikeImageView, secondLikeImageView, thirdLikeImageView]
    let urls = randomSetOfURLs()
    for imageView in imageViews {
      imageView.layer.contents = nil
      let i = imageViews.index(of: imageView)!
      let url = URL(string: urls[i])
      
      UIImage.downloadImage(with: url, completion: { (image) in
        imageView.image = image
      })
    }
  }
  
  func randomSetOfURLs() -> [String] {
    let index = Int(arc4random_uniform(3))
    let urls = [["https://images.unsplash.com/photo-1513103891413-5cd7019648f2?ixlib=rb-0.3.5&s=9fff335ee6807afc44080fd873806266&auto=format&fit=crop&w=2468&q=80",
                 "https://images.unsplash.com/photo-1514866747592-c2d279258a78?ixlib=rb-0.3.5&s=02fbc5840dfebd4bea9a35029ff1942d&auto=format&fit=crop&w=800&q=60",
                 "https://images.unsplash.com/photo-1476505312917-7d02cbf00c0d?ixlib=rb-0.3.5&s=f80926cf22a9821d6b22979ce9d3155d&auto=format&fit=crop&w=2550&q=80"],
                ["https://images.unsplash.com/photo-1498558263790-a9555e3d002d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=0b4f47b3d1eb96a6d5948bcdfbb32de1&auto=format&fit=crop&w=1500&q=80",
                 "https://images.unsplash.com/photo-1504241579298-1075e9e114e5?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=ebf225d0bc77edb19fe00a14ed3ec34d&auto=format&fit=crop&w=2557&q=80",
                 "https://images.unsplash.com/photo-1504575070132-986227df99f7?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=1bd11763a76e8d8de994bea06995e2a5&auto=format&fit=crop&w=668&q=80"],
                ["https://images.unsplash.com/photo-1489278353717-f64c6ee8a4d2?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=74573ba50aaf28e009bb77bee78fc350&auto=format&fit=crop&w=1500&q=80",
                 "https://images.unsplash.com/photo-1496595351388-d74ec2c9c9cc?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=51ec679cef41e98d188b55fc4256d1d8&auto=format&fit=crop&w=1528&q=80",
                 "https://images.unsplash.com/photo-1513270246933-7a934b770ea6?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=dc2fb1c879c1c5bdc6f244dde7fc7f80&auto=format&fit=crop&w=1500&q=80"]
    ]
    
    return urls[index]
  }
}
