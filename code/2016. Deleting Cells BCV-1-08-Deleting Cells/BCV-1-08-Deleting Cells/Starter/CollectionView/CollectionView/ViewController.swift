//
//  ViewController.swift
//  CollectionView
//
//  Created by Brian on 7/13/18.
//  Copyright © 2018 Razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet private weak var collectionView: UICollectionView!

  var collectionData = ["1🏆" , "2 🐸", "3 🍩", "4 😸", "5 🤡", "6 👾", "7 👻",
                        "8 🍖", "9 🎸", "10 🐯", "11 🐷", "12 🌋"]

  @IBAction func addItem() {
    collectionView.performBatchUpdates({
      for _ in 0 ..< 2 {
        let text = "\(collectionData.count + 1) 😸"
        collectionData.append(text)
        let indexPath = IndexPath(row: collectionData.count - 1, section: 0)
        collectionView.insertItems(at: [indexPath])
      }
    }, completion: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let width = (view.frame.size.width - 20) / 3
    let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    layout.itemSize = CGSize(width: width, height: width)
    
    let refresh = UIRefreshControl()
    refresh.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
    collectionView.refreshControl = refresh
  }

  @objc func refresh() {
    addItem()
    collectionView.refreshControl?.endRefreshing()
  }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return collectionData.count
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
    if let label = cell.viewWithTag(100) as? UILabel {
      label.text = collectionData[indexPath.row]
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    performSegue(withIdentifier: "DetailSegue", sender: indexPath)
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  
    if segue.identifier == "DetailSegue" {
      if let dest = segue.destination as? DetailViewController, let index = sender as? IndexPath {
      
        dest.selection = collectionData[index.row]
      }
    }
  
  }
  
  
}

