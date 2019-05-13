/**
 * Copyright (c) 2018 Razeware LLC
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

// Note: FruitDisplayTableViewController is intended to be used as an embedded view controller
class FruitDisplayTableViewController: UITableViewController {
  private var fruits: [Fruit] = []
  private var calories = 0.0

  func configure(calories: Double, fruits: [Fruit]) {
    self.fruits = fruits
    self.calories = calories
    tableView.reloadData()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    // Update fruits since calories may have changed in settings
    fruits = FruitStore.fruits.sorted { $0.name < $1.name }
    tableView.reloadData()
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let fruitCell = tableView.dequeueReusableCell(withIdentifier: "FruitCell", for: indexPath) as! FruitDiplayCell
    let fruit = fruits[indexPath.section]
    let requiredFruitCount = calories / fruit.calories

    // Can't really buy 1.5 apples so round up to the next value
    fruitCell.configure(fruit: fruit, count: Int(ceil(requiredFruitCount)))
    return fruitCell
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return fruits.count
  }

  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let fruit = fruits[section]
    let requiredFruitCount = calories / fruit.calories
    let countString = Formatter.string(from: requiredFruitCount)
    return "\(fruit.pluralizedName) (\(countString))"
  }
}
