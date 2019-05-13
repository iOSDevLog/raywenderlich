import UIKit

public class TiltShiftOperation : NSOperation {
  public var inputImage: UIImage?
  public var outputImage: UIImage?
  
  override public func main() {
    guard let inputImage = inputImage else { return }
    let mask = topAndBottomGradient(inputImage.size)
    outputImage = inputImage.applyBlurWithRadius(4, maskImage: mask)
  }
}
