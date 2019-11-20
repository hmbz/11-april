//
//  SearchLocationsSuggestions.swift
//  OgreSpace
//
//  Created by MAC on 24/07/2019.
//  Copyright © 2019 brainplow. All rights reserved.
//

import Foundation
import Alamofire
class SearchLocationsSuggestions{
  static let instance = SearchLocationsSuggestions()
//  var addressSuggestion = [String]()
  lazy var status = 0
//  lazy var searchedResultArray = [propertyModel]()
//  var totalPages:Int?
  lazy var header:HTTPHeaders  = [:]
//  func getLocations(url: String,completion:@escaping (Bool) -> ()){
//    print(url)
//    Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
//      
//      print("Request: \(String(describing: response.request))")   // original url request
//      print("Response: \(String(describing: response.response))") // http url response
//      print("Result: \(response.result)")// response serialization result
//      print(response)
//      self.addressSuggestion.removeAll()
//      switch response.result {
//      case .success(let value):
//        guard let suggestionsArray = value as? NSArray else {
//          return
//        }
//        for suggestions in suggestionsArray{
//          guard let suggestionDict = suggestions as? NSDictionary else {
//            return
//          }
//          let addressSuggestion = suggestionDict.value(forKey: "address_suggestion") as? String ?? "N/A"
//          self.addressSuggestion.append(addressSuggestion)
//        }
//        print(self.addressSuggestion)
//        completion(true)
//      case .failure(let error):
//        completion(false)
//        print(error.localizedDescription)
//      }
//
//    
//    }
//  
//}
//  func GeneralSearchCheck(url:String,param:[String:Any],completion:@escaping ([propertyModel], Int, Int, Bool ) -> ()){
//    let token =  UserDefaults.standard.string(forKey: SessionManager.keys.accessToken) ?? ""
//    
//      header = [
//        
//        "Authorization": "JWT \(token)"
//        
//      ]
//    print("header:\(header)")
//
//    print("header:\(header)")
//    print(url,"search url ")
//    print(param)
//    Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
//      var searchResultArray = [propertyModel]()
//      var totalItems = -1
//      var totalPages = -1
//      print("Request: \(String(describing: response.request))")   // original url request
//      print("Response: \(String(describing: response.response))") // http url response
//      print("Result: \(response.result)")// response serialization result
////      self.searchedResultArray.removeAll()
//      switch response.result {
//      case .success(let value):
//        guard let jsonDic = value as? NSDictionary else {
//          return
//        }
//        totalItems = jsonDic["totalItems"] as? Int ?? -1
//        totalPages = jsonDic["totalPages"] as? Int ?? -1
//        guard let jsonArray = jsonDic["results"] as? NSArray else {
//          return
//        }
//        for item in jsonArray {
//          guard let propertyDic = item as? NSDictionary else {return}
//          let id = propertyDic["id"] as? Int ?? -1
//          let propertyTitle = propertyDic["property_title"] as? String ?? "N/A"
//          let propertyType = propertyDic["post_type"] as? String ?? "N/A"
//          let image = propertyDic["one_pic"] as? String ?? "N/A"
//          let price = propertyDic["price"] as? String ?? "N/A"
//          let propertyArea = propertyDic["property_area"] as? String ?? ""
//          let address = propertyDic["address"] as? String ?? "N/A"
//          let latitude = propertyDic["latitude"] as? String ?? "N/A"
//          let longitude = propertyDic["longitude"] as? String ?? "N/A"
//          let postType = propertyDic["post_type"] as? String ?? "N/A"
//          let isFavorite = propertyDic["isfavourite"] as? Bool ?? false
//          let object = propertyModel.init(id: id, Title: propertyTitle, PropertyType: propertyType, image: image, price: price, Area: propertyArea, Address: address, postType: postType, latitude: latitude, longitude: longitude, isFavourite: isFavorite)
//          searchResultArray.append(object)
//
//
//      }
//        print(searchResultArray, "searchResultArray")
//        completion(searchResultArray, totalItems, totalPages, true)
//      case .failure(let error):
//        completion(searchResultArray, totalItems, totalPages, false)
//        print(error.localizedDescription)
//    }
//    
//  }
//}
}
