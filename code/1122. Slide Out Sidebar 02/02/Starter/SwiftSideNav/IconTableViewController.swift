/*
* Copyright (c) 2015 Razeware LLC
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
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

protocol IconTableViewControllerDelegate: class {
  func iconTableViewControllerDidTapMenuButton(_ controller: IconTableViewController)
}

class IconTableViewController: UITableViewController {
  weak var delegate: IconTableViewControllerDelegate?
  var iconSet: IconSet!

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    navigationItem.title = iconSet.name
  }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return iconSet.icons.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell", for: indexPath) as UITableViewCell
    let icon = iconSet.icons[indexPath.row]

    cell.textLabel?.text = icon.title
    cell.detailTextLabel?.text = icon.subtitle
    cell.imageView?.image = icon.image

    return cell
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowIcon" {
      let dest = segue.destination as! IconViewController
      if let indexPath = tableView.indexPathForSelectedRow {
        let icon = iconSet.icons[indexPath.row]
        dest.image = icon.image
        dest.title = icon.title
      }
    }
  }

  @IBAction func menuButtonTapped(_ sender: AnyObject) {
    delegate?.iconTableViewControllerDidTapMenuButton(self)
  }
}
