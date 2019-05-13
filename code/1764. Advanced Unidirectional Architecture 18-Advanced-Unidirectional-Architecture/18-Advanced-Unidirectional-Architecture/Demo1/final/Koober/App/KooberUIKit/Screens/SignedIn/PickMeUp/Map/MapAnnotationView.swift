/**
 * Copyright (c) 2017 Razeware LLC
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
import MapKit
import PromiseKit

class MapAnnotationView: MKAnnotationView {
  let imageCache: ImageCache
  private var lastAnnotation: MapAnnotation

  var mapAnnotation: MapAnnotation? {
    if let a = annotation as? MapAnnotation {
      return a
    } else if annotation != nil {
      assertionFailure("Property Access Error: MapAnnotationView holds a non-nil annotation of an unsupported type. Expecting MapAnnotation, have \(type(of: annotation))")
      return nil
    } else {
      return nil
    }
  }

  override var annotation: MKAnnotation? {
    didSet {
      if annotation == nil { return }

      guard let new = annotation as? MapAnnotation else {
        assertionFailure("Type Mismatch Error: MapAnnotationView was given an annotation of type \(type(of: annotation)) rather than expected type, MapAnnotation.")
        return
      }
      assert(lastAnnotation.imageIdentifier == new.imageIdentifier)
      lastAnnotation = new
    }
  }

  @nonobjc
  init(annotation: MapAnnotation, reuseIdentifier: String, imageCache: ImageCache) {
    self.imageCache = imageCache
    self.lastAnnotation = annotation
    super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    if let imageName = annotation.imageName {
      self.image = UIImage(named: imageName)
    }
    if let imageURL = annotation.imageURL {
      let annotationIDAndType = (id: annotation.id, type: annotation.type)
      firstly {
        self.imageCache.getImage(at: imageURL)
      }.then { (image) -> Void in
        guard annotationIDAndType.id == self.mapAnnotation?.id
              && annotationIDAndType.type == self.mapAnnotation?.type else {
          return
        }
        self.image = image
      }.catch { error in
        print("Error fetching available ride image from image cache for map annotation: \(error)")
        guard annotationIDAndType.id == self.mapAnnotation?.id
          && annotationIDAndType.type == self.mapAnnotation?.type else {
            return
        }
        self.image = #imageLiteral(resourceName: "available_placeholder_marker")
      }
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("MapAnnotationView does not support instantiation via NSCoding.")
  }
  
}
