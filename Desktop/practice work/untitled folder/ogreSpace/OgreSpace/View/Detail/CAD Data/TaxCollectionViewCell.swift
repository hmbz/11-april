//
//  TaxCollectionViewCell.swift
//  OgreSpace
//
//  Created by admin on 11/12/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit

class TaxCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var taxCollectedLbl: UILabel!
  @IBOutlet weak var taxEntityLbl: UILabel!
  @IBOutlet weak var taxRateLbl: UILabel!
  
    func loadData(instance: TaxModel){
      
      self.taxCollectedLbl.text = instance.collectingEntity!
      self.taxEntityLbl.text = instance.taxEntity!
      self.taxRateLbl.text = String(describing: instance.taxRate!) 

      
    }

}
