//
//  paymentCardTableViewCell.swift
//  OgreSpace
//
//  Created by MAC on 31/07/2019.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit

class paymentCardTableViewCell: UITableViewCell {
  
  @IBOutlet weak var cardHolderLbl: UILabel!
  
  @IBOutlet weak var cardNumberLbl: UILabel!
  
  @IBOutlet weak var cvvLbl: UILabel!
  
  @IBOutlet weak var expiryDateLbl: UILabel!
  
  @IBOutlet weak var deleteBtn: UIButton!
  
  @IBOutlet weak var editBtn: UIButton!
  
  @IBOutlet weak var cardView: UIView!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
