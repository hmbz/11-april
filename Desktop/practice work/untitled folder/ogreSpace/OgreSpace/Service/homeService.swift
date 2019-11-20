//
//  homeService.swift
//  OgreSpace
//
//  Created by admin on 7/1/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class homeService {
  
  static let instance = homeService()
  lazy var status = 0
//  lazy var statesArray = [statesModel]()
//  var mapId = Int()
  var header:HTTPHeaders = [:]
//  var ourService = String()
//  var otherService = String()
//  var logo_of_services_16px = String()
//  var logo_of_services_64px = String()
  
//  var chck_bool = Bool()
  
  
  
  
   // lazy var statePropertiesArray = [propertyModel]()
//    lazy var salePRopertArray = [propertyModel]()
//    lazy var leasePropertyArray = [propertyModel]()
    lazy var simlilarPropertyArray = [propertyModel]()
    lazy var propertyDetail = detailModel()
  
    lazy var userFavoritesArray = [userFavoritesModel]()
  
//    var totalPages:Int?
    
    //TODO:- States
//    func getAllStates(completion:@escaping (Bool) -> ()){
//        Alamofire.request(statesUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
//            
//            print("Request: \(String(describing: response.request))")   // original url request
//            print("Response: \(String(describing: response.response))") // http url response
//            print("Result: \(response.result)")// response serialization result
//            print(response)
//            self.statesArray.removeAll()
//            if response.result.error == nil{
//                self.status = (response.response?.statusCode)!
//                print(self.status)
//                guard let data = response.data else {return}
//                do{
//                    if let jsonArray = try JSON(data: data).array{
//                        for item in jsonArray {
//                            guard let jsonDic = item.dictionary else {return}
//                            let id = jsonDic["id"]?.int ?? -1
//                            let stateName = jsonDic["state"]?.string ?? ""
//                            let Icon = jsonDic["icon_image_64"]?.string ?? ""
//                            let object = statesModel.init(id: id, stateName: stateName, Icon: Icon)
//                            self.statesArray.append(object)
//                        }
//                        completion(true)
//                    }
//                }catch let jsonErr{
//                    print(jsonErr)
//                }
//                
//            }else{
//                completion(false)
//            }
//        }
//    }
    
    //TODO:- get states data
//    func getPrpertiesFromStates(url:String,completion:@escaping (Bool, [propertyModel]) -> ()){
//
//        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
//          var statesDataArray = [propertyModel]()
//
//            print("Request: \(String(describing: response.request))")   // original url request
//            print("Response: \(String(describing: response.response))") // http url response
//            print("Result: \(response.result)")// response serialization result
//            print(response)
//            //self.statePropertiesArray.removeAll()
//            if response.result.error == nil{
//
//                self.status = (response.response?.statusCode)!
//                print(self.status)
//                guard let data = response.data else {return}
//                do{
//                    if let jsonDic = try JSON(data: data).dictionary{
//                        let totalItems = jsonDic["totalItems"]?.int ?? 0
//                        self.totalPages = jsonDic["totalPages"]?.int ?? 0
//                        let jsonArray = jsonDic["results"]?.array ?? []
//                        for item in jsonArray {
//                            guard let propertyDic = item.dictionary else {return}
//                            let id = propertyDic["id"]?.int ?? -1
//                            let propertyTitle = propertyDic["property_title"]?.string ?? ""
//                            let propertyType = propertyDic["property_type"]?.string ?? ""
//                            let image = propertyDic["one_pic"]?.string ?? ""
//                            let price = propertyDic["price"]?.string ?? "N/A"
//                            let propertyArea = propertyDic["property_area"]?.string ?? ""
//                            let address = propertyDic["address"]?.string ?? ""
//                            let latitude = propertyDic["latitude"]?.string ?? ""
//                            let longitude = propertyDic["longitude"]?.string ?? ""
//                            let postType = propertyDic["post_type"]?.string ?? ""
//                          let isFavorite = propertyDic["isfavourite"]?.bool ?? false
//                          let object = propertyModel.init( id: id, Title: propertyTitle, PropertyType: propertyType, image: image, price: price, Area: propertyArea, Address: address, postType: postType, latitude: latitude, longitude: longitude, isFavourite: isFavorite)
//                          statesDataArray.append(object)
//                            //self.statePropertiesArray.append(object)
//                        }
//                       // print(self.statePropertiesArray)
//                        completion(true, statesDataArray)
//                    }
//                }catch let jsonErr{
//                    print(jsonErr)
//                }
//
//            }else{
//                completion(false, statesDataArray)
//            }
//        }
//    }
    
  
  //TODO:- For Sale Property Api
