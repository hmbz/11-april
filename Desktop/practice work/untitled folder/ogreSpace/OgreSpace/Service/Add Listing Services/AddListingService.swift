//
//  AddListingService.swift
//  OgreSpace
//
//  Created by admin on 7/29/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import Foundation
import Alamofire

class AddListingService{
  
  static let instance = AddListingService()
  var servicesArray = [servicesModel]()
  var addListingMessage = ""
  
  func getServices(completion:@escaping (Bool) -> ()){
    let url = servicesUrl
    
    Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
      
      print("Request: \(String(describing: response.request))")   // original url request
      print("Response: \(String(describing: response.response))") // http url response
      print("Result: \(response.result)")// response serialization result
      print(response)
      switch response.result{
      case .success(let value):
        guard let servicesArray = value as? NSArray else {
          return
        }
        for service in servicesArray {
          guard let serviceDict = service as? NSDictionary else{
            return
          }
          let id = serviceDict.value(forKey: "id") as? Int ?? -1
          let serviceName = serviceDict.value(forKey: "our_services") as? String ?? "N/A"
          let serviceLogo = serviceDict.value(forKey: "logo_of_services_30px") as? String ?? "N/A"
//          let isSelected = serviceDict.value(forKey: "chck_bool") as? Bool ?? false
          let servicesObj = servicesModel(serviceId: id, serviceName: serviceName, serviceIcon: serviceLogo, isChecked: false)
          self.servicesArray.append(servicesObj)
        }
        print(self.servicesArray)
        completion(true)
      case .failure(let error):
        debugPrint(error.localizedDescription)
        completion(false)
      }
      
    }
  }

  
  
  func addListing(params: [String: Any], completion:@escaping (Bool) -> ()){
    let url = addListingUrl
    let token = UserDefaults.standard.string(forKey: SessionManager.keys.accessToken)
    print(token!)
    let jwtToken = [ "Authorization": "JWT \(token!)" ]
    print(url, "addListingUrl")
    print(params)
    print(jwtToken)

    
    Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: jwtToken).responseString { response in
      
      print("Request: \(String(describing: response.request))")   // original url request
      print("Response: \(String(describing: response.response))") // http url response
      print("Result: \(response.result)")// response serialization result
      print(response)
      switch response.result{
      case .success(let value):
        guard let messageDict = value as? NSDictionary else {
          return
        }
        guard let message = messageDict["results"] as? String else { return }
        self.addListingMessage = message
        
      case .failure(let error):
        debugPrint(error.localizedDescription)
        completion(false)
      }
      
    }
  }
  
  //MARK: Image uploading
//  func upload(imagesArray: [UIImage], completion: @escaping (Bool,String) -> ()) {
//    //  UIImage.jpegData(compressionQuality:)
//
//
////    Alamofire.upload(
////      .POST,
////      URLString: fullUrl, // http://httpbin.org/post
////      multipartFormData: { multipartFormData in
////        multipartFormData.appendBodyPart(fileURL: imagePathUrl!, name: "photo")
////        multipartFormData.appendBodyPart(fileURL: videoPathUrl!, name: "video")
////    }
//
//    Alamofire.upload(multipartFormData: { (form) in
//
//      for image in imagesArray{
//
//        guard let data = image.jpegData(compressionQuality: 0.9) else {
//          return
//        }
//        let uuid = NSUUID().uuidString
//        print(uuid)
//        form.append(data
//          , withName: "fileToUpload"
//          , fileName: "\(uuid).jpg"
//          , mimeType: "image/jpg"
//        )
//
//      }
//
//    }
//      //      Alamofire.upload(multipartFormData: { (form) in
//      //        form.append(data
//      //          , withName: "fileToUpload"
//      //          , fileName: "\(uuid).jpg"
//      //          , mimeType: "image/jpg"
//      //        )}
//      , to: "https://storage.officedoor.ai/hamzatest.php"
//      , encodingCompletion: { result in
//        switch result {
//        case .success(let upload, _, _):
//          upload.responseString { response in
//
//            guard let responseString = response.value else {return}
//
//            print(responseString)
//            completion(true, responseString)
//
//          }
//        case .failure(let encodingError):
//          print(encodingError)
//          completion(false, encodingError as! String)
//        }
//    })
//  }
  
  
  func upload(image: UIImage, completion: @escaping (Bool,String) -> ()) {
    guard let data = image.jpegData(compressionQuality: 0.9) else {
      return
    }
    let uuid = NSUUID().uuidString
    print(uuid)
    Alamofire.upload(multipartFormData: { (form) in
      form.append(data, withName: "fileToUpload", fileName: "\(uuid).jpg", mimeType: "image/jpg")
    }, to: "https://storage.officedoor.ai/hamzatest.php", encodingCompletion: { result in
      switch result {
      case .success(let upload, _, _):
        upload.responseString { response in
          
          guard let responseString = response.value else {return}
          print(responseString)
          completion(true, responseString)
          
        }
      case .failure(let encodingError):
        print(encodingError)
        completion(true, encodingError as! String)
      }
    })
  }
  
}




