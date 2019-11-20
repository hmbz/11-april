//
//  RecentlyViewedProperties.swift
//  OgreSpace
//
//  Created by MAC on 05/08/2019.
//  Copyright © 2019 brainplow. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class RecentlyViewedProperties{
//  static let instance = RecentlyViewedProperties()
//  lazy var status = 0
//  var header:HTTPHeaders = [:]
//  var totalPages:Int?
//  lazy var recentlyPropertyArray = [propertyModel]()
  //TODO:- For Recently Viewed Property Api
//  func RecentlyViewedProperty(url:String,completion:@escaping (Int, Bool) -> ()){
//    let token =  UserDefaults.standard.string(forKey: SessionManager.keys.accessToken) ?? ""
//    header = [
//
//      "Authorization":"JWT " + token
//    ]
//    print(header)
//    var totalItems = -1
//    Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { response in
//
//      print("Request: \(String(describing: response.request))")   // original url request
//      print("Response: \(String(describing: response.response))") // http url response
//      print("Result: \(response.result)")// response serialization result
//      print(response)
//      //      self.salePRopertArray.removeAll()
//      if response.result.error == nil{
//        self.status = (response.response?.statusCode)!
//        print(self.status)
//        guard let data = response.data else {return}
//        do{
//          if let jsonDic = try JSON(data: data).dictionary{
//            totalItems = jsonDic["totalItems"]?.int ?? 0
//            self.totalPages = jsonDic["totalPages"]?.int ?? 0
//            let jsonArray = jsonDic["results"]?.array ?? []
//            for item in jsonArray {
//              guard let propertyDic = item.dictionary else {return}
//              let id = propertyDic["id"]?.int ?? -1
//              let propertyTitle = propertyDic["property_title"]?.string ?? ""
//              let propertyType = propertyDic["property_type"]?.string ?? ""
//              let image = propertyDic["one_pic"]?.string ?? ""
//              let price = propertyDic["price"]?.string ?? "N/A"
//              let propertyArea = propertyDic["property_area"]?.string ?? ""
//              let address = propertyDic["address"]?.string ?? ""
//              let latitude = propertyDic["latitude"]?.string ?? ""
//              let longitude = propertyDic["longitude"]?.string ?? ""
//              let postType = propertyDic["post_type"]?.string ?? ""
//              let isFavorite = propertyDic["isfavourite"]?.bool ?? false
//              let object = propertyModel.init( id: id, Title: propertyTitle, PropertyType: propertyType, image: image, price: price, Area: propertyArea, Address: address, postType: postType, latitude: latitude, longitude: longitude, isFavourite: isFavorite)
//              self.recentlyPropertyArray.append(object)
//            }
//            print(self.recentlyPropertyArray)
//            completion(totalItems, true)
//          }
//        }catch let jsonErr{
//          print(jsonErr)
//        }
//
//      }else{
//        completion(totalItems, false)
//      }
//    }
//  }
}
