//
//  ViewController.swift
//  AutoLayout_Challenge8
//
//  Created by Brian Moakley on 1/25/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let containerView = UIView()
    containerView.translatesAutoresizingMaskIntoConstraints = false
    containerView.backgroundColor = UIColor(red: 254.0/255.0, green: 203.0/255.0, blue: 69.0/255.0, alpha: 1.0)
    view.addSubview(containerView)

    let usernameLabel = UILabel()
    usernameLabel.translatesAutoresizingMaskIntoConstraints = false
    usernameLabel.text = "Username:"
    containerView.addSubview(usernameLabel)

    let passwordLabel = UILabel()
    passwordLabel.translatesAutoresizingMaskIntoConstraints = false
    passwordLabel.text = "Password:"
    containerView.addSubview(passwordLabel)

    let usernameTextField = UITextField()
    usernameTextField.translatesAutoresizingMaskIntoConstraints = false
    usernameTextField.borderStyle = .RoundedRect
    containerView.addSubview(usernameTextField)

    let passwordTextField = UITextField()
    passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    passwordTextField.borderStyle = .RoundedRect
    containerView.addSubview(passwordTextField)

    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Submit", forState: .Normal)
    button.setTitleColor(UIColor.blueColor(), forState: .Normal)
    containerView.addSubview(button)
    
    usernameLabel.setContentHuggingPriority(251, forAxis:.Horizontal)
    usernameLabel.setContentCompressionResistancePriority(751, forAxis: .Horizontal)
    passwordLabel.setContentHuggingPriority(251, forAxis:.Horizontal)
    passwordLabel.setContentCompressionResistancePriority(751, forAxis: .Horizontal)
    
    NSLayoutConstraint(item: containerView, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .LeadingMargin, multiplier: 1.0, constant: 0).active = true
    NSLayoutConstraint(item: containerView, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .TrailingMargin, multiplier: 1.0, constant: 0).active = true
    NSLayoutConstraint(item: containerView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 120).active = true
    NSLayoutConstraint(item: containerView, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1.0, constant: 0).active = true
  
    NSLayoutConstraint(item: usernameTextField, attribute: .Leading, relatedBy: .Equal, toItem: usernameLabel, attribute: .Trailing, multiplier: 1.0, constant: 8).active = true
    NSLayoutConstraint(item: usernameTextField, attribute: .Top, relatedBy: .Equal, toItem: containerView, attribute: .Top, multiplier: 1.0, constant: 8).active = true
    NSLayoutConstraint(item: usernameTextField, attribute: .Trailing, relatedBy: .Equal, toItem: containerView, attribute: .TrailingMargin, multiplier: 1.0, constant: 0).active = true

    NSLayoutConstraint(item: usernameLabel, attribute: .Leading, relatedBy: .Equal, toItem: containerView, attribute: .LeadingMargin, multiplier: 1.0, constant: 8).active = true
    NSLayoutConstraint(item: usernameLabel, attribute: .Baseline, relatedBy: .Equal, toItem: usernameTextField, attribute: .Baseline, multiplier: 1.0, constant: 0).active = true

    NSLayoutConstraint(item: passwordTextField, attribute: .Leading, relatedBy: .Equal, toItem: usernameTextField , attribute: .Leading, multiplier: 1.0, constant: 0).active = true
    NSLayoutConstraint(item: passwordTextField, attribute: .Trailing, relatedBy: .Equal, toItem: usernameTextField, attribute: .Trailing, multiplier: 1.0, constant: 0).active = true
    NSLayoutConstraint(item: passwordTextField, attribute: .Top, relatedBy: .Equal, toItem: usernameTextField, attribute: .Bottom, multiplier: 1.0, constant: 8).active = true

    NSLayoutConstraint(item: passwordLabel, attribute: .Leading, relatedBy: .Equal, toItem: usernameLabel, attribute: .Leading, multiplier: 1.0, constant: 0).active = true
    NSLayoutConstraint(item: passwordLabel, attribute: .Trailing, relatedBy: .Equal, toItem: usernameLabel, attribute: .Trailing, multiplier: 1.0, constant: 0).active = true
    NSLayoutConstraint(item: passwordLabel, attribute: .Baseline, relatedBy: .Equal, toItem: passwordTextField, attribute: .Baseline, multiplier: 1.0, constant: 0).active = true
    
    NSLayoutConstraint(item: button, attribute: .CenterX, relatedBy: .Equal, toItem: containerView, attribute: .CenterX, multiplier: 1.0, constant: 0).active = true
    NSLayoutConstraint(item: containerView, attribute: .Bottom, relatedBy: .Equal, toItem: button, attribute: .Bottom, multiplier: 1.0, constant: 4).active = true
  }
}
