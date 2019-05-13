//
//  RoundedView.swift
//  RWBooks
//
//  Created by Caroline Begbie on 16/11/2015.
//  Copyright © 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedView: UIView {

  override func layoutSubviews() {
    super.layoutSubviews()
    let shapeLayer = CAShapeLayer()
    
    shapeLayer.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.TopLeft, .TopRight], cornerRadii: CGSize(width: 30.0, height: 30.0)).CGPath
    layer.mask = shapeLayer
  }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
