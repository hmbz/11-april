//
//  PropertyOverviewTableViewCell.swift
//  OgreSpace
//
//  Created by admin on 11/14/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit

class PropertyOverviewTableViewCell: UITableViewCell {

  @IBOutlet weak var overviewTextView: UITextView!
  
  @IBOutlet weak var overviewLbl: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
