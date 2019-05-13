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
  var refreshControl: UIRefreshControl!
  
  let courses = ["Beginning iOS Unit and UI Testing", "iOS Concurrency with GCD and Operations", "Networking with NSURLSession", "Introduction Custom Controls", "Beginning iOS Animation"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    refreshControl.backgroundColor = UIColor.green
    tableView.refreshControl = refreshControl
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @objc func refreshData(_ refreshControl: UIRefreshControl) {
    refreshControl.endRefreshing()
  }

  @IBAction func changedColor(_ sender: UISegmentedControl) {
    if sender.selectedSegmentIndex == 0 {
      refreshControl.backgroundColor = UIColor.green
    } else if sender.selectedSegmentIndex == 1 {
      refreshControl.backgroundColor = UIColor.black
    } else {
      refreshControl.backgroundColor = UIColor.blue
    }
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

