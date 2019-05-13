//
//  ViewController.swift
//  DemoAutoLayout
//
//  Created by Jerry Beers on 8/31/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
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
    
    let popStarLabel = UILabel()
    popStarLabel.translatesAutoresizingMaskIntoConstraints = false
    popStarLabel.text = "Pop star"
    view.addSubview(popStarLabel)
    
    let popStarTextField = UITextField()
    popStarTextField.translatesAutoresizingMaskIntoConstraints = false
    popStarTextField.borderStyle = .RoundedRect
    view.addSubview(popStarTextField)
    
    let statesLabel = UILabel()
    statesLabel.translatesAutoresizingMaskIntoConstraints = false
    statesLabel.text = "How many states"
    view.addSubview(statesLabel)
    
    let statesTextField = UITextField()
    statesTextField.translatesAutoresizingMaskIntoConstraints = false
    statesTextField.borderStyle = .RoundedRect
    view.addSubview(statesTextField)
    
    let rapperLabel = UILabel()
    rapperLabel.translatesAutoresizingMaskIntoConstraints = false
    rapperLabel.text = "Rapper"
    view.addSubview(rapperLabel)
    
    let rapperTextField = UITextField()
    rapperTextField.translatesAutoresizingMaskIntoConstraints = false
    rapperTextField.borderStyle = .RoundedRect
    view.addSubview(rapperTextField)
    
    let realAgeLabel = UILabel()
    realAgeLabel.translatesAutoresizingMaskIntoConstraints = false
    realAgeLabel.text = "Real Age"
    view.addSubview(realAgeLabel)
    
    let realAgeTextField = UITextField()
    realAgeTextField.translatesAutoresizingMaskIntoConstraints = false
    realAgeTextField.borderStyle = .RoundedRect
    view.addSubview(realAgeTextField)
    
    let leftButton = UIButton(type: .System)
    leftButton.translatesAutoresizingMaskIntoConstraints = false
    leftButton.backgroundColor = UIColor.lightGrayColor()
    leftButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    leftButton.setTitle("Button", forState: .Normal)
    view.addSubview(leftButton)
    
    let rightButton = UIButton(type: .System)
    rightButton.translatesAutoresizingMaskIntoConstraints = false
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
    popStarLabel.leadingAnchor.constraintEqualToAnchor(firstNameLabel.leadingAnchor).active = true
    statesLabel.leadingAnchor.constraintEqualToAnchor(firstNameLabel.leadingAnchor).active = true
    rapperLabel.leadingAnchor.constraintEqualToAnchor(firstNameLabel.leadingAnchor).active = true
    realAgeLabel.leadingAnchor.constraintEqualToAnchor(firstNameLabel.leadingAnchor).active = true
    
    lastNameLabel.trailingAnchor.constraintEqualToAnchor(firstNameLabel.trailingAnchor).active = true
    popStarLabel.trailingAnchor.constraintEqualToAnchor(firstNameLabel.trailingAnchor).active = true
    statesLabel.trailingAnchor.constraintEqualToAnchor(firstNameLabel.trailingAnchor).active = true
    rapperLabel.trailingAnchor.constraintEqualToAnchor(firstNameLabel.trailingAnchor).active = true
    realAgeLabel.trailingAnchor.constraintEqualToAnchor(firstNameLabel.trailingAnchor).active = true
    
    lastNameTextField.leadingAnchor.constraintEqualToAnchor(firstNameTextField.leadingAnchor).active = true
    popStarTextField.leadingAnchor.constraintEqualToAnchor(firstNameTextField.leadingAnchor).active = true
    statesTextField.leadingAnchor.constraintEqualToAnchor(firstNameTextField.leadingAnchor).active = true
    rapperTextField.leadingAnchor.constraintEqualToAnchor(firstNameTextField.leadingAnchor).active = true
    realAgeTextField.leadingAnchor.constraintEqualToAnchor(firstNameTextField.leadingAnchor).active = true
    
    lastNameTextField.trailingAnchor.constraintEqualToAnchor(firstNameTextField.trailingAnchor).active = true
    popStarTextField.trailingAnchor.constraintEqualToAnchor(firstNameTextField.trailingAnchor).active = true
    statesTextField.trailingAnchor.constraintEqualToAnchor(firstNameTextField.trailingAnchor).active = true
    rapperTextField.trailingAnchor.constraintEqualToAnchor(firstNameTextField.trailingAnchor).active = true
    realAgeTextField.trailingAnchor.constraintEqualToAnchor(firstNameTextField.trailingAnchor).active = true
    
    lastNameTextField.firstBaselineAnchor.constraintEqualToAnchor(lastNameLabel.firstBaselineAnchor).active = true
    lastNameTextField.topAnchor.constraintEqualToAnchor(firstNameTextField.bottomAnchor, constant: 8).active = true
    
    popStarTextField.firstBaselineAnchor.constraintEqualToAnchor(popStarLabel.firstBaselineAnchor).active = true
    popStarTextField.topAnchor.constraintEqualToAnchor(lastNameTextField.bottomAnchor, constant: 8).active = true
    
    statesTextField.firstBaselineAnchor.constraintEqualToAnchor(statesLabel.firstBaselineAnchor).active = true
    statesTextField.topAnchor.constraintEqualToAnchor(popStarTextField.bottomAnchor, constant: 8).active = true
    
    rapperTextField.firstBaselineAnchor.constraintEqualToAnchor(rapperLabel.firstBaselineAnchor).active = true
    rapperTextField.topAnchor.constraintEqualToAnchor(statesTextField.bottomAnchor, constant: 8).active = true
    
    realAgeTextField.firstBaselineAnchor.constraintEqualToAnchor(realAgeLabel.firstBaselineAnchor).active = true
    realAgeTextField.topAnchor.constraintEqualToAnchor(rapperTextField.bottomAnchor, constant: 8).active = true
    realAgeTextField.bottomAnchor.constraintEqualToAnchor(container.bottomAnchor).active = true
    
    let margins = view.layoutMarginsGuide
    container.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
    container.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
    container.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
    
    leftButton.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
    leftButton.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor, constant: -20).active = true
    
    rightButton.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
    rightButton.leadingAnchor.constraintEqualToAnchor(leftButton.trailingAnchor, constant: 8).active = true
    rightButton.bottomAnchor.constraintEqualToAnchor(leftButton.bottomAnchor).active = true
    rightButton.widthAnchor.constraintEqualToAnchor(leftButton.widthAnchor).active = true
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

