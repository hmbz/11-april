//
//  drawerService.swift
//  OgreSpace
//
//  Created by admin on 7/2/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class drawerService {
    static let instance = drawerService()
    lazy var status = 0
    lazy var profileArray = userModel()
    lazy var message = ""
    
    //TODO:- getting User Profile
    func getUserProfile(completion:@escaping (Bool) -> ()){
        let url = userProfileUrl
        let token =  UserDefaults.standard.string(forKey: SessionManager.keys.accessToken) ?? ""
        var header: HTTPHeaders = [:]
        if token != "" {
            header = [
                "Authorization": "JWT \(token)",
                "Accept": "application/json"
            ]
        }else{
            header = [
                "Authorization": "nil",
                "Accept": "application/json"
            ]
        }
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")// response serialization result
            print(response)
            if response.result.error == nil{
                self.status = (response.response?.statusCode)!
                print(self.status)
                guard let data = response.data else {return}
                do{
                    if let jsonArr = try JSON(data: data).array{
                        for item in jsonArr {
                            guard let jsonDic = item.dictionary else {return}
                            let id = jsonDic["id"]?.int ?? -1
                            let Fname = jsonDic["Fname"]?.string ?? ""
                            let Lname = jsonDic["Lname"]?.string ?? ""
                            let Mobile = jsonDic["Mobile"]?.string ?? ""
                            guard let user = jsonDic["user"]?.dictionary else {return}
                            let username = user["username"]?.string ?? ""
                            let email = user["email"]?.string ?? ""
                            let userId = user["id"]?.int ?? -1
                            let country = jsonDic["Country"]?.string ?? ""
                            let states = jsonDic["State"]?.string ?? ""
                            let City = jsonDic["City"]?.string ?? ""
                            let address = jsonDic["Address"]?.string ?? ""
                            let Pic = jsonDic["Pic"]?.string ?? ""
                            self.profileArray = userModel.init(id: id, Fname: Fname, Lname: Lname, Mobile: Mobile, username: username, email: email, userId: userId, country: country, states: states, City: City, address: address, Pic: Pic)
                            print(self.profileArray)
                        }
                        
                        completion(true)
                    }
                }catch let jsonErr{
                    print(jsonErr)
                }
                
            }else{
                completion(false)
            }
        }
    }
    
    //TODO:- Update User Profile
    func updateUserProfile(Id: Int,param: [String:Any],completion:@escaping (Bool) -> ()){
        let url = updateProfileUrl + "\(Id)"
      print(Id)
        let token =  UserDefaults.standard.string(forKey: SessionManager.keys.accessToken) ?? ""
        var header: HTTPHeaders = [:]
        if token != "" {
            header = [
                "Authorization": "JWT \(token)",
                "Accept": "application/json"
            ]
        }else{
            header = [
                "Authorization": "nil",
                "Accept": "application/json"
            ]
        }
        Alamofire.request(url, method: .put, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")// response serialization result
            print(response)
            if response.result.error == nil{
                self.status = (response.response?.statusCode)!
                print(self.status)
                guard let data = response.data else {return}
                do{
                    print(data)
//                    if let jsonArr = try JSON(data: data).array{
//                        for item in jsonArr {
//                            guard let jsonDic = item.dictionary else {return}
//                            let id = jsonDic["id"]?.int ?? -1
//                            let Fname = jsonDic["Fname"]?.string ?? ""
//                            let Lname = jsonDic["Lname"]?.string ?? ""
//                            let Mobile = jsonDic["Mobile"]?.string ?? ""
//                            guard let user = jsonDic["user"]?.dictionary else {return}
//                            let username = user["username"]?.string ?? ""
//                            let email = user["email"]?.string ?? ""
//                            let userId = user["id"]?.int ?? -1
//                            let country = jsonDic["Country"]?.string ?? ""
//                            let states = jsonDic["State"]?.string ?? ""
//                            let City = jsonDic["City"]?.string ?? ""
//                            let address = jsonDic["Address"]?.string ?? ""
//                            let Pic = jsonDic["Pic"]?.string ?? ""
//                            self.profileArray = userModel.init(id: id, Fname: Fname, Lname: Lname, Mobile: Mobile, username: username, email: email, userId: userId, country: country, states: states, City: City, address: address, Pic: Pic)
//                            print(self.profileArray)
//                        }
//
//                        completion(true)
//                    }
                }catch let jsonErr{
                    print(jsonErr)
                }
                
            }else{
                completion(false)
            }
        }
    }
  
  //TODO:-  change Password
  func changepass(param:[String:Any],completion:@escaping CompletionHandler)  {
    let token =  UserDefaults.standard.string(forKey: SessionManager.keys.accessToken) ?? ""
    var header: HTTPHeaders = [:]
    if token != "" {
      header = [
        "Authorization": "JWT \(token)",
        "Accept": "application/json"
      ]
    }else{
      header = [
        "Authorization": "nil",
        "Accept": "application/json"
      ]
    }
    print(param)
    
    Alamofire.request(changepasswordUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header).responseJSON{(response) in
      if response.result.error == nil{
        print(response)
        guard let data = response.data else {return}
        do{
          guard let json = try JSON(data: data).dictionary else {return}
          self.message = json["message"]?.string ?? ""
          completion(true)
        } catch let error {
          completion(false)
          debugPrint("Something not working.\(error)")
        }
      }
      else{
        completion(false)
        debugPrint(response.result.error as Any)
      }
    }
  }
    
}
