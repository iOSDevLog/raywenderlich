//
//  ViewController.swift
//  TSanExample
//
//  Created by Audrey M Tam on 16/09/2016.
//  Copyright © 2016 Razeware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let nameList = [("Charlie", "Cheesecake"), ("Delia", "Dingle"), ("Eva", "Evershed"), ("Freddie", "Frost"), ("Gina", "Gregory")]
  let workerQueue = DispatchQueue(label: "com.raywenderlich.worker", attributes: .concurrent)

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // TSan finds 6 race condition errors
//    changeNameRace()
    
    // TSan finds no errors
    changeNameSafely()
  }
  
  func changeNameSafely() {
    let threadSafeNameGroup = DispatchGroup()
    
    let threadSafePerson = ThreadSafePerson(firstName: "Anna", lastName: "Adams")
    
    for (idx, name) in nameList.enumerated() {
      workerQueue.async(group: threadSafeNameGroup) {
        usleep(UInt32(10_000 * idx))
        threadSafePerson.changeName(firstName: name.0, lastName: name.1)
        print("Current threadsafe name: \(threadSafePerson.name)")
      }
    }
    
    threadSafeNameGroup.notify(queue: DispatchQueue.main) {
      print("Final threadsafe name: \(threadSafePerson.name)")
    }

  }
  
  func changeNameRace() {
    let nameChangingPerson = Person(firstName: "Alison", lastName: "Anderson")
    let nameChangeGroup = DispatchGroup()
    
    for (idx, name) in nameList.enumerated() {
      workerQueue.async(group: nameChangeGroup) {
        usleep(UInt32(10_000 * idx))
        nameChangingPerson.changeName(firstName: name.0, lastName: name.1)
        print("Current Name: \(nameChangingPerson.name)")
      }
    }
    
    nameChangeGroup.notify(queue: DispatchQueue.main) {
      print("Final name: \(nameChangingPerson.name)")
      //PlaygroundPage.current.finishExecution()
    }
    
    nameChangeGroup.wait()
  }

}

