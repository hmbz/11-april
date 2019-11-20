//
//  ServiceTableViewCell.swift
//  OgreSpace
//
//  Created by admin on 7/29/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {

  
  @IBOutlet weak var serviceNameLabel: UILabel!
  @IBOutlet weak var checkBoxButton: UIButton!
  
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
