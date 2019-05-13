import UIKit

class MainViewController: UICollectionViewController {
	@IBOutlet private weak var addButton:UIBarButtonItem!
	@IBOutlet private weak var deleteButton:UIBarButtonItem!
	
	private let dataSource = DataSource()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Set up a 3-column Collection View
		let width = view.frame.size.width / 3
		let layout = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
		layout.itemSize = CGSize(width:width, height:width)
    layout.sectionHeadersPinToVisibleBounds = true
		// Refresh control
		let refresh = UIRefreshControl()
		refresh.addTarget(self, action: #selector(self.refresh), for: UIControl.Event.valueChanged)
		collectionView?.refreshControl = refresh
		// Toolbar
		navigationController?.isToolbarHidden = true
		// Edit
		navigationItem.leftBarButtonItem = editButtonItem
    installsStandardGestureForInteractiveMovement = true
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "DetailSegue" {
			if let dest = segue.destination as? DetailViewController {
				dest.park = sender as? Park
			}
		}
	}
	
	override func setEditing(_ editing: Bool, animated: Bool) {
		super.setEditing(editing, animated: animated)
		addButton.isEnabled = !editing
		collectionView?.allowsMultipleSelection = editing
    collectionView.indexPathsForSelectedItems?.forEach {
      collectionView.deselectItem(at: $0, animated: false)
    }
  
    if !editing {
			navigationController?.isToolbarHidden = true
		}
		guard let indexes = collectionView?.indexPathsForVisibleItems else {
			return
		}
		for index in indexes {
			let cell = collectionView?.cellForItem(at: index) as! CollectionViewCell
			cell.isEditing = editing
		}
	}
	
	@IBAction func addItem() {
		let index = dataSource.indexPathForNewRandomPark()
    let layout = collectionView?.collectionViewLayout as! FlowLayout
    layout.addedItem = index
    UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.0, options: [], animations: {
      self.collectionView?.insertItems(at: [index])
    }) { finished in
      layout.addedItem = nil
    }
    
    
	}
	
	@objc func refresh() {
		addItem()
		collectionView?.refreshControl?.endRefreshing()
	}
	
	@IBAction func deleteSelected() {
		if let selected = collectionView?.indexPathsForSelectedItems {
      let layout = collectionView?.collectionViewLayout as! FlowLayout
      layout.deletedItems = selected
      dataSource.deleteItemsAtIndexPaths(selected)
			collectionView?.deleteItems(at: selected)
			navigationController?.isToolbarHidden = true
		}
	}
}

extension MainViewController {
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return dataSource.numberOfParksInSection(section)
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
		cell.park = dataSource.parkForItemAtIndexPath(indexPath)
		cell.isEditing = isEditing
		
		return cell
	}
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if !isEditing {
			let park = dataSource.parkForItemAtIndexPath(indexPath)
			performSegue(withIdentifier: "DetailSegue", sender: park)
		} else {
			navigationController?.isToolbarHidden = false
		}
	}
	
	override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
		if isEditing {
			if let selected = collectionView.indexPathsForSelectedItems, selected.count == 0 {
				navigationController?.isToolbarHidden = true
			}
		}
	}
 
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return dataSource.numberOfSections
  }
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

    let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! SectionHeader
    let section = Section()
    section.title = dataSource.titleForSectionAtIndexPath(indexPath)
    section.count = dataSource.numberOfParksInSection(indexPath.section)
    view.section = section
    return view

  }
  
  override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
  
    dataSource.moveParkAtIndexPath(sourceIndexPath, toIndexPath: destinationIndexPath)

  }
 
}
