//
//  SearchSuggestionTableViewCell.swift
//  OgreSpace
//
//  Created by MAC on 24/07/2019.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit

class SearchSuggestionTableViewCell: UITableViewCell {

  @IBOutlet weak var searchSuggestionLbl: UILabel!
  
  @IBOutlet weak var searchSuggestionImage: UIImageView!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
