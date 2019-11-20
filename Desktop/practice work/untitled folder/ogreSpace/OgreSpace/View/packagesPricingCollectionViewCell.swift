//
//  packagesPricingCollectionViewCell.swift
//  OgreSpace
//
//  Created by MAC on 05/08/2019.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit

class packagesPricingCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var packagesCollectionView: UIView!
  @IBOutlet weak var planLbl: UILabel!
  @IBOutlet weak var priceLbl: UILabel!
  @IBOutlet weak var seeMoreButton: UIButton!
  @IBOutlet weak var RegisterBtn: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    packagesCollectionView.makeRoundedCorners(cornerRadius: 8)
    
    // Initialization code
  }
}
