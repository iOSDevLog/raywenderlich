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
import CoreSpotlight
import MobileCoreServices

extension Product {
  var searchableAttributeSet : CSSearchableItemAttributeSet {
    let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeContent as String)
    attributeSet.contentDescription = details
    attributeSet.title = name
    attributeSet.displayName = name
    attributeSet.keywords = [name, "fruit", "shopping", "greengrocer"]
    if let thumbnail = UIImage(named: "\(photoName)_thumb") {
      attributeSet.thumbnailData = UIImageJPEGRepresentation(thumbnail, 0.7)
    }
    return attributeSet
  }
}


private var dateFormatter : NSDateFormatter = {
  let df = NSDateFormatter()
  df.dateStyle = .ShortStyle
  return df
  }()

extension ShoppingList {
  var searchableAttributeSet : CSSearchableItemAttributeSet {
    let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeContent as String)
    attributeSet.contentDescription = "A shopping list created for \(dateFormatter.stringFromDate(date))"
    attributeSet.contentCreationDate = date
    attributeSet.displayName = name
    attributeSet.keywords = products.map { $0.name } + ["shopping list", "greengrocer"]
    if let thumbnail = UIImage(named: "fruit_basket") {
      attributeSet.thumbnailData = UIImageJPEGRepresentation(thumbnail, 0.7)
    }
    return attributeSet
  }
  
  var searchableItem : CSSearchableItem {
    let item = CSSearchableItem(uniqueIdentifier: id.UUIDString, domainIdentifier: shoppingListDomainID, attributeSet: searchableAttributeSet)
    return item
  }

}



extension DataStore {
  func indexAllShoppingLists() {
    indexShoppingLists(shoppingLists)
  }
  
  func indexShoppingLists(shoppingLists: [ShoppingList]) {
    let shoppingListItems = shoppingLists.map { $0.searchableItem }
    CSSearchableIndex.defaultSearchableIndex().indexSearchableItems(shoppingListItems) {
      error in
      if let error = error {
        print("Error indexing shopping lists: \(error.localizedDescription)")
      } else {
        print("Indexing shopping lists successful")
      }
    }
  }
  
  func removeShoppingListsFromIndex(shoppingLists: [ShoppingList]) {
    let idsToDelete = shoppingLists.map { $0.id.UUIDString }
    
    CSSearchableIndex.defaultSearchableIndex().deleteSearchableItemsWithIdentifiers(idsToDelete) {
      error in
      if let error = error {
        print("Error deleting shopping lists: \(error.localizedDescription)")
      } else {
        print("Successfully deleted shopping lists")
      }
    }
  }
}
