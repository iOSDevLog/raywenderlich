import UIKit

// Original synchronous function
public func tiltShift(image: UIImage?) -> UIImage? {
  guard let image = image else { return .none }
  sleep(1)
  let mask = topAndBottomGradient(size: image.size)
  return image.applyBlur(radius: 6, maskImage: mask)
}
