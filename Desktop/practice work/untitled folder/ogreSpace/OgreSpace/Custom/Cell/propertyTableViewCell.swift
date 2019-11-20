//
//  propertyTableViewCell.swift
//  OgreSpace
//
//  Created by admin on 7/1/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit

class propertyTableViewCell: UITableViewCell {
  
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
//    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var areaLbl: UILabel!
    
  @IBOutlet weak var likeBtn: UIButton!
  override func awakeFromNib() {
        super.awakeFromNib()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
      
      let gradient = CAGradientLayer()
      gradient.frame = CGRect(x: 0, y: self.itemImage.frame.height, width: self.itemImage.frame.width, height: -100)
      print("itemImage.frame.width list view", self.itemImage.frame.width)
      gradient.colors = [UIColor.clear.cgColor,  UIColor.black.cgColor]
      gradient.locations = [0.0, 1.0]
      self.itemImage.layer.addSublayer(gradient)
      
    }
  }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
  
  @IBAction func addToFavouritesBtn(_ sender: Any) {
  }
  
  func loadData(item: propertyModel){
    
    guard let itemPrice = item.price else {return}
    guard let itemArea = item.Area else {return}
    guard let imageUrl = item.image else {return}
    self.itemImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: #imageLiteral(resourceName: "appLogo"))
    self.locationLbl.text = item.Address
    self.nameLbl.text = item.Title
    self.priceLbl.text = "$\(itemPrice)"
//    self.typeLbl.text = item.PropertyType
    self.areaLbl.text = "\(itemArea) sqft"
    
    
  }
    
    
}
