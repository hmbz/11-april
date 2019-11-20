//
//  propertyCollectionViewCell.swift
//  OgreSpace
//
//  Created by admin on 7/3/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import UIKit

class propertyCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var propertyImage: UIImageView!
  @IBOutlet weak var titleLbl: UILabel!
  @IBOutlet weak var locationLbl: UILabel!
  @IBOutlet weak var priceLbl: UILabel!
  @IBOutlet weak var typeLbl: UILabel!
  @IBOutlet weak var areaLbl: UILabel!
  @IBOutlet weak var mainImageHeight: NSLayoutConstraint!
  @IBOutlet weak var cardView: UIView!
  @IBOutlet weak var likeBtn: UIButton!
  
  var unsplashImage: Image? {
    didSet {
      propertyImage.image = UIImage(named: unsplashImage!.id)
    }
    
  }
  
  var favFlag = Bool()
  var favIndex = Int()
  
  var favDelegate: PropertyCellDelegate!
  
    override func awakeFromNib() {
        super.awakeFromNib()
      
      let gradient = CAGradientLayer()
      gradient.frame = CGRect(x: 0, y: propertyImage.frame.height, width: propertyImage.frame.width, height: -70)
//      let midColor = blend(color1: .clear, color2: .black )
      
      gradient.colors = [UIColor.clear.cgColor,  UIColor.black.cgColor]
      gradient.locations = [0.0, 1.0]
      propertyImage.layer.addSublayer(gradient)
      
      cardView.makeRoundedCorners(cornerRadius: 6)
      propertyImage.layer.cornerRadius = 6
      propertyImage.layer.masksToBounds = true
        // Initialization code
    }
  

    func loadData(item: propertyModel){
      
      self.titleLbl.text = item.Title
      self.locationLbl.text = item.Address
      
      let price = item.price!
      print(price)
      
      let floatPrice = Float(price)
//      print(floatPrice)
                let intPrice = Int (floatPrice ?? -1)
      print(intPrice)
      let largeNumber = intPrice
      let numberFormatter = NumberFormatter()
      numberFormatter.numberStyle = .decimal
      let formattedNumber = numberFormatter.string(from: NSNumber(value:largeNumber))
      self.priceLbl.text = "$" + formattedNumber!

  //          let strPrice = String(intPrice)
      
      self.typeLbl.text = "For " + item.postType!
      let area = item.Area!
      print(area)
      self.areaLbl.text = "\(area) Sqrf"
      let nameImage = item.image
      let imageUrlEncoded = nameImage?.replacingOccurrences(of: " ", with: "%20")
      
      self.propertyImage.sd_setImage(with: URL(string: imageUrlEncoded!), placeholderImage: UIImage(named: "appLogo"))
      
//      guard let itemPrice = item.price else {return}
//      guard let itemArea = item.Area else {return}
//      guard let imageUrl = item.image else {return}
//      self.itemImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: #imageLiteral(resourceName: "appLogo"))
//      self.locationLbl.text = item.Address
//      self.nameLbl.text = item.Title
//      self.priceLbl.text = "$\(itemPrice)"
//  //    self.typeLbl.text = item.PropertyType
//      self.areaLbl.text = "\(itemArea) sqft"
      
    }
  
  func getFavoriteInfo(flag: Bool, index:Int){
    
    self.favFlag = flag
    self.favIndex = index
    
  }
  
  @IBAction func addToFavouritesBtn(_ sender: UIButton) {
    
    favDelegate.toggleFavorite(flag: self.favFlag, index:self.favIndex, sender: sender)
    
  }
  

}

protocol PropertyCellDelegate {

  func toggleFavorite(flag: Bool, index:Int, sender: UIButton)

}
