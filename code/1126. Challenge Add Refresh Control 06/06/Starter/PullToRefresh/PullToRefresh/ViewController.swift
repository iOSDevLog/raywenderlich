//
//  ViewController.swift
//  PullToRefresh
//
//  Created by Brian on 2/18/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  let courses = ["Beginning iOS Unit and UI Testing", "iOS Concurrency with GCD and Operations", "Networking with NSURLSession", "Introduction Custom Controls", "Beginning iOS Animation"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func refreshData(_ refreshControl: UIRefreshControl) {
    refreshControl.endRefreshing()
  }

  @IBAction func changedColor(_ sender: UISegmentedControl) {
    
  }
  
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 100
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "RefreshCell", for: indexPath)
    cell.textLabel?.text = courses[indexPath.row % 5]
    return cell
  }
  
}

