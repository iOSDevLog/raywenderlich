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
    
    let views = ["firstNameLabel": firstNameLabel, "firstNameTextField": firstNameTextField,
    "lastNameLabel": lastNameLabel, "lastNameTextField": lastNameTextField,
    "popStarLabel": popStarLabel, "popStarTextField": popStarTextField,
    "statesLabel": statesLabel, "statesTextField": statesTextField,
    "rapperLabel": rapperLabel, "rapperTextField": rapperTextField,
    "realAgeLabel": realAgeLabel, "realAgeTextField": realAgeTextField,
    "leftButton": leftButton, "rightButton": rightButton]
    
    let container = UILayoutGuide()
    view.addLayoutGuide(container)
    container.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
    firstNameTextField.topAnchor.constraintEqualToAnchor(container.topAnchor).active = true
    realAgeTextField.bottomAnchor.constraintEqualToAnchor(container.bottomAnchor).active = true
    
    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[firstNameLabel]-[firstNameTextField]-|", options: .AlignAllFirstBaseline, metrics: nil, views: views))
    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[lastNameLabel]-[lastNameTextField]-|", options: .AlignAllFirstBaseline, metrics: nil, views: views))
    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[popStarLabel]-[popStarTextField]-|", options: .AlignAllFirstBaseline, metrics: nil, views: views))
    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[statesLabel]-[statesTextField]-|", options: .AlignAllFirstBaseline, metrics: nil, views: views))
    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[rapperLabel]-[rapperTextField]-|", options: .AlignAllFirstBaseline, metrics: nil, views: views))
    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[realAgeLabel]-[realAgeTextField]-|", options: .AlignAllFirstBaseline, metrics: nil, views: views))
    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[firstNameTextField]-[lastNameTextField]-[popStarTextField]-[statesTextField]-[rapperTextField]-[realAgeTextField]", options: [.AlignAllLeading, .AlignAllTrailing], metrics: nil, views: views))
    
    let metrics = ["bottomGap": 20]
    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[leftButton]-[rightButton(==leftButton)]-|", options: .AlignAllBottom, metrics: nil, views: views))
    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[rightButton]-(bottomGap)-|", options: [], metrics: metrics, views: views))
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

