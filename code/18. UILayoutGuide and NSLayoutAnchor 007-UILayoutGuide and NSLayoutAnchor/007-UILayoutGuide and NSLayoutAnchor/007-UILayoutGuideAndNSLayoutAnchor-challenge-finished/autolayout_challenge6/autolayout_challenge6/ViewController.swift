//
//  ViewController.swift
//  AutoLayout_Challenge6
//
//  Created by Jerry Beers on 8/12/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var backgroundImageView: UIImageView!
  @IBOutlet var profileImageViews: [UIImageView]!
  
  var widthConstraints: [NSLayoutConstraint] = [NSLayoutConstraint]()
  var selectedConstraint: NSLayoutConstraint?
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var bioTextView: UITextView!
  @IBOutlet weak var emailButton: UIButton!
  
  var bios: [String]!
  var names: [String]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    bios = [
      "Ray is an indie software developer currently focusing on iPhone and iPad development, and the administrator of this site. He’s the founder of a small iPhone development studio called Razeware, and is passionate both about making apps and teaching others the techniques to make them.",
      "Vicki Wenderlich discovered a love of digital art in 2009, and has been making app art and digital illustrations ever since. She is passionate about helping people pursue their dreams, and makes free app art for developers available on her website, http://www.vickiwenderlich.com.",
      "Greg is an iOS developer and trainer, and has been on the raywenderlich.com editorial team since 2012. He has been nerding out with computers since the Commodore 64 era in the 80s and continues to this day on the web and on iOS. He likes caffeine, codes with two-space tabs, and writes with semicolons.",
      "Mic Pringle is a developer, editor, podcaster, and video tutorial maker. He's also Razeware's third full-time employee. When not knee-deep in Swift or stood in-front of his green screen, he enjoys spending time with his wife Lucy and their daughter Evie, as-well as attending the football matches of his beloved Fulham FC. You can find Mic on Twitter, GitHub, and Stack Overflow.",
      "Christine is Ray's administrative assistant. She tries to keep order in the ever expanding world of raywenderlich.com so that Ray and the team can stay focused on making more tutorials, books, and apps!"]
    names = ["Ray Wenderlich", "Vicki Wenderlich", "Greg Heo", "Mic Pringle", "Christine Sweigart"]

    nameLabel.text = ""
    emailButton.hidden = true
    
    backgroundImageView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
    backgroundImageView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
    backgroundImageView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
    backgroundImageView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
    
    let firstImage = profileImageViews.first!
    let leadingConstraint = firstImage.leadingAnchor.constraintEqualToAnchor(view.layoutMarginsGuide.leadingAnchor)
    leadingConstraint.priority = 999
    leadingConstraint.active = true
    firstImage.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 8).active = true
    
    let lastImage = profileImageViews.last!
    let trailingConstraint = lastImage.trailingAnchor.constraintEqualToAnchor(view.layoutMarginsGuide.trailingAnchor)
    trailingConstraint.priority = 999
    trailingConstraint.active = true
    
    var firstGap: UILayoutGuide?
    for index in 0..<profileImageViews.count {
      let imageView = profileImageViews[index]
      let widthConstraint = imageView.widthAnchor.constraintEqualToConstant(50)
      widthConstraints.append(widthConstraint)
      widthConstraint.active = true
      
      imageView.heightAnchor.constraintEqualToAnchor(imageView.widthAnchor).active = true

      if (index > 0) {
        imageView.topAnchor.constraintEqualToAnchor(firstImage.topAnchor).active = true

        let gap = UILayoutGuide()
        view.addLayoutGuide(gap)
        gap.leadingAnchor.constraintEqualToAnchor(profileImageViews[index-1].trailingAnchor).active = true
        imageView.leadingAnchor.constraintEqualToAnchor(gap.trailingAnchor).active = true
        if (index > 1) {
          gap.widthAnchor.constraintEqualToAnchor(firstGap!.widthAnchor).active = true
        } else {
          firstGap = gap
        }
      }
    }
    
    nameLabel.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 150).active = true
    nameLabel.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
    
    bioTextView.topAnchor.constraintEqualToAnchor(nameLabel.bottomAnchor, constant: 8).active = true
    bioTextView.leadingAnchor.constraintEqualToAnchor(view.layoutMarginsGuide.leadingAnchor).active = true
    bioTextView.trailingAnchor.constraintEqualToAnchor(view.layoutMarginsGuide.trailingAnchor).active = true
    
    emailButton.topAnchor.constraintEqualToAnchor(bioTextView.bottomAnchor, constant: 8).active = true
    emailButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
    emailButton.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor, constant: -8).active = true
  }

  @IBAction func imageTapped(sender: UITapGestureRecognizer) {
    guard let tag = sender.view?.tag else { return }
    
    let widthConstraint = widthConstraints[tag]
    
    if let selectedConstraint = selectedConstraint {
      selectedConstraint.constant = 50
    }
    if widthConstraint == selectedConstraint {
      nameLabel.text = ""
      bioTextView.text = ""
      emailButton.hidden = true
      selectedConstraint = nil
    } else {
      widthConstraint.constant = 100
      nameLabel.text = names[tag]
      bioTextView.text = bios[tag]
      // There seems to be a bug setting the color from IB and then changing the text later, possibly related to the text being empty in IB, so we just reset the color here
      bioTextView.textColor = UIColor.whiteColor()
      emailButton.hidden = false
      selectedConstraint = widthConstraint
    }
  }
}

