//
//  AddEmojiViewController.swift
//  EmojiJournalMobileApp
//
//  Created by David Okun IBM on 1/26/18.
//  Copyright © 2018 Razeware. All rights reserved.
//

import UIKit
import ISEmojiView

protocol AddEmojiDelegate: class {
  func didAdd(entry: JournalEntry, from controller: AddEmojiViewController)
}

class AddEmojiViewController: UIViewController {
  @IBOutlet weak var emojiTextField: UITextField!
  weak var delegate: AddEmojiDelegate?
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    let emojiView = ISEmojiView()
    emojiView.delegate = self
    emojiTextField.inputView = emojiView
    emojiTextField.becomeFirstResponder()
  }
}

// MARK: - AddEmojiViewController ISEmojiViewDelegate
extension AddEmojiViewController: ISEmojiViewDelegate {
  func emojiViewDidSelectEmoji(emojiView: ISEmojiView, emoji: String) {
    emojiTextField.text = emoji
    emojiTextField.resignFirstResponder()
  }
  
  func emojiViewDidPressDeleteButton(emojiView: ISEmojiView) {
    emojiTextField.text = ""
  }
}

// MARK: - AddEmojiViewController saveEmoji, displayError
extension AddEmojiViewController {
  @IBAction func saveEmoji() {
    guard let emoji = emojiTextField.text else {
      displayError(with: "Need to enter an emoji")
      return
    }
    guard let newEntry = JournalEntry(id: nil, emoji: emoji, date: Date()) else {
      displayError(with: "Could not create new entry")
      return
    }
    delegate?.didAdd(entry: newEntry, from: self)
  }
  
  private func displayError(with message: String) {
    let alert = UIAlertController(title: "Error", message: "We could not save this emoji - please try again! Reason: \(message)", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
}

