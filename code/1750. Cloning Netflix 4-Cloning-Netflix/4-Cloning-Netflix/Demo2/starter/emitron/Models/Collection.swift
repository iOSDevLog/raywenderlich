/*
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
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import RealmSwift
import Realm

class Collection: Content {
  let videos = List<Video>()
  dynamic var videoCount: Int = 0
  private lazy var viewings: Results<Viewing> = realm!.objects(Viewing.self).filter("rawCollectionId = %@", id)
  
  override static func ignoredProperties() -> [String] {
    return ["viewings", "viewingsChangeToken", "progressChangedCallback"]
  }
  
  // TODO: Add Decodable conformance
}


extension Collection: CardViewModel {
  func observeProgressChange(callback: @escaping (ProgressChange) -> ()) -> NotificationToken {
    return viewings.observe({ changes  in
      switch changes {
      case .update(let results, deletions: _, insertions: _, modifications: _):
        if results.count > 0 {
          callback(.changed)
        } else {
          callback(.deleted)
        }
      case .initial:
        callback(.changed)
      default:
        callback(.deleted)
      }
    })
  }
  
  var imageURL: URL? {
    guard let urlString = attachments.filter("retina == true && rawKind == %@", Attachment.Kind.card_artwork.rawValue).first?.url else { return .none }
    return URL(string: urlString)
  }
  
  dynamic var proportionComplete: Double {
    guard videoCount != 0 else { return 0 }
    return Double(viewings.filter("finished == true").count) / Double (videoCount)
  }
  
  var complete: Bool {
    guard videoCount != 0 else { return false }
    return viewings.filter("finished == true").count == videoCount
  }
}
