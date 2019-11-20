//
//  ImprovementHistoryCollectionViewCell.swift
//  OgreSpace
//
//  Created by admin on 11/12/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit

class ImprovementHistoryCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var imprNoLbl: UILabel!
  @IBOutlet weak var areaOfImprLbl: UILabel!
  @IBOutlet weak var imprTypeLbl: UILabel!
  @IBOutlet weak var spaceOfImprLbl: UILabel!
  @IBOutlet weak var imprValueLbl: UILabel!
  @IBOutlet weak var yearOfImprLbl: UILabel!

  func loadData(instance: ImprovementHistoryModel){
    
    self.imprNoLbl.text = instance.improvNo!
    self.areaOfImprLbl.text = instance.areaOfImprov!
    self.imprTypeLbl.text = instance.improvType!
    self.spaceOfImprLbl.text = instance.spaceOfImprov!
    self.imprValueLbl.text = String(describing: instance.improvValue ?? 0)
    self.yearOfImprLbl.text = instance.yearOfImprov!
    
  }
  
  
}
