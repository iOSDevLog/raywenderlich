//
//  MapOptionsViewController.swift
//  Park View
//
//  Created by Niv Yahel on 2014-11-09.
//  Copyright (c) 2014 Chris Wagner. All rights reserved.
//

import UIKit

enum MapOptionsType: Int {
  case MapBoundary = 0
  case MapOverlay
  case MapPins
  case MapCharacterLocation
  case MapRoute
}

class MapOptionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var selectedOptions = [MapOptionsType]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell")! as UITableViewCell
    let mapOptionsType = MapOptionsType(rawValue: indexPath.row)
    switch (mapOptionsType!) {
    case .MapBoundary:
      cell.textLabel!.text = "Park Boundary"
    case .MapOverlay:
      cell.textLabel!.text = "Map Overlay"
    case .MapPins:
      cell.textLabel!.text = "Attraction Pins"
    case .MapCharacterLocation:
      cell.textLabel!.text = "Character Location"
    case .MapRoute:
      cell.textLabel!.text = "Route"
    }
    
    if selectedOptions.contains(mapOptionsType!) {
      cell.accessoryType = UITableViewCell.AccessoryType.checkmark
    } else {
      cell.accessoryType = UITableViewCell.AccessoryType.none
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath as IndexPath)
    let mapOptionsType = MapOptionsType(rawValue: indexPath.row)
    if (cell!.accessoryType == UITableViewCell.AccessoryType.checkmark) {
      cell!.accessoryType = UITableViewCell.AccessoryType.none
      // delete object
      selectedOptions = selectedOptions.filter { (currentOption) in currentOption != mapOptionsType}
    } else {
      cell!.accessoryType = UITableViewCell.AccessoryType.checkmark
      selectedOptions += [mapOptionsType!]
    }
    
    tableView.deselectRow(at: indexPath as IndexPath, animated: true)
  }
  
}
