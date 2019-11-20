//
//  PaymentMethodService.swift
//  OgreSpace
//
//  Created by MAC on 31/07/2019.
//  Copyright © 2019 brainplow. All rights reserved.
//

import Foundation
import Alamofire

class paymentCardDetailSerivce{
  static let instance = paymentCardDetailSerivce()
  var paymentCardDetailArray = [paymentCardDetailModel]()
  var header:[String:String]?
  var status:Int = 0
  func paymentCardDetailMethod(completion: @escaping CompletionHandler){
    paymentCardDetailArray.removeAll()
    let token =  UserDefaults.standard.string(forKey: SessionManager.keys.accessToken) ?? ""
//    let loginStatus = UserDefaults.standard.bool(forKey: "loginStatus")
//    if (loginStatus) {
    
      header = [
        "Authorization": "JWT \(token)"
      ]
      print("header:\(header!)")
//    }
//    else {
//
//      header = [
//        "Content-Type": "application/json"
//      ]
//      print("header:\(header!)")
//    }
    let url = URL(string: paymentMethodUrl)
    print(url,"password change url")
    Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON {
      (response) in
      switch response.result {
      case .success(let value):
        guard let resultArray = value as? NSArray else {
          return
        }
        for dicts in resultArray {
          guard let finalDict = dicts as? NSDictionary else {
            return
          }
          let id = finalDict.value(forKey: "id") as? Int ?? -1
          let ccv = finalDict.value(forKey: "ccv") as? String ?? "N/A"
          let cardType = finalDict.value(forKey: "card_type") as? String ?? "N/A"
          let expiryDate = finalDict.value(forKey: "expiryDate") as? String ?? "N/A"
          let cardNumber = finalDict.value(forKey: "cardNumber") as? String ?? "N/A"
          let zipCode = finalDict.value(forKey: "zipcode") as? String ?? "N/A"
          let deflaut = finalDict.value(forKey: "default") as? Bool ?? true
          let nickName = finalDict.value(forKey: "nickname") as? String ?? "N/A"
          let street_address = finalDict.value(forKey: "street_address") as? String ?? "N/A"
          let city = finalDict.value(forKey: "city") as? String ?? "N/A"
          let state = finalDict.value(forKey: "state") as? String ?? "N/A"
          let country = finalDict.value(forKey: "country") as? String ?? "N/A"
          let autoPay = finalDict.value(forKey: "autopay") as? Bool ?? false
          let paymentCardDetailArrayObj = paymentCardDetailModel(detailID: id, paymentCardCVV: ccv, paymentCardType: cardType, expiryCardDate: expiryDate, cardNumber: cardNumber, zipCode: zipCode, defualt: deflaut, nickName: nickName, street_address: street_address, city: city, state: state, country: country, autopay: autoPay)
          self.paymentCardDetailArray.append(paymentCardDetailArrayObj)
          //          self.paymentCardDetailArray.append(paymentCardDetailObj)
          completion(true)
          print(self.paymentCardDetailArray)
          //          print(self.paymentCardDetailArray,"payment card detail")
        }
        
        
      case .failure(let error):
        debugPrint(error.localizedDescription)
      }
    }
  }
  
  func paymentCardDetailPostMethod(param:[String:Any], completion: @escaping CompletionHandler) {
    
    let token =  UserDefaults.standard.string(forKey: SessionManager.keys.accessToken) ?? ""
//    if (loginStatus) {
    var headers:HTTPHeaders = [:]
      headers = [
        "Authorization": "JWT \(token)"
      ]
      print("header:\(headers)")
    
//    }
//    else {
//
//      header = [
//        "Content-Type": "application/json"
//      ]
//      print("header:\(header!)")
//    }
    let url = URL(string: paymentMethodUrl)
    print(url,"payment card url")
    print(param)
    print(headers)
    Alamofire.request(url!, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
      print("Request: \(String(describing: response.request))")   // original url request
      print("Response: \(String(describing: response.response))") // http url response
      print("Result: \(response.result)")// response serialization result
      
      if response.result.error == nil{
        self.status = (response.response?.statusCode)!
        
        completion(true)
        
      }else{
        completion(false)
        debugPrint(response.result.error as Any)
      }
    }
}
}
