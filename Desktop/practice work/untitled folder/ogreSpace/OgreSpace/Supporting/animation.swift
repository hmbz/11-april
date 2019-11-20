//
//  animation.swift
//  OgreSpace
//
//  Created by Ehtisham on 6/29/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import Foundation
import UIKit
import Toast_Swift
//MARK:- Button
extension UIButton {
    
    //TODO:- creating the shadow for the button
    func applyShadowOnRoundedBlackButton(backColor: UIColor, titleColor : UIColor) {
        // applying the color
        
        setTitleColor(titleColor, for: .normal)
        backgroundColor = backColor
        titleLabel?.font    = Env.iPad ? Fonts.boldPad : Fonts.boldPhone
        
        // applying the shadow
      let cornerRadius = self.layer.frame.height / 2
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.layer.cornerRadius = cornerRadius

    }
    
    func shake() {
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
    
}

//MARK:- UIView
extension UIView {
    
    //TODO:- creating the shadow for the UIView
  func makeRoundedCorners(cornerRadius: CGFloat) {
        // applying the shadow
//      let cornerRadius = self.layer.bounds.height / 2
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.layer.cornerRadius = cornerRadius
    }
  func addShadow() {
    // applying the shadow
    self.layer.shadowRadius = 2
    self.layer.shadowOpacity = 1
    self.layer.shadowOffset = CGSize(width: 1, height: 1)
    self.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    self.layer.cornerRadius = 8
  }
  func round (conerRadius: CGFloat) {
    
    layer.masksToBounds = true
    
  }
  
    
}
extension UIImage {
    
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
}


extension UITextField {
    
    func shake() {
      
      let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
      animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
      animation.duration = 0.6
      animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
      layer.add(animation, forKey: "shake")
    
  }
}

//func blend(color1: UIColor, intensity1: CGFloat = 0.5, color2: UIColor, intensity2: CGFloat = 0.5) -> UIColor {
//  let total = intensity1 + intensity2
//  let l1 = intensity1/total
//  let l2 = intensity2/total
//  guard l1 > 0 else { return color2}
//  guard l2 > 0 else { return color1}
//  var (r1, g1, b1, a1): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
//  var (r2, g2, b2, a2): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
//  
//  color1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
//  color2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
//  
//  return UIColor(red: l1*r1 + l2*r2, green: l1*g1 + l2*g2, blue: l1*b1 + l2*b2, alpha: l1*a1 + l2*a2)
//}


//func blend(colors: [UIColor]) -> UIColor {
//  let componentsSum = colors.reduce((red: CGFloat(0), green: CGFloat(0), blue: CGFloat(0))) { (temp, color) in
//    guard let components = color.cgColor.components else { return temp }
//    return (temp.0 + components[0], temp.1 + components[1], temp.2 + components[2])
//  }
//  let components = (red: componentsSum.red / CGFloat(colors.count) ,
//                    green: componentsSum.green / CGFloat(colors.count),
//                    blue: componentsSum.blue / CGFloat(colors.count))
//  return UIColor(red: components.red, green: components.green, blue: components.blue, alpha: 1)
//}
