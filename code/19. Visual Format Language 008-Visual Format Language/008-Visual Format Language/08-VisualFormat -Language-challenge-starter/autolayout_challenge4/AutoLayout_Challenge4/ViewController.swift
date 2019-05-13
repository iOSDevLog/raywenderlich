//
//  ViewController.swift
//  AutoLayout_Challenge4
//
//  Created by Brian Moakley on 1/21/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var bookTitleLabel: UILabel!
  @IBOutlet weak var publicationDateLabel: UILabel!
  @IBOutlet weak var pagesLabel: UILabel!
  @IBOutlet weak var leadAuthorLabel: UILabel!
  @IBOutlet weak var finalPassEditorLabel: UILabel!
  
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
