//
//  ViewController.swift
//  AutoLayout_Challenge4
//
//  Created by Brian Moakley on 1/21/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var topContainer: UIView!
  @IBOutlet weak var bookImageView: UIImageView!
  @IBOutlet weak var bottomContainer: UIView!
  @IBOutlet weak var bottomBackgroundImageView: UIImageView!
  @IBOutlet weak var bookTitleLabel: UILabel!
  @IBOutlet weak var bookValueLabel: UILabel!
  @IBOutlet weak var publicationDateLabel: UILabel!
  @IBOutlet weak var publicationValueLabel: UILabel!
  @IBOutlet weak var pagesLabel: UILabel!
  @IBOutlet weak var pagesValueLabel: UILabel!
  @IBOutlet weak var leadAuthorLabel: UILabel!
  @IBOutlet weak var leadAuthorValueLabel: UILabel!
  @IBOutlet weak var finalPassEditorLabel: UILabel!
  @IBOutlet weak var editorValueLabel: UILabel!
  @IBOutlet weak var languageSegmentedControl: UISegmentedControl!

  override func viewDidLoad() {
    super.viewDidLoad()

    let containerAndImageViews = ["topContainer": topContainer, "bookImageView": bookImageView, "bottomContainer": bottomContainer, "bottomBackgroundImageView": bottomBackgroundImageView]
    let views = ["bookTitleLabel": bookTitleLabel, "bookValueLabel": bookValueLabel, "publicationDateLabel": publicationDateLabel, "publicationValueLabel": publicationValueLabel, "pagesLabel": pagesLabel, "pagesValueLabel": pagesValueLabel, "leadAuthorLabel": leadAuthorLabel, "leadAuthorValueLabel": leadAuthorValueLabel, "finalPassEditorLabel": finalPassEditorLabel, "editorValueLabel": editorValueLabel, "languageSegmentedControl": languageSegmentedControl]

    let metrics = ["imageMargin": 29, "textMargin": 27]
    
    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[topContainer]|", options:NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: containerAndImageViews))
    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[topContainer][bottomContainer(==topContainer)]|", options:[.AlignAllLeading, .AlignAllTrailing], metrics: nil, views: containerAndImageViews))

    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[bookImageView]-|", options:NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: containerAndImageViews))
    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(imageMargin)-[bookImageView]-(imageMargin)-|", options:NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: containerAndImageViews))
    
    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[bottomBackgroundImageView]|", options:NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: containerAndImageViews))
    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[bottomBackgroundImageView]|", options:NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: containerAndImageViews))
    
    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[bookTitleLabel]-[bookValueLabel]-|", options:.AlignAllFirstBaseline, metrics: nil, views: views))
    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[publicationDateLabel]-[publicationValueLabel]-|", options:.AlignAllFirstBaseline, metrics: nil, views: views))
    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[pagesLabel]-[pagesValueLabel]-|", options:.AlignAllFirstBaseline, metrics: nil, views: views))
    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[leadAuthorLabel]-[leadAuthorValueLabel]-|", options:.AlignAllFirstBaseline, metrics: nil, views: views))
    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[finalPassEditorLabel]-[editorValueLabel]-|", options:.AlignAllFirstBaseline, metrics: nil, views: views))
    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(textMargin)-[bookTitleLabel]-[publicationDateLabel]-[pagesLabel]-[leadAuthorLabel]-[finalPassEditorLabel]", options:.AlignAllLeading, metrics: metrics, views: views))

    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[languageSegmentedControl]-|", options:NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
    NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[languageSegmentedControl]-|", options:NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
  }
  
  @IBAction func updateLanguage(sender: UISegmentedControl) {
    
    let bookTitle: String
    let publicationDate: String
    let pages: String
    let leadAuthor: String
    let finalPassEditor: String
    
    switch(sender.selectedSegmentIndex) {
      case 1:
        bookTitle = "Título del libro"
        publicationDate = "Fecha de publicación"
        pages = "Páginas"
        leadAuthor = "Autor principal"
        finalPassEditor = "Final de Editor Pass"
      case 2:
        bookTitle = "Buchtitel"
        publicationDate = "Erscheinungsdatum"
        pages = "Seiten"
        leadAuthor = "Lead Author"
        finalPassEditor = "Schluss Pass Editor"
      default:
        bookTitle = "Book Title"
        publicationDate = "Publication Date"
        pages = "Pages"
        leadAuthor = "Lead Author"
        finalPassEditor = "Final Pass Editor"
    }
    bookTitleLabel.text = bookTitle
    publicationDateLabel.text = publicationDate
    pagesLabel.text = pages
    leadAuthorLabel.text = leadAuthor
    finalPassEditorLabel.text = finalPassEditor
  }
}
