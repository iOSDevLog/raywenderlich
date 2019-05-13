//
//  ViewController.swift
//  AutoLayout_Challenge4
//
//  Created by Brian Moakley on 1/21/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var firstNameLabel: UILabel!
  @IBOutlet weak var lastNameLabel: UILabel!
  @IBOutlet weak var address1Label: UILabel!
  @IBOutlet weak var address2Label: UILabel!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var stateLabel: UILabel!
  @IBOutlet weak var zipCodeLabel: UILabel!
  @IBOutlet weak var countryLabel: UILabel!
  
  @IBAction func updateLanguage(sender: UISegmentedControl) {
    
    let firstName:String
    let lastName:String
    let address1:String
    let address2:String
    let city:String
    let state:String
    let zipCode:String
    let country:String
    
    switch(sender.selectedSegmentIndex) {
      case 1:
        firstName = "Nombre De Pila"
        lastName = "El Nombre De Familia"
        address1 = "Las Señas 1"
        address2 = "Las Señas 1"
        city = "Ciudad"
        state = "Estado"
        zipCode = "Zip Coe"
        country = "País"
      case 2:
        firstName = "Vorname"
        lastName = "Nachname"
        address1 = "Anschrift 1"
        address2 = "Anschrift 1"
        city = "City"
        state = "Zustand"
        zipCode = "Plz"
        country = "Land"
      default:
        firstName = "First Name"
        lastName = "Last Name"
        address1 = "Address 1"
        address2 = "Address 2"
        city = "City"
        state = "State"
        zipCode = "Zip Code"
        country = "Country"
    }
    firstNameLabel.text = firstName
    lastNameLabel.text = lastName
    address1Label.text = address1
    address2Label.text = address2
    cityLabel.text = city
    stateLabel.text = state
    zipCodeLabel.text = zipCode
    countryLabel.text = country
  }
}

