//
//  advanceSearchService.swift
//  OgreSpace
//
//  Created by MAC on 27/07/2019.
//  Copyright © 2019 brainplow. All rights reserved.
//

import Foundation
import Alamofire
class advanceSearchService{
//  static let instance = advanceSearchService()
//  lazy var header:HTTPHeaders = [:]
//  var filteredResultArray = [propertyModel]()
//  var totalPages:Int?
//  lazy var status = 0
//func getFilteredProperties(url:String,param:[String:Any],completion:@escaping CompletionHandler){
//  let token =  UserDefaults.standard.string(forKey: SessionManager.keys.accessToken) ?? ""
//  
//  header = [
//    
//    "Authorization": "JWT \(token)"
//    
//  ]
//  print("header:\(header)")
//  
//  
//  
//  
//  
//  print("header:\(header)")
//  print(url,"search url ")
//  print(param)
//  Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
//    print("Request: \(String(describing: response.request))")   // original url request
//    print("Response: \(String(describing: response.response))") // http url response
//    print("Result: \(response.result)")// response serialization result
//    self.filteredResultArray.removeAll()
//    switch response.result {
//    case .success(let value):
//      guard let jsonDic = value as? NSDictionary else {
//        return
//      }
//      let totalItems = jsonDic["totalItems"] as? Int ?? -1
//      self.totalPages = jsonDic["totalPages"] as? Int ?? -1
//      guard let jsonArray = jsonDic["results"] as? NSArray else {
//        return
//      }
//      for item in jsonArray {
//        guard let propertyDic = item as? NSDictionary else {return}
//        let id = propertyDic["id"] as? Int ?? -1
//        let propertyTitle = propertyDic["property_title"] as? String ?? "N/A"
//        let propertyType = propertyDic["property_type"] as? String ?? "N/A"
//        let image = propertyDic["one_pic"] as? String ?? "N/A"
//        let price = propertyDic["price"] as? String ?? "N/A"
//        let propertyArea = propertyDic["property_area"] as? String ?? ""
//        let address = propertyDic["address"] as? String ?? "N/A"
//        let latitude = propertyDic["latitude"] as? String ?? "N/A"
//        let longitude = propertyDic["longitude"] as? String ?? "N/A"
//        let postType = propertyDic["post_type"] as? String ?? "N/A"
//        let isFavorite = propertyDic["isfavourite"] as? Bool ?? false
//        let object = propertyModel.init(totalItems: totalItems, id: id, Title: propertyTitle, PropertyType: propertyType, image: image, price: price, Area: propertyArea, Address: address, postType: postType, latitude: latitude, longitude: longitude, isFavourite: isFavorite)
//        self.filteredResultArray.append(object)
//        
//        
//      }
//      completion(true)
//    case .failure(let error):
//      completion(false)
//      print(error.localizedDescription)
//    }
//    
//  }
//}
}
