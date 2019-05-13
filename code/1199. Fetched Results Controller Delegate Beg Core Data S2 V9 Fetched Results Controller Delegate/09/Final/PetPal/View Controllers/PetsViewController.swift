/**
* Copyright (c) 2017 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Notwithstanding the foregoing, you may not use, copy, modify, merge, publish, 
* distribute, sublicense, create a derivative work, and/or sell copies of the 
* Software in any work that is designed, intended, or marketed for pedagogical or 
* instructional purposes related to programming, coding, application development, 
* or information technology.  Permission for such use, copying, modification,
* merger, publication, distribution, sublicensing, creation of derivative works, 
* or sale is expressly withheld.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit
import CoreData

class PetsViewController: UIViewController {
	@IBOutlet private weak var collectionView:UICollectionView!
	
	var friend: Friend!
	private var fetchedRC: NSFetchedResultsController<Pets>!
	private var query = ""
	private let appDelegate = UIApplication.shared.delegate as! AppDelegate
	private let context = (UIApplication.shared.delegate  as! AppDelegate).persistentContainer.viewContext
	private let formatter = DateFormatter()

	private var isFiltered = false
	private var filtered = [String]()
	private var selected:IndexPath!
	private var picker = UIImagePickerController()
	
	
	@IBAction func handleLongPress(gr: UIGestureRecognizer) {
    if gr.state != .ended {
      return
    }
    let p = gr.location(in: collectionView)
    if let indexPath = collectionView.indexPathForItem(at: p) {
      let pet = fetchedRC.object(at: indexPath)
      context.delete(pet)
      appDelegate.saveContext()
      refresh()
      collectionView.deleteItems(at: [indexPath])
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    refresh()
	}

    override func viewDidLoad() {
        super.viewDidLoad()
      picker.delegate = self
      formatter.dateFormat = "d MMM yyyy"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
  private func refresh() {
    let request = Pets.fetchRequest() as NSFetchRequest<Pets>
    if query.isEmpty {
      request.predicate = NSPredicate(format: "owner = %@", friend)
    } else {
      request.predicate = NSPredicate(format: "name CONTAINS[cd] %@ AND owner = %@", query, friend)
    }
    let sort = NSSortDescriptor(key: #keyPath(Pets.name), ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
    request.sortDescriptors = [sort]
    do {
      fetchedRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
      try fetchedRC.performFetch()
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
  }
	
	// MARK:- Actions
	@IBAction func addPet() {
		let data = PetData()
    let pet = Pets(entity: Pets.entity(), insertInto: context)
    pet.name = data.name
    pet.kind = data.kind
    pet.dob = data.dob as NSDate
    pet.owner = friend
    appDelegate.saveContext()
    refresh()
    collectionView.reloadData()
	}
}

// Collection View Delegates
extension PetsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		guard let pets = fetchedRC.fetchedObjects else { return 0 }
    return pets.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PetCell", for: indexPath) as! PetCell
    let pet = fetchedRC.object(at: indexPath)
    cell.nameLabel.text = pet.name
    cell.animalLabel.text = pet.kind
    if let dob = pet.dob as Date? {
      cell.dobLabel.text = formatter.string(from: dob)
    } else {
      cell.dobLabel.text = "Unknown"
    }
    if let data = pet.picture as Data? {
      cell.pictureImageView.image = UIImage(data:data)
    } else {
      cell.pictureImageView.image = UIImage(named: "pet-placeholder")
    }

		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		selected = indexPath
    self.navigationController?.present(picker, animated: true, completion: nil)
	}
}

// Search Bar Delegate
extension PetsViewController:UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let txt = searchBar.text else {
			return
		}
    query = txt
    refresh()
		searchBar.resignFirstResponder()
		collectionView.reloadData()
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		query = ""
		searchBar.text = nil
		searchBar.resignFirstResponder()
    refresh()
		collectionView.reloadData()
	}
}

// Image Picker Delegates
extension PetsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    let image = info[UIImagePickerControllerOriginalImage] as! UIImage
		collectionView?.reloadItems(at: [selected])
    let pet = fetchedRC.object(at: selected)
    pet.picture = UIImagePNGRepresentation(image) as NSData?
    appDelegate.saveContext()
		picker.dismiss(animated: true, completion: nil)
	}
}
