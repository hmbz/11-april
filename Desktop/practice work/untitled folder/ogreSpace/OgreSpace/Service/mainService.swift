//
//  mainService.swift
//  OgreSpace
//
//  Created by admin on 7/1/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import JWTDecode



class mainService {
    static let instance = mainService()
    lazy var status  = 0
    var statement = ""
    var message = ""
//  lazy var isFavourite = false
//  lazy var isRemovedFromFavourites = false
  
   
    
    //TODO:- getting Token From Login Api
//  func loginUser ( param: [String:Any], completion: @escaping CompletionHandler ) {
//    Alamofire.request(loginUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseString { (response) in
//      print("Request: \(String(describing: response.request))")   // original url request
//      print("Response: \(String(describing: response.response))") // http url response
//      print("Result: \(response.result)")// response serialization result
//      print(response)
//      if response.result.error == nil {
//        self.status = (response.response?.statusCode)!
//        if (self.status == 200 || self.status == 201 || self.status == 202) {
//          print("successful")
//          print(response)
//          guard let data = response.data else { return }
//          do {
//            if let json = try JSON(data: data).dictionary {
//              guard let token = json["token"]?.stringValue else {return}
//              print("your token is \(token)")
//              do {
//                  // decoding the token to get user id and username
//                let jwt = try decode(jwt: token )
//                let bodyDict = jwt.body as NSDictionary
//                print(bodyDict)
//                // getting id
//                var userIdFinal = -1
//                if let userId = bodyDict.value(forKey: "user_id") as? Int {
//                  userIdFinal = userId
//                  print("decoded userId \(String(describing: userId))")
//                  UserDefaults.standard.set(userIdFinal, forKey: SessionManager.keys.UserId)
//                  print(UserDefaults.standard.string(forKey: SessionManager.keys.UserId)!)
//                }
//                // email
//                var emailFinal = ""
//                if let userName = bodyDict.value(forKey: "email") as? String {
//                  emailFinal = userName
//                  UserDefaults.standard.set(emailFinal, forKey: SessionManager.keys.email)
//                  print(UserDefaults.standard.string(forKey: SessionManager.keys.email)!)
//                }
//                var userNameFinal = ""
//                if let userName = bodyDict.value(forKey: "username") as? String {
//                  userNameFinal = userName
//                  UserDefaults.standard.set(userNameFinal, forKey: SessionManager.keys.name)
//                  print(UserDefaults.standard.string(forKey: SessionManager.keys.name)!)
//                }
//              } catch let error as NSError {
//                print(error.localizedDescription)
//              }
//              // saving the token and loginStatus to the Userdefault Memory
//              UserDefaults.standard.set(token, forKey: SessionManager.keys.accessToken)
//              UserDefaults.standard.set(true, forKey: SessionManager.keys.isUserLoggedIn)
//              completion(true)
//            }
//          }
//          catch let jsonErr {
//            print(jsonErr)
//          }
//        }
//        completion(true)
//      }
//      else {
//        completion(false)
//        debugPrint(response.result.error as Any)
//      }
//    }
//  }
  
