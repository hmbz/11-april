//
//  PropertyValueCollectionViewCell.swift
//  OgreSpace
//
//  Created by admin on 11/11/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit

class PropertyValueCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var appraisedValueLbl: UILabel!
  @IBOutlet weak var assessedValueLbl: UILabel!
  @IBOutlet weak var improvedValueLbl: UILabel!
  @IBOutlet weak var landValueLbl: UILabel!
  @IBOutlet weak var marketValueLbl: UILabel!
  @IBOutlet weak var propertyValueLbl: UILabel!
  @IBOutlet weak var yearLbl: UILabel!
  
  
  func loadData(instance: PropertyValueModel){
    
    self.appraisedValueLbl.text = String(describing: instance.appraisedValue!)
    self.assessedValueLbl.text = String(describing: instance.assessedValue!)
    self.improvedValueLbl.text = String(describing: instance.improvValue!)
    self.landValueLbl.text = String(describing: instance.landValue!)
    self.marketValueLbl.text = String(describing: instance.marketValue!)
    self.propertyValueLbl.text = String(describing: instance.propertyInform!)
    self.yearLbl.text = instance.valueYear!
    
  }
  
}
