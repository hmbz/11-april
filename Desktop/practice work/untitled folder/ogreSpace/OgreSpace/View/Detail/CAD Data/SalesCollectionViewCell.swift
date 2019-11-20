//
//  SalesCollectionViewCell.swift
//  OgreSpace
//
//  Created by admin on 11/12/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit

class SalesCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var buyerNameLbl: UILabel!
  @IBOutlet weak var sellerNameLbl: UILabel!
  @IBOutlet weak var deedDateLbl: UILabel!
  @IBOutlet weak var instructionNoLbl: UILabel!
  
  
  func loadData(instance: SalesModel){
    
    self.buyerNameLbl.text = instance.buyerName!
    self.sellerNameLbl.text = instance.sellerName!
    self.deedDateLbl.text = instance.deedDate!
    self.instructionNoLbl.text = instance.instructionNo!
    
  }
    
}
