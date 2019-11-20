//
//  DesignableStackView.swift
//  OgreSpace
//
//  Created by admin on 9/20/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable
class StackView: UIStackView {
  @IBInspectable private var color: UIColor?
  override var backgroundColor: UIColor? {
    get { return color }
    set {
      color = newValue
      self.setNeedsLayout() // EDIT 2017-02-03 thank you @BruceLiu
    }
  }
  
  private lazy var backgroundLayer: CAShapeLayer = {
    let layer = CAShapeLayer()
    self.layer.insertSublayer(layer, at: 0)
    return layer
  }()
  override func layoutSubviews() {
    super.layoutSubviews()
    backgroundLayer.path = UIBezierPath(rect: self.bounds).cgPath
    backgroundLayer.fillColor = self.backgroundColor?.cgColor
  }
}
