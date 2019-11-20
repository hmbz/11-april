//
//  CadTableViewCell.swift
//  OgreSpace
//
//  Created by admin on 11/7/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit

class CadTableViewCell: UITableViewCell {

  @IBOutlet weak var textDataLabel: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      
    }

}
