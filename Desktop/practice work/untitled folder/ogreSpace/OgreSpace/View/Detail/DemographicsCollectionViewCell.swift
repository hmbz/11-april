//
//  DemographicsCollectionViewCell.swift
//  OgreSpace
//
//  Created by admin on 9/6/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit

class DemographicsCollectionViewCell: UICollectionViewCell {
  
  
  @IBOutlet weak var categoryImage: UIImageView!
  
  @IBOutlet weak var categoryLabel: UILabel!
  
  override var isSelected: Bool {
    didSet{
      if self.isSelected {
        self.backgroundColor = .lightGray
      }
      else {
        self.backgroundColor = .white
      }
    }
  }
  
}