//  func SaleProperty(url:String,completion:@escaping (Int, Bool) -> ()){
//
//    var totalItems = -1
//    Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
//
//      print("Request: \(String(describing: response.request))")   // original url request
//      print("Response: \(String(describing: response.response))") // http url response
//      print("Result: \(response.result)")// response serialization result
//      print(response)
////      self.salePRopertArray.removeAll()
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
//              let object = propertyModel.init(id: id, Title: propertyTitle, PropertyType: propertyType, image: image, price: price, Area: propertyArea, Address: address, postType: postType, latitude: latitude, longitude: longitude, isFavourite: isFavorite)
//              self.salePRopertArray.append(object)
//            }
//            print(self.salePRopertArray)
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
  
  
  //TODO:- For Lease Property Api
//  func LeaseProperty(url:String,completion:@escaping ([propertyModel], Int, Bool) -> ()){
//   
//    var totalItems = -1
//    var propertiesArray = [propertyModel]()
//    
//    Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
//      
//      print("Request: \(String(describing: response.request))")   // original url request
//      print("Response: \(String(describing: response.response))") // http url response
//      print("Result: \(response.result)")// response serialization result
//      print(response)
////      self.leasePropertyArray.removeAll()
//      if response.result.error == nil{
//        self.status = (response.response?.statusCode)!
//        print(self.status)
//        guard let data = response.data else {return}
//        do{
//          if let jsonDic = try JSON(data: data).dictionary{
//            let totalItems = jsonDic["totalItems"]?.int ?? 0
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
//              propertiesArray.append(object)
//            }
////            print(self.leasePropertyArray)
//            completion(propertiesArray, totalItems, true)
//          }
//        }catch let jsonErr{
//          print(jsonErr)
//        }
//        
//      }else{
//        completion(propertiesArray, totalItems, false)
//      }
//    }
//  }
  
