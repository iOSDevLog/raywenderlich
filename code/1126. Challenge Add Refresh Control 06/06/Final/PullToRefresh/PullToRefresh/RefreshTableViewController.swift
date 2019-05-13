//
//  RefreshTableViewController.swift
//  PullToRefresh
//
//  Created by Brian on 2/18/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

class RefreshTableViewController: UITableViewController {

  let courses = ["Beginning iOS Unit and UI Testing", "iOS Concurrency with GCD and Operations", "Networking with NSURLSession", "Introduction Custom Controls", "Beginning iOS Animation"]
  
  override func viewDidLoad() {
      super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "RefreshCell", for: indexPath)
    cell.textLabel?.text = courses[indexPath.row % 5]
    return cell
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
      return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 100
  }

}
