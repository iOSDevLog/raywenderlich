/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.


import UIKit

class JournalTableViewController: UITableViewController {
  private var journalEntries: [JournalEntry] = []
  private var deleteEntryIndexPath: IndexPath?
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  @IBAction func refresh() {
    UIAlertController.showError(with: "Need to implement retrieve all function!", on: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "addNewEmojiSegue" {
      guard let addController = segue.destination as? AddEmojiViewController else {
        return
      }
      addController.delegate = self
    }
  }
}

//MARK: - UIAlertController showerror
extension UIAlertController {
  static func showError(with message: String, on controller: UIViewController) {
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(action)
    controller.present(alert, animated: true, completion: nil)
  }
}

// MARK: - Table view data source
extension JournalTableViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return journalEntries.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: JournalTableViewCell.cellIdentifier, for: indexPath) as! JournalTableViewCell
    let entry = journalEntries[indexPath.row]
    cell.emojiLabel.text = entry.emoji
    cell.dateLabel.text = entry.date.displayDate.uppercased()
    cell.timeLabel.text = entry.date.displayTime
    cell.backgroundColor = entry.backgroundColor
    return cell
  }
}

// MARK: - Add Emoji Delegate functions
extension JournalTableViewController: AddEmojiDelegate {
  func didAdd(entry: JournalEntry, from controller: AddEmojiViewController) {
    navigationController?.popToRootViewController(animated: true)
    UIAlertController.showError(with: "Need to implement add function!", on: self)
  }
}

// MARK: - Table view delegate
extension JournalTableViewController {
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      deleteEntryIndexPath = indexPath
      let entry = journalEntries[indexPath.row]
      confirmDelete(entry: entry)
    }
  }
  
  func confirmDelete(entry: JournalEntry) {
    let alert = UIAlertController(title: "Delete Journal Entry", message: "Are you sure you want to delete \(entry.emoji) from your journal?", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: deleteEntryHandler))
    alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { [weak self] action in
      guard let strongSelf = self else {
        return
      }
      strongSelf.deleteEntryIndexPath = nil
    }))
    present(alert, animated: true, completion: nil)
  }
  
  func deleteEntryHandler(action: UIAlertAction) {
    guard let indexPath = deleteEntryIndexPath else {
      deleteEntryIndexPath = nil
      return
    }
    UIAlertController.showError(with: "Need to implement delete function!", on: self)
  }
}

// MARK: - JournalEntry backgroundColor
extension JournalEntry {
  var backgroundColor: UIColor {
    guard let substring = id?.suffix(6).uppercased() else {
      return UIColor(hexString: "000000")
    }
    return UIColor(hexString: substring)
  }
}

// MARK: - UIColor hexString
extension UIColor {
  convenience init(hexString: String, alpha: CGFloat = 1.0) {
    let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    let scanner = Scanner(string: hexString)
    if hexString.hasPrefix("#") {
      scanner.scanLocation = 1
    }
    var color: UInt32 = 0
    scanner.scanHexInt32(&color)
    let mask = 0x000000FF
    let r = Int(color >> 16) & mask
    let g = Int(color >> 8) & mask
    let b = Int(color) & mask
    let red = CGFloat(r) / 255.0
    let green = CGFloat(g) / 255.0
    let blue = CGFloat(b) / 255.0
    self.init(red: red,
              green: green,
              blue: blue,
              alpha: alpha)
  }
  
  func toHexString() -> String {
    var r: CGFloat = 0
    var g: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 0
    getRed(&r, green: &g, blue: &b, alpha: &a)
    let rgb: Int = (Int)(r * 255) << 16 | (Int)(g * 255) << 8 | (Int)(b * 255) << 0
    return String(format:"#%06x", rgb)
  }
}