//  //MARK:- Detaiel Page API
//  func Detailpage(url : String, completion: @escaping (Bool) -> ())
//  {
//   print(url)
////    let url = "https://apis.officedoor.ai/office/property_detail_by_id/16136/\(idfordetail)/"
//    print(url)
//    Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { response in
//      print("Request: \(String(describing: response.request))")   // original url request
//      print("Response: \(String(describing: response.response))") // http url response
//      print("Result: \(response.result)")// response serialization result
//      print(response)
////      self.detailArray.removeAll()
//      if response.result.error == nil{
//        self.status = (response.response?.statusCode)!
//        print(response)
//        guard let data = response.data else {return}
//        do{
//          if let jsonDic = try JSON(data: data).dictionary{
//            let resultArr = jsonDic["results"]?.array ?? []
//            for item in resultArr {
//              guard let resultDic = item.dictionary else {return}
//              guard let id = resultDic["id"]?.int else {return}
//              guard let servicesArray = resultDic["mapped_services"]?.array else {return}
//              var serviceArray = [serviceModel]()
//              for item2 in servicesArray {
//                guard let mapedServiceDic = item2.dictionary else {return}
//                guard let serviceId = mapedServiceDic["id"]?.int else {return}
//                guard let ourService = mapedServiceDic["our_services"]?.string else {return}
//                guard let otherService = mapedServiceDic["other_services"]?.string else {return}
//                guard let serviceLogo16 = mapedServiceDic["logo_of_services_16px"]?.string else {return}
//
//                guard let serviceLogo64 = mapedServiceDic["logo_of_services_64px"]?.string else {return}
//                guard let checkBool = mapedServiceDic["chck_bool"]?.bool else {return}
//                let serviceInstance = serviceModel.init(mapId: serviceId, ourService: ourService, otherService: otherService, logo_of_services_16px: serviceLogo16, logo_of_services_30px: serviceLogo64, chck_bool: checkBool)
//                serviceArray.append(serviceInstance)
//
//              }
//              print(serviceArray)
//              let property_link = resultDic["property_link"]?.string ?? ""
//              let address = resultDic ["address"]?.string ?? ""
//              let latitude = resultDic ["latitude"]?.string ?? ""
//              let longitude = resultDic ["longitude"]?.string ?? ""
//              let property_type = resultDic ["property_type"]?.string ?? ""
//              let pic_url = resultDic ["pic_url"]?.string ?? ""
//              let one_pic = resultDic ["one_pic"]?.string ?? ""
//              let property_id = resultDic ["property_id"]?.string ?? ""
//              let description = resultDic ["description"]?.string ?? ""
//              let price = resultDic ["price"]?.string ?? ""
//              let presented_name = resultDic ["presented_name"]?.string ?? ""
//              let state = resultDic ["state"]?.string ?? ""
//              let zipcode = resultDic ["zipcode"]?.string ?? ""
//              let city = resultDic ["city"]?.string ?? ""
//              let country = resultDic ["country"]?.string ?? ""
//              let services = resultDic ["services"]?.string ?? ""
//              let property_title = resultDic ["property_title"]?.string ?? ""
//              let contact_no = resultDic ["contact_no"]?.string ?? ""
//              let active_bool = resultDic ["active_bool"]?.bool ?? true
//              let property_area = resultDic["property_area"]?.string ?? ""
//              let price_type = resultDic ["price_type"]?.string ?? ""
//              let post_type = resultDic ["post_type"]?.string ?? ""
//              let subspace_status = resultDic ["subspace_status"]?.string ?? ""
//              let created = resultDic ["created"]?.string ?? ""
//              let mappedbool = resultDic ["mappedbool"]?.bool ?? true
//              let demographics = resultDic ["demographics"]?.bool ?? false
//              self.propertyDetail = detailModel.init(servicesArray: serviceArray, resultId: id, property_link: property_link, Address: address, latitude: latitude, longitude: longitude, property_type: property_type, pic_url: pic_url, one_pic: one_pic, property_id: property_id, description: description, price: price, presented_name: presented_name, state: state, zipcode: zipcode, city: city, country: country, services: services, property_title: property_title, contact_no: contact_no, active_bool: active_bool, property_area: property_area, price_type: price_type, post_type: post_type, subspace_status: subspace_status, created: created, mappedbool: mappedbool, demographics: demographics)
////              self.propertyDetail.append(detailObj)
//            }
//            print(self.propertyDetail)
//            completion(true)
//          }
//        }catch let jsonErr{
//          print(jsonErr.localizedDescription)
//        }
//        completion (true)
//      } else{
//        completion (false)
//      }
//    }
//  }
  
  //MARK:- Detaiel Page API
  func getDetail(url : String, completion: @escaping (Bool) -> ()){
    
    let token =  UserDefaults.standard.string(forKey: SessionManager.keys.accessToken) ?? ""
    let header = [
      
      "Authorization":"JWT " + token
    ]
    Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { response in
      print("Request: \(String(describing: response.request))")   // original url request
      print("Response: \(String(describing: response.response))") // http url response
      print("Result: \(response.result)")// response serialization result
      print(response)
      //      self.detailArray.removeAll()
      if response.result.error == nil{
        self.status = response.response!.statusCode
        print(response)
        guard let data = response.data else {return}
        do{
          if let jsonDic = try JSON(data: data).dictionary{
            guard let resultArr = jsonDic["results"]?.array else {return}
            for item in resultArr {
              guard let resultDic = item.dictionary else {return}
              guard let id = resultDic["id"]?.int else {return}
              guard let servicesArray = resultDic["mapped_services"]?.array  else {return}
              var serviceArray = [serviceModel]()
              if servicesArray.isEmpty{
                
                print("services array is empty")
              }else {
                
                for service in servicesArray {
                  guard let serviceDict = service.dictionary else {return}
                  guard let serviceId = serviceDict["id"]?.int else {return}
                  guard let ourService = serviceDict["our_services"]?.string else {return}
                  guard let otherService = serviceDict["other_services"]?.string else {return}
                  guard let serviceLogo16 = serviceDict["logo_of_services_16px"]?.string else {return}
                  
                  guard let serviceLogo64 = serviceDict["logo_of_services_64px"]?.string else {return}
                  var checkBool = Bool()
                  if serviceDict["chck_bool"] == JSON.null{
                    
                    print("checkBool is null")
                    
                  }else {
                    
                    checkBool = (serviceDict["chck_bool"] != nil)
                    
                  }
                  let serviceInstance = serviceModel.init(mapId: serviceId, ourService: ourService, otherService: otherService, logo16px: serviceLogo16, logo64px: serviceLogo64, checkBool: checkBool)
                  serviceArray.append(serviceInstance)
                  
                }
                
              }
              print(serviceArray)
              let property_link = resultDic["property_link"]?.string ?? ""
              let address = resultDic ["address"]?.string ?? ""
              let latitude = resultDic ["latitude"]?.string ?? ""
              let longitude = resultDic ["longitude"]?.string ?? ""
              let property_type = resultDic ["property_type"]?.string ?? ""
              let pic_url = resultDic ["pic_url"]?.string ?? ""
              let one_pic = resultDic ["one_pic"]?.string ?? ""
              let property_id = resultDic ["property_id"]?.string ?? ""
              
              let description = resultDic["description"]?.string ?? ""
              let price = resultDic ["price"]?.string ?? ""
              let presented_name = resultDic ["presented_name"]?.string ?? ""
              let state = resultDic ["state"]?.string ?? ""
              let zipcode = resultDic ["zipcode"]?.string ?? ""
              let city = resultDic ["city"]?.string ?? ""
              let country = resultDic ["country"]?.string ?? ""
              let services = resultDic ["services"]?.string ?? ""
              let property_title = resultDic ["property_title"]?.string ?? ""
              let contact_no = resultDic ["contact_no"]?.string ?? ""
              let active_bool = resultDic ["active_bool"]?.bool ?? false
              let property_area = resultDic["property_area"]?.string ?? ""
              let price_type = resultDic ["price_type"]?.string ?? ""
              let post_type = resultDic ["post_type"]?.string ?? ""
              let subspace_status = resultDic ["subspace_status"]?.bool ?? false
              let created = resultDic ["created"]?.string ?? ""
              var mappedbool = Bool()
              if resultDic ["mappedbool"] == JSON.null{
                
                print("checkBool is null")
                
              }else {
                
                mappedbool = (resultDic ["mappedbool"] != nil)
                
              }
              let demographics = resultDic ["demographics"]?.bool ?? false
              self.propertyDetail = detailModel.init(servicesArray: serviceArray, resultId: id, property_link: property_link, Address: address, latitude: latitude, longitude: longitude, property_type: property_type, pic_url: pic_url, one_pic: one_pic, property_id: property_id, description: description, price: price, presented_name: presented_name, state: state, zipcode: zipcode, city: city, country: country, services: services, property_title: property_title, contact_no: contact_no, active_bool: active_bool, property_area: property_area, price_type: price_type, post_type: post_type, subspace_status: subspace_status, created: created, mappedbool: mappedbool, demographics: demographics)
            }
//            print(self.propertyDetail)
            completion(true)
          }
        }catch let jsonErr{
          print(jsonErr.localizedDescription)
        }
        completion (true)
      } else{
        completion (false)
      }
    }
  }
  
  func smililarPropertiesAPI(url: String,completion: @escaping (Int, Bool) -> ()){
    print(url)
    var totalItems = -1
    Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
      
      print("Request: \(String(describing: response.request))")   // original url request
      print("Response: \(String(describing: response.response))") // http url response
      print("Result: \(response.result)")// response serialization result
      print(response)
//      self.simlilarPropertyArray.removeAll()
      //      self.leasePropertyArray.removeAll()
      if response.result.error == nil{
        self.status = (response.response?.statusCode)!
        print(self.status)
        guard let data = response.data else {return}
        do{
          if let jsonDic = try JSON(data: data).dictionary{
            totalItems = jsonDic["totalItems"]?.int ?? 0
//            self.totalPages = jsonDic["totalPages"]?.int ?? 0
            let jsonArray = jsonDic["results"]?.array ?? []
            for item in jsonArray {
              guard let propertyDic = item.dictionary else {return}
              let id = propertyDic["id"]?.int ?? -1
              let propertyTitle = propertyDic["property_title"]?.string ?? ""
              let propertyType = propertyDic["property_type"]?.string ?? ""
              let image = propertyDic["one_pic"]?.string ?? ""
              let price = propertyDic["price"]?.string ?? "N/A"
              let propertyArea = propertyDic["property_area"]?.float ?? 0.0
              let address = propertyDic["address"]?.string ?? ""
              let latitude = propertyDic["latitude"]?.string ?? ""
              let longitude = propertyDic["longitude"]?.string ?? ""
              let postType = propertyDic["post_type"]?.string ?? ""
              let isFavorite = propertyDic["isfavourite"]?.bool ?? false
              let object = propertyModel.init(id: id, Title: propertyTitle, PropertyType: propertyType, image: image, price: price, Area: String(describing: propertyArea), Address: address, postType: postType, latitude: latitude, longitude: longitude, isFavourite: isFavorite)
              self.simlilarPropertyArray.append(object)
            }
//            print(self.simlilarPropertyArray)
            completion(totalItems, true)
          }
        }catch let jsonErr{
          print(jsonErr)
        }
        
      }else{
        completion(totalItems, false)
      }
    }
  }
  func favoritesDataAPI(completion :@escaping CompletionHandler){
   let url = userFavoritesUrl
  let token =  UserDefaults.standard.string(forKey: SessionManager.keys.accessToken) ?? ""
    header = [
      
      "Authorization":"JWT " + token
    ]
    print(header)
    print(url)
    Alamofire.request(url, method: .get, encoding:JSONEncoding.default, headers: header).responseJSON { (response) in
      print("Request: \(String(describing: response.request))")   // original url request
      print("Response: \(String(describing: response.response))") // http url response
      print("Result: \(response.result)")// response serialization result
      switch response.result {
      case .success(let value):
        guard let resultArray = value as? NSDictionary else {
          return
        }
        guard let finalArray = resultArray["results"] as? NSArray else {
          return
        }
        
        
        for properties in finalArray {
          guard let property = properties as? NSDictionary else {
            return
          }
          let resultID = property.value(forKey: "id") as? Int ?? -1
          guard let propertyIDDict = property.value(forKey: "Property_id") as? NSDictionary else {
            return
          }
          let propertyID = propertyIDDict.value(forKey: "id") as? Int ?? -1
          let propertyTitle = propertyIDDict.value(forKey: "property_title") as? String ?? "N/A"
          let propertyType = propertyIDDict.value(forKey: "property_type") as? String ?? "N/A"
          let onePic = propertyIDDict.value(forKey: "one_pic") as? String ?? "N/A"
          let price = propertyIDDict.value(forKey: "price") as? String ?? "N/A"
          let propertyArea = propertyIDDict.value(forKey: "property_area") as? String ?? "N/A"
          let address = propertyIDDict.value(forKey: "address") as? String ?? "N/A"
          let postType = propertyIDDict.value(forKey: "post_type") as? String ?? "N/A"
          let latitude = propertyIDDict.value(forKey: "latitude") as? String ?? "N/A"
          let longitude = propertyIDDict.value(forKey: "longitude") as? String ?? "N/A"
          let createdAt = property.value(forKey: "created_at") as? String ?? "N/A"
          let user = property.value(forKey: "user") as? Int ?? -1
          let favoriteObj = userFavoritesModel(resultsId: resultID, propertyId: propertyID, propertyTitle: propertyTitle, propertyType: propertyType, onePic: onePic, price: price, propertyArea: propertyArea, address: address, postType: postType, latitude: latitude, longitude: longitude, createdAt: createdAt, user: user)
          self.userFavoritesArray.append(favoriteObj)
        }
//        print(self.userFavoritesArray)
//        let zipCode = resultArray["zipcode"] as? String ?? "N/A"
        //            guard let userPreference = resultArray["user_preference"] as? NSArray else {
        //              return
        //            }
        //
        //            for item in userPreference{
        //
        //              let string = item as! String
        //
        //              self.stringArray.append(string)
        //            }
//        print(self.stringArray,"string array")
//        let updateProfileObj = UpdatedProfileModel(firstname: firstName, lastname: lastName, companyname: company, email: email, phone: phone, address: address, country: country, state: state, zipcode: zipCode, city: city, id: id, newsletter: newsLetter, username: userName)
//        self.UpdateProfileModelInstance.append(updateProfileObj)
//        print(self.UpdateProfileModelInstance)
        
        completion(true)
      case .failure(let error):
        completion(false)
        print(error.localizedDescription)
        
      }
    }
  }
}

