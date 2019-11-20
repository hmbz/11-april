//
//  StatesTableViewCell.swift
//  OgreSpace
//
//  Created by MAC on 23/07/2019.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit

class StatesTableViewCell: UITableViewCell {

  //MARK:- Properties

  @IBOutlet weak var statesImageView: UIImageView!
  
  @IBOutlet weak var statesLbl: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }

}
