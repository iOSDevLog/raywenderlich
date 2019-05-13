import UIKit

class EditTableViewController: UITableViewController {
  
  var bug: ScaryBug?
  @IBOutlet weak var bugImageView: UIImageView!
  @IBOutlet weak var bugNameTextField: UITextField!
  @IBOutlet weak var bugRatingLabel: UILabel!
  
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    guard let bug = bug else {
      return
    }
    if let bugImage = bug.image {
      bugImageView.image = bugImage
    }
    bugNameTextField.text = bug.name
    bugRatingLabel.text = ScaryBug.scaryFactorToString(bug.howScary)
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    bug?.image = bugImageView.image
    bug?.name = bugNameTextField.text!
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if indexPath.row == 0 && indexPath.section == 0 {
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
      let picker = UIImagePickerController()
      picker.sourceType = .PhotoLibrary
      picker.allowsEditing = false
      picker.delegate = self
      presentViewController(picker, animated: true, completion: nil)
    }
  }
  
}

extension EditTableViewController: UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
      bug?.image = image
      bugImageView.image = image
      dismissViewControllerAnimated(true, completion: nil)
    }
    
  }
}