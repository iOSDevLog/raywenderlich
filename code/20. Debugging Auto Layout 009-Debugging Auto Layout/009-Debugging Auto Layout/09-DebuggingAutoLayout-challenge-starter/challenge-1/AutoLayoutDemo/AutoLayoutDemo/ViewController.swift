//
//  ViewController.swift
//  AutoLayoutDemo
//
//  Created by Jerry Beers on 8/11/15.
//  Copyright © 2015 razeware.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let firstNameLabel = UILabel()
    firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
    firstNameLabel.text = "First Name"
    firstNameLabel.setContentHuggingPriority(251, forAxis: .Horizontal)
    view.addSubview(firstNameLabel)
    
    let firstNameTextField = UITextField()
    firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
    firstNameTextField.borderStyle = .RoundedRect
    view.addSubview(firstNameTextField)
    
    let lastNameLabel = UILabel()
    lastNameLabel.translatesAutoresizingMaskIntoConstraints = false
    lastNameLabel.text = "Last Name"
    view.addSubview(lastNameLabel)
    
    let lastNameTextField = UITextField()
    lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
    lastNameTextField.borderStyle = .RoundedRect
    view.addSubview(lastNameTextField)
    
    let addressLabel = UILabel()
    addressLabel.translatesAutoresizingMaskIntoConstraints = false
    addressLabel.text = "Address"
    view.addSubview(addressLabel)
    
    let addressTextField = UITextField()
    addressTextField.translatesAutoresizingMaskIntoConstraints = false
    addressTextField.borderStyle = .RoundedRect
    view.addSubview(addressTextField)
    
    let cityLabel = UILabel()
    cityLabel.translatesAutoresizingMaskIntoConstraints = false
    cityLabel.text = "City"
    view.addSubview(cityLabel)
    
    let cityTextField = UITextField()
    cityTextField.translatesAutoresizingMaskIntoConstraints = false
    cityTextField.borderStyle = .RoundedRect
    view.addSubview(cityTextField)
    
    let stateLabel = UILabel()
    stateLabel.translatesAutoresizingMaskIntoConstraints = false
    stateLabel.text = "State"
    view.addSubview(stateLabel)
    
    let stateTextField = UITextField()
    stateTextField.translatesAutoresizingMaskIntoConstraints = false
    stateTextField.borderStyle = .RoundedRect
    view.addSubview(stateTextField)
    
    let zipLabel = UILabel()
    zipLabel.translatesAutoresizingMaskIntoConstraints = false
    zipLabel.text = "Zip"
    view.addSubview(zipLabel)
    
    let zipTextField = UITextField()
    zipTextField.translatesAutoresizingMaskIntoConstraints = false
    zipTextField.borderStyle = .RoundedRect
    view.addSubview(zipTextField)
    
    let leftButton = UIButton(type: .System)
    leftButton.backgroundColor = UIColor.lightGrayColor()
    leftButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    leftButton.setTitle("Button", forState: .Normal)
    view.addSubview(leftButton)
    
    let rightButton = UIButton(type: .System)
    rightButton.backgroundColor = UIColor.lightGrayColor()
    rightButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    rightButton.setTitle("Button", forState: .Normal)
    view.addSubview(rightButton)
    
    let container = UILayoutGuide()
    view.addLayoutGuide(container)
    
    firstNameLabel.leadingAnchor.constraintEqualToAnchor(container.leadingAnchor).active = true
    
    firstNameTextField.firstBaselineAnchor.constraintEqualToAnchor(firstNameLabel.firstBaselineAnchor).active = true
    firstNameTextField.leadingAnchor.constraintEqualToAnchor(firstNameLabel.trailingAnchor, constant: 8).active = true
    firstNameTextField.topAnchor.constraintEqualToAnchor(container.topAnchor).active = true
    firstNameTextField.trailingAnchor.constraintEqualToAnchor(container.trailingAnchor).active = true
    
    lastNameLabel.leadingAnchor.constraintEqualToAnchor(firstNameLabel.leadingAnchor).active = true
    addressLabel.leadingAnchor.constraintEqualToAnchor(firstNameLabel.leadingAnchor).active = true
    cityLabel.leadingAnchor.constraintEqualToAnchor(firstNameLabel.leadingAnchor).active = true
    stateLabel.leadingAnchor.constraintEqualToAnchor(firstNameLabel.leadingAnchor).active = true
    zipLabel.leadingAnchor.constraintEqualToAnchor(firstNameLabel.leadingAnchor).active = true
    
    lastNameTextField.leadingAnchor.constraintEqualToAnchor(firstNameTextField.leadingAnchor).active = true
    addressTextField.leadingAnchor.constraintEqualToAnchor(firstNameTextField.leadingAnchor).active = true
    cityTextField.leadingAnchor.constraintEqualToAnchor(firstNameTextField.leadingAnchor).active = true
    stateTextField.leadingAnchor.constraintEqualToAnchor(firstNameTextField.leadingAnchor).active = true
    zipTextField.leadingAnchor.constraintEqualToAnchor(firstNameTextField.leadingAnchor).active = true
    
    lastNameTextField.trailingAnchor.constraintEqualToAnchor(firstNameTextField.trailingAnchor).active = true
    addressTextField.trailingAnchor.constraintEqualToAnchor(firstNameTextField.trailingAnchor).active = true
    cityTextField.trailingAnchor.constraintEqualToAnchor(firstNameTextField.trailingAnchor).active = true
    stateTextField.trailingAnchor.constraintEqualToAnchor(firstNameTextField.trailingAnchor).active = true
    zipTextField.trailingAnchor.constraintEqualToAnchor(firstNameTextField.trailingAnchor).active = true
    
    lastNameTextField.firstBaselineAnchor.constraintEqualToAnchor(lastNameLabel.firstBaselineAnchor).active = true
    lastNameTextField.topAnchor.constraintEqualToAnchor(firstNameTextField.bottomAnchor, constant: 8).active = true
    
    addressTextField.firstBaselineAnchor.constraintEqualToAnchor(addressLabel.firstBaselineAnchor).active = true
    addressTextField.topAnchor.constraintEqualToAnchor(lastNameTextField.bottomAnchor, constant: 8).active = true
    
    cityTextField.firstBaselineAnchor.constraintEqualToAnchor(cityLabel.firstBaselineAnchor).active = true
    cityTextField.topAnchor.constraintEqualToAnchor(addressTextField.bottomAnchor, constant: 8).active = true
    
    stateTextField.firstBaselineAnchor.constraintEqualToAnchor(stateLabel.firstBaselineAnchor).active = true
    stateTextField.topAnchor.constraintEqualToAnchor(cityTextField.bottomAnchor, constant: 8).active = true
    
    zipTextField.firstBaselineAnchor.constraintEqualToAnchor(zipLabel.firstBaselineAnchor).active = true
    zipTextField.topAnchor.constraintEqualToAnchor(stateTextField.bottomAnchor, constant: 8).active = true
    zipTextField.bottomAnchor.constraintEqualToAnchor(container.bottomAnchor).active = true
    
    let margins = view.layoutMarginsGuide
    container.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor)
    container.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
    container.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
    
    leftButton.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
    leftButton.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor, constant:-20).active = true
    
    rightButton.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
    rightButton.leadingAnchor.constraintEqualToAnchor(leftButton.trailingAnchor, constant: 8).active = true
    rightButton.bottomAnchor.constraintEqualToAnchor(leftButton.bottomAnchor).active = true
    rightButton.widthAnchor.constraintEqualToAnchor(leftButton.widthAnchor).active = true
  }
}

