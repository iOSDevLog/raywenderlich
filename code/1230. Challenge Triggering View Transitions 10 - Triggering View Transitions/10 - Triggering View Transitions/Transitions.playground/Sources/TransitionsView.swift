/*
 * Copyright (c) 2014-2016 Razeware LLC
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

public class TransitionsView: UIView {
  public var duration: TimeInterval = 1.0
  
  public let
  beachball = UIImageView(image: UIImage(named: "beachball")),
  drink = UIImageView(image: UIImage(named: "drink")),
  icecream = UIImageView(image: UIImage(named: "icecream"))
  
  var
  beachballConY: NSLayoutConstraint!,
  drinkConY: NSLayoutConstraint!,
  icecreamConY: NSLayoutConstraint!
  
  public let button: UIButton = {
    let button = UIButton(frame: CGRect(
      x: 135,
      y: 50,
      width: 130,
      height: 50)
    )
    button.setTitle("Animate!", for: .normal)
    button.setTitleColor(#colorLiteral(red: 0.01164326165, green: 0.6604029536, blue: 0.9141276479, alpha: 1), for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: UIFont.Weight.bold)
    button.backgroundColor = #colorLiteral(red: 1, green: 0.9062726498, blue: 0.6375227571, alpha: 1)
    button.layer.cornerRadius = 10
    return button
  }()
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    initPhase2()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    initPhase2()
  }
  
  func initPhase2(){
    backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    let background: UIImageView = {
      let imageView = UIImageView(frame: self.frame)
      imageView.image = UIImage(named: "sunnyBackground")
      imageView.alpha = 0.6
      return imageView
    }()
    
    [background, button, beachball, drink, icecream].forEach{addSubview($0)}
    
    setupIconView(imageView: beachball, position: -1)
    setupIconView(imageView: drink, position: 0)
    setupIconView(imageView: icecream, position: 1)
    
    beachballConY = beachball.centerYAnchor.constraint(
      equalTo: self.centerYAnchor
    )
    drinkConY = drink.centerYAnchor.constraint(
      equalTo: self.centerYAnchor
    )
    icecreamConY = icecream.centerYAnchor.constraint(
      equalTo: self.centerYAnchor
    )
    
    NSLayoutConstraint.activate([
      beachballConY,
      drinkConY,
      icecreamConY
    ])
  }
  
  func setupIconView(imageView: UIImageView, position: CGFloat){
    imageView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    imageView.layer.cornerRadius = 5.0
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    let conX = imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: position * 125)
    let conWidth = imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.38, constant: -50.0)
    let conHeight = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
    NSLayoutConstraint.activate([conX, conWidth, conHeight])
  }
}
