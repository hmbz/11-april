//
//  CategoriesTableViewCell.swift
//  OgreSpace
//
//  Created by MAC on 23/07/2019.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

  @IBOutlet weak var categoriesLbl: UILabel!
  
  @IBOutlet weak var categoryImageView: UIImageView!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
