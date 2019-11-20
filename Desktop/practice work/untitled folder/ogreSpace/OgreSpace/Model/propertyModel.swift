//
//  propertyModel.swift
//  OgreSpace
//
//  Created by admin on 7/1/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import Foundation
struct propertyModel {
  
  let id : Int?
  let Title :String?
  let PropertyType: String?
  let image : String?
  let price : String?
  let Area : String?
  let Address: String?
  let postType: String?
  let latitude: String?
  let longitude: String?
  var isFavourite: Bool?
  
}

struct CategoriesModel {
  public private(set) var id:Int
  public private(set) var propertyType:String
  public private(set) var logoOfCategories:String
}
//struct similarModel {
//  let id : Int?
//  let Title :String?
//  let PropertyType: String?
//  let image : String?
//  let price : String?
//  let Area : Float?
//  let Address: String?
//  let postType: String?
//  let latitude: String?
//  let longitude: String?
//}
struct statesModel {
  var id : Int?
  var stateName :String?
  var Icon :String?
}

struct userModel {
  public private(set) var id :Int?
  public private(set) var Fname :String?
  public private(set) var Lname :String?
  public private(set) var Mobile :String?
  public private(set) var username :String?
  public private(set) var email :String?
  public private(set) var userId :Int?
  public private(set) var country :String?
  public private(set) var states :String?
  public private(set) var City :String?
  public private(set) var address :String?
  public private(set) var Pic :String?
}

struct servicesModel{
  
  let serviceId : Int
  let serviceName : String
  let serviceIcon : String
  var isChecked : Bool
  
  
}

struct OverviewModel{
  
  let overviewId : Int
  let overviewName : String
  let overviewIcon : String
  var isChecked : Bool
  
  
}
