//
//  ViewController.swift
//  BullsEye
//
//  Created by Brian on 9/21/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var currentValue = 0
  var targetValue = 0
  var score = 0
  var round = 0
  
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var roundLabel: UILabel!
  
  @IBAction func startOver() {
    startNewGame()
    updateLabels()
  }
  
  @IBAction func sliderMoved(_ slider: UISlider) {
    currentValue = lroundf(slider.value)
  }
  
  @IBAction func showAlert(_ sender: AnyObject) {
    let difference = abs(targetValue - currentValue)
    var points = 100 - difference
    let title: String
    
    if difference == 0 {
      title = "Perfect!"
      points += 100
    } else if difference < 5 {
      title = "You almost had it!"
      if difference == 1 {
        points += 50
      }
    } else if difference < 10 {
      title = "Pretty good"
    } else {
      title = "Not even close..."
    }
    
    let message = "The value of the slider is: \(currentValue)\nThe target value is: \(targetValue)\nYou scored \(points) points."
    score += points
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let actionItem = UIAlertAction(title: "OK", style: .default) {
      action in
        self.startNewRound()
        self.updateLabels()
    }
    alert.addAction(actionItem)
    present(alert, animated: true, completion: nil)
  }
  
  func startNewGame() {
    score = 0
    round = 0
    startNewRound()
  }
  
  func updateLabels() {
    targetLabel.text = String(targetValue)
    scoreLabel.text = String(score)
    roundLabel.text = String(round)
  }
  
  func startNewRound() {
    round += 1
    targetValue = 1 + Int(arc4random_uniform(100))
    currentValue = 50
    slider.value = Float(currentValue)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    startNewGame()
    updateLabels()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

