//
//  CategoriesService.swift
//  OgreSpace
//
//  Created by MAC on 25/07/2019.
//  Copyright © 2019 brainplow. All rights reserved.
//

import Foundation
import Alamofire
class CategoriesService{
  static let instance = CategoriesService()
//  var categoriesModelArray = [CategoriesModel]()
  var header:HTTPHeaders = [:]
  var totalPages:Int?
  lazy var categoryResultArray = [propertyModel]()

//  func getAllCategories(completion:@escaping (Bool) -> ()){
//    let categoryUrl = CategoriesUrl
//    print(categoryUrl)
//    Alamofire.request(categoryUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
//
//      print("Request: \(String(describing: response.request))")   // original url request
//      print("Response: \(String(describing: response.response))") // http url response
//      print("Result: \(response.result)")// response serialization result
//      print(response)
//      switch response.result{
//      case .success(let value):
//        guard let categoriesArray = value as? NSArray else {
//          return
//        }
//        for categories in categoriesArray {
//          guard let categoryDict = categories as? NSDictionary else{
//            return
//          }
//          let id = categoryDict.value(forKey: "id") as? Int ?? -1
//          let propertyType = categoryDict.value(forKey: "Property_type") as? String ?? "N/A"
//          let categoryLogo = categoryDict.value(forKey: "logo_of_categories") as? String ?? "N/A"
//          let categoryModelObj = CategoriesModel(id: id, propertyType: propertyType, logoOfCategories: categoryLogo)
//
//          self.categoriesModelArray.append(categoryModelObj)
//        }
//        print(self.categoriesModelArray)
//        completion(true)
//      case .failure(let error):
//        debugPrint(error.localizedDescription)
//        completion(false)
//      }
//
//    }
//  }
  
  func CategoriesDetailAPI(url:String,param:[String:Any],completion:@escaping (Int, Bool) -> ()){
    let token =  UserDefaults.standard.string(forKey: SessionManager.keys.accessToken) ?? ""
    
    header = [
      
      "Authorization": "JWT \(token)"
      
    ]
    print("header:\(header)")
    
    
    
    
    
    print("header:\(header)")
    print(url,"search url ")
    print(param)
    var totalItems = -1
    Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
      print("Request: \(String(describing: response.request))")   // original url request
      print("Response: \(String(describing: response.response))") // http url response
      print("Result: \(response.result)")// response serialization result
      self.categoryResultArray.removeAll()
      switch response.result {
      case .success(let value):
        guard let jsonDic = value as? NSDictionary else {
          return
        }
        totalItems = jsonDic["totalItems"] as? Int ?? -1
        self.totalPages = jsonDic["totalPages"] as? Int ?? -1
        guard let jsonArray = jsonDic["results"] as? NSArray else {
          return
        }
        for item in jsonArray {
          guard let propertyDic = item as? NSDictionary else {return}
          let id = propertyDic["id"] as? Int ?? -1
          let propertyTitle = propertyDic["property_title"] as? String ?? "N/A"
          let propertyType = propertyDic["property_type"] as? String ?? "N/A"
          let image = propertyDic["one_pic"] as? String ?? "N/A"
          let price = propertyDic["price"] as? String ?? "N/A"
          let propertyArea = propertyDic["property_area"] as? String ?? ""
          let address = propertyDic["address"] as? String ?? "N/A"
          let latitude = propertyDic["latitude"] as? String ?? "N/A"
          let longitude = propertyDic["longitude"] as? String ?? "N/A"
          let postType = propertyDic["post_type"] as? String ?? "N/A"
          let isFavorite = propertyDic["isfavourite"] as? Bool ?? false
          let object = propertyModel.init(id: id, Title: propertyTitle, PropertyType: propertyType, image: image, price: price, Area: propertyArea, Address: address, postType: postType, latitude: latitude, longitude: longitude, isFavourite: isFavorite)
          self.categoryResultArray.append(object)
          
          
        }
        completion(totalItems, true)
      case .failure(let error):
        completion(totalItems, false)
        print(error.localizedDescription)
      }
      
    }
  }
}
