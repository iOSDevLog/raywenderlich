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

    let search = UILabel()
    let textField = UITextField()
    let lookupButton = UIButton()
    textField.borderStyle = .RoundedRect
    
    search.text = "Search:"
    lookupButton.setTitle("Lookup!", forState: .Normal)
    lookupButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
    lookupButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Highlighted)
    
    view.addSubview(search)
    view.addSubview(textField)
    view.addSubview(lookupButton)
    
    let searchConstraintHorizontal = NSLayoutConstraint(item: search, attribute:.LeadingMargin, relatedBy: .Equal, toItem: view, attribute: NSLayoutAttribute.LeadingMargin, multiplier: 1.0, constant: 20)
    let searchConstraintVertical = NSLayoutConstraint(item: search, attribute:.Top, relatedBy: .Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 20)
    let searchCenterY = NSLayoutConstraint(item: search, attribute:NSLayoutAttribute.CenterY, relatedBy: .Equal, toItem: textField, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
  
    let textFieldHorizontal = NSLayoutConstraint(item: view, attribute:.TrailingMargin, relatedBy: .Equal, toItem: textField, attribute: .TrailingMargin, multiplier: 1.0, constant: 20)
    let textFieldVertical = NSLayoutConstraint(item: textField, attribute:.Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 20)
    let textFieldLeft = NSLayoutConstraint(item: textField, attribute:.Leading, relatedBy: .Equal, toItem: search, attribute: .Trailing, multiplier: 1.0, constant: 8)
    
    
    let buttonVertical = NSLayoutConstraint(item: lookupButton, attribute:.Top, relatedBy: .Equal, toItem: textField, attribute: .Bottom, multiplier: 1.0, constant: 8)
    let buttonHorizontal = NSLayoutConstraint(item: view, attribute:.TrailingMargin, relatedBy: .Equal, toItem: lookupButton, attribute: .Trailing, multiplier: 1.0, constant: 20)
    
    
    search.setTranslatesAutoresizingMaskIntoConstraints(false)
    textField.setTranslatesAutoresizingMaskIntoConstraints(false)
    lookupButton.setTranslatesAutoresizingMaskIntoConstraints(false)
    
    
    NSLayoutConstraint.activateConstraints([searchConstraintHorizontal, searchConstraintVertical, searchCenterY, textFieldHorizontal, textFieldVertical, textFieldLeft, buttonVertical, buttonHorizontal])

    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