  func checkIsActive ( param: [String:Any], completion: @escaping CompletionHandler ) {
    Alamofire.request(isActiveUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseString { (response) in
      print("Request: \(String(describing: response.request))")   // original url request
      print("Response: \(String(describing: response.response))") // http url response
      print("Result: \(response.result)")// response serialization result
      print(response)
      if response.result.error == nil {
        self.status = (response.response?.statusCode)!
//        if (self.status == 200 || self.status == 201 || self.status == 202) {
          guard let data = response.data else { return }
          do {
            if let json = try JSON(data: data).dictionary {
              
              guard let message = json["message"]?.stringValue else {return}
              guard let status = json["status"]?.boolValue else {return}
              
              if message == "Activated" {
                
                guard let userId = json["userId"]?.intValue else {return}
                guard let isSubscribed = json["isSubscribed"]?.boolValue else {return}
                guard let trialSubscription = json["trialsubscription"]?.boolValue else {return}
                UserDefaults.standard.set(isSubscribed, forKey: SessionManager.keys.isSubscribed)
                
              }else if message == "Username does not exist"{
                
                UserDefaults.standard.set(false, forKey: SessionManager.keys.isSubscribed)
                
              }else {
                
                UserDefaults.standard.set(false, forKey: SessionManager.keys.isSubscribed)
                
              }
              guard let token = json["key"]?.stringValue else {return}
              let jwt = try decode(jwt: token )
              let bodyDict = jwt.body as NSDictionary
              print(bodyDict)
              var userIdFinal = -1
              if let userId = bodyDict.value(forKey: "user_id") as? Int {
                userIdFinal = userId
                print("decoded userId \(String(describing: userId))")
                UserDefaults.standard.set(userIdFinal, forKey: SessionManager.keys.UserId)
                print(UserDefaults.standard.string(forKey: SessionManager.keys.UserId)!)
              }
              // email
              var emailFinal = ""
              if let userName = bodyDict.value(forKey: "email") as? String {
                emailFinal = userName
                UserDefaults.standard.set(emailFinal, forKey: SessionManager.keys.email)
                print(UserDefaults.standard.string(forKey: SessionManager.keys.email)!)
              }
              var userNameFinal = ""
              if let userName = bodyDict.value(forKey: "username") as? String {
                userNameFinal = userName
                UserDefaults.standard.set(userNameFinal, forKey: SessionManager.keys.name)
                print(UserDefaults.standard.string(forKey: SessionManager.keys.name)!)
                // saving the token and loginStatus to the Userdefault Memory
                UserDefaults.standard.set(token, forKey: SessionManager.keys.accessToken)
                UserDefaults.standard.set(true, forKey: SessionManager.keys.isUserLoggedIn)
                
              }
              completion(true)
            }
          }
          catch let jsonErr {
            print(jsonErr)
          }
      }
      else {
        completion(false)
        debugPrint(response.result.error as Any)
      }
    }
  }
  
  
  //MARK:- Socail Login API
  func getSocialLogin ( param: [String:Any], completion: @escaping CompletionHandler ) {
    
    Alamofire.request(socailLoginUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseString { (response) in
      print("Request: \(String(describing: response.request))")   // original url request
      print("Response: \(String(describing: response.response))") // http url response
      print("Result: \(response.result)")// response serialization result
      print(response)
      if response.result.error == nil {
        self.status = (response.response?.statusCode)!
        if (self.status == 200 || self.status == 201 || self.status == 202) {
          
          guard let data = response.data else { return }
          do {
            if let json = try JSON(data: data).dictionary {
              guard let token = json["key"]?.stringValue else {return}
              print("your token is \(token)")
              do {
                // decoding the token to get user id and username
                let jwt = try decode(jwt: token )
                let bodyDict = jwt.body as NSDictionary
                print(bodyDict)
                // getting id
                var userIdFinal = -1
                if let userId = bodyDict.value(forKey: "user_id") as? Int {
                  userIdFinal = userId
                  print("decoded userId \(String(describing: userId))")
                  UserDefaults.standard.set(userIdFinal, forKey: SessionManager.keys.UserId)
                  print(UserDefaults.standard.string(forKey: SessionManager.keys.UserId)!)
                }
                // email
                var emailFinal = ""
                if let userName = bodyDict.value(forKey: "email") as? String {
                  emailFinal = userName
                  UserDefaults.standard.set(emailFinal, forKey: SessionManager.keys.email)
                  print(UserDefaults.standard.string(forKey: SessionManager.keys.email)!)
                }
                var userNameFinal = ""
                if let userName = bodyDict.value(forKey: "username") as? String {
                  userNameFinal = userName
                  UserDefaults.standard.set(userNameFinal, forKey: SessionManager.keys.name)
                  print(UserDefaults.standard.string(forKey: SessionManager.keys.name)!)
                  
                }
                  
                
                
              } catch let error as NSError {
                print(error.localizedDescription)
              }
              // saving the token and loginStatus to the Userdefault Memory
              UserDefaults.standard.set(token, forKey: SessionManager.keys.accessToken)
              UserDefaults.standard.set(true, forKey: SessionManager.keys.isUserLoggedIn)
              completion(true)
            }
          }
          catch let jsonErr {
            print(jsonErr)
          }
        }
        completion(true)
      }
      else {
        completion(false)
        debugPrint(response.result.error as Any)
      }
    }
  }
    
    
    //TODO:-  reseting the Login email
    func forgotPass(param : [String:Any],completion:@escaping CompletionHandler)  {
        Alamofire.request(forgotPassUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")// response serialization result
            print(response)
            self.status = (response.response?.statusCode)!
            print(self.status)
            if response.result.error == nil{
                if(self.status == 200){
                    print("successful")
                    guard let data = response.data else {return}
                    do{
                        
                        if let json = try JSON(data: data).dictionary{
                            let message  = json["message"]?.string ?? ""
                            self.message = message
                            completion(true)
                        }
                    }catch let jsonErr{
                        print(jsonErr)
                    }
                    
                }
                else if (self.status == 202){
                    print("Error")
                    guard let data = response.data else {return}
                    do{
                        if let json = try JSON(data: data).dictionary{
                            let message  = json["message"]?.string ?? ""
                            self.message = message
                            print(message)
                            completion(true)
                        }
                    }catch let jsonErr{
                        print(jsonErr)
                    }
                }
                else if (self.status == 404){
                    print("Error")
                    guard let data = response.data else {return}
                    do{
                        if let json = try JSON(data: data).dictionary{
                            let message  = json["message"]?.string ?? ""
                            self.message = message
                            print(message)
                            completion(true)
                        }
                    }catch let jsonErr{
                        print(jsonErr)
                    }
                }
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
  

  
    // TODO:- signup Api calling
    func signUpUser(param : [String:Any],completion:@escaping CompletionHandler)  {
      
        guard let url = URL.init(string: registerUrl) else { return }
      print("params = \(param)")
      print(url)
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")// response serialization result
            print(response)
            if response.result.error == nil{
                self.status = (response.response?.statusCode)!
                if(self.status == 200 || self.status == 201 || self.status == 202){
                    print("successful")
                    guard let data = response.data else {return}
                    do{
                        
                        if let jsonDict = try JSON(data: data).dictionary{
                            guard let message = jsonDict["message"]?.string else { return }
                            self.message = message
                            completion(true)
                        }
                    }catch let jsonErr{
                        print(jsonErr)
                    }
                    
                }
                else if self.status == 404{
                    print("successful")
                    guard let data = response.data else {return}
                    do{
                        
                        if let jsonDict = try JSON(data: data).dictionary{
                            guard let message = jsonDict["message"]?.string else { return }
                            self.message = message
                            completion(true)
                        }
                    }catch let jsonErr{
                        print(jsonErr)
                    }
                    
                }
                else {
                    showSwiftMessageWithParams(theme: .error, title: "SignUp", body: "Server Error")
                }
                
                
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    // TODO:- Username Authentication
    
    func getUsernameAuthentication( param: [String:Any], completion:@escaping (Bool) -> ()){
        print(param)
        Alamofire.request(usernameUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")// response serialization result
            print(response)
            if response.result.error == nil{
                self.status = (response.response?.statusCode)!
                print(self.status)
                guard let data = response.data else {return}
                do{
                    if let json = try JSON(data: data).dictionary{
                        self.message = json["message"]?.string ?? ""
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
    
    // TODO:- Email Authentication
    
    func getEmailAuthentication( param: [String:Any], completion:@escaping (Bool) -> ()){
        print(param)
        Alamofire.request(emailVerifyUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")// response serialization result
            print(response)
            if response.result.error == nil{
                self.status = (response.response?.statusCode)!
                print(self.status)
                guard let data = response.data else {return}
                do{
                    if let json = try JSON(data: data).dictionary{
                        self.message = json["message"]?.string ?? ""
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
    

  func addToFavourites(propertyId: String, completion:@escaping (Bool, Bool) -> ()){
    
    let url = addToFavouritesUrl + propertyId
    let token =  UserDefaults.standard.string(forKey: SessionManager.keys.accessToken) ?? ""
    let header = [
      
      "Authorization":"JWT " + token
    ]
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
          if let json = try JSON(data: data).dictionary{
//            guard let result = json["results"]?.string else {return}
            guard let status = json["favourite"]?.bool else {return}
            guard let results = json["results"]?.string else {return}
            let isAddedBool = results == "Added" || results == "Already Exist"
            
            completion(true, isAddedBool)
          }
        }catch let jsonErr{
          print(jsonErr)
        }
        
      }else{
        completion(false, false)
      }
    }
  }
  
  func removeFromFavourites( propertyId: String, completion:@escaping (Bool, Bool) -> ()){
    
    let url = removeFromFavouritesUrl + propertyId
    let token =  UserDefaults.standard.string(forKey: SessionManager.keys.accessToken) ?? ""
    let header = [
      
      "Authorization":"JWT " + token
    ]
    Alamofire.request(url, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { response in
      
      print("Request: \(String(describing: response.request))")   // original url request
      print("Response: \(String(describing: response.response))") // http url response
      print("Result: \(response.result)")// response serialization result
      print(response)
      if response.result.error == nil{
        self.status = (response.response?.statusCode)!
        print(self.status)
        guard let data = response.data else {return}
        do{
          if let json = try JSON(data: data).dictionary{
//            guard let result = json["results"]?.string else {return}
            guard let status = json["status"]?.bool else {return}
//            self.isRemovedFromFavourites = status
            
            completion(true, status)
          }
        }catch let jsonErr{
          print(jsonErr)
        }
        
      }else{
        completion(false, false)
      }
    }
  }
    
}
