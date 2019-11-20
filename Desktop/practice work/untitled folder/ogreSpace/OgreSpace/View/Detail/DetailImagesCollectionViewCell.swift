//
//  DetailImagesCollectionViewCell.swift
//  OgreSpace
//
//  Created by MAC on 16/07/2019.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit

class DetailImagesCollectionViewCell: UICollectionViewCell {
    
  @IBOutlet weak var propertyImagesView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
      
      let gradient = CAGradientLayer()
      gradient.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: -70)
      //      let midColor = blend(color1: .clear, color2: .black )
      
      gradient.colors = [UIColor.clear.cgColor,  UIColor.black.cgColor]
      gradient.locations = [0.0, 1.0]
      self.layer.addSublayer(gradient)
      self.layer.cornerRadius = 6
      self.layer.masksToBounds = true
      
    }
    
  }
  
}
