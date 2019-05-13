//
//  ViewController.swift
//  AutoLayout_Demo9
//
//  Created by Brian Moakley on 1/24/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let searchLabel = UILabel()
    searchLabel.text = "Search:"
    view.addSubview(searchLabel)

    let textField = UITextField()
    textField.borderStyle = .RoundedRect
    view.addSubview(textField)

    let lookupButton = UIButton()
    lookupButton.setTitle("Lookup!", forState: .Normal)
    lookupButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
    lookupButton.setTitleColor(UIColor.blueColor(), forState: .Highlighted)
    view.addSubview(lookupButton)
    
    NSLayoutConstraint(item: searchLabel, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .LeadingMargin, multiplier: 1.0, constant: 0).active = true
    NSLayoutConstraint(item: searchLabel, attribute: .Baseline, relatedBy: .Equal, toItem: textField, attribute: .Baseline, multiplier: 1.0, constant: 0).active = true
    
    NSLayoutConstraint(item: view, attribute: .TrailingMargin, relatedBy: .Equal, toItem: textField, attribute: .Trailing, multiplier: 1.0, constant: 0).active = true
    NSLayoutConstraint(item: textField, attribute: .Top, relatedBy: .Equal, toItem: topLayoutGuide, attribute: .Bottom, multiplier: 1.0, constant: 20).active = true
    NSLayoutConstraint(item: textField, attribute: .Leading, relatedBy: .Equal, toItem: searchLabel, attribute: .Trailing, multiplier: 1.0, constant: 8).active = true
    
    NSLayoutConstraint(item: lookupButton, attribute: .Top, relatedBy: .Equal, toItem: textField, attribute: .Bottom, multiplier: 1.0, constant: 8).active = true
    NSLayoutConstraint(item: lookupButton, attribute: .Trailing, relatedBy: .Equal, toItem: textField, attribute: .Trailing, multiplier: 1.0, constant: 0).active = true
  }
}
