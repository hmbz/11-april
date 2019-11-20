//
//  DetailPageService.swift
//  OgreSpace
//
//  Created by admin on 9/5/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DetailPageService {
  
  
  static let instance = DetailPageService()
  lazy var status = 0
//  lazy var nearbyPlacesArray = [NearbyPlacesModel]()
  
//  lazy var homeValueArray = [HomeValueModel]()
//  lazy var genderDataArray = [GenderRatioModel]()
//  lazy var rentDataArray = [RentPaidModel]()
//  lazy var totalHousesBuiltArray = [TotalHousesBuiltModel]()
//  lazy var householDistributionArray = [HouseholdDistributionModel]()
//  lazy var forecastValuesArray = [Double]()
  
  lazy var responseMessage = String()
//  var categoriesModelArray = [CategoriesModel]()
//  var header:HTTPHeaders = [:]
  
  func getNearByPlaces(params: [String: Any],completion:@escaping (Bool, [NearbyPlacesModel]) -> ()){
    let url = nearbyPlacesUrl
    print(url)
    Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
      var nearbyPlacesArray = [NearbyPlacesModel]()
      print("Request: \(String(describing: response.request))")   // original url request
      print("Response: \(String(describing: response.response))") // http url response
      print("Result: \(response.result)")// response serialization result
      print(response)
      switch response.result{
      case .success(let value):
        
        guard let dataDict = value as? NSDictionary else {
          return
        }
        guard let placesArray = dataDict["results"] as? NSArray else {return}
        for place in placesArray {
          guard let placeDict = place as? NSDictionary else{
            return
          }
          let name = placeDict.value(forKey: "name") as? String ?? ""
          let longitude = placeDict.value(forKey: "longitude") as? Double ?? 0.0
          let latitude = placeDict.value(forKey: "latitude") as? Double ?? 0.0
          let address = placeDict.value(forKey: "address") as? String ?? "N/A"
          let distance = placeDict.value(forKey: "distance") as? Int ?? -1
          let placeModelObj = NearbyPlacesModel(placeName: name, placeAddress: address, placeDistance: distance, latitude: latitude, longitude: longitude)
          
          nearbyPlacesArray.append(placeModelObj)
        }
        
        completion(true, nearbyPlacesArray)
      case .failure(let error):
        debugPrint(error.localizedDescription)
        completion(false, nearbyPlacesArray)
      }
      
    }
  }
  
  
  func getDemograhics(zipcode: String,completion:@escaping (Bool, DemographicsModel?) -> ()){
    let url = demographicsUrl + zipcode
    let token =  UserDefaults.standard.string(forKey: SessionManager.keys.accessToken) ?? ""
    let header = [
      
      "Authorization":"JWT " + token
    ]
    print(header)
    Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { response in
      
      
      print("Request: \(String(describing: response.request))")   // original url request
      print("Response: \(String(describing: response.response))") // http url response
      print("Result: \(response.result)")// response serialization result
      print(response)
      switch response.result{
      case .success(let value):
        
        guard let dataDict = value as? NSDictionary else {
          return
        }
        guard let forecastDict = dataDict["forecast"] as? NSDictionary else {
          return
        }
        guard let forecast2017 = forecastDict["forecast_2017"] as? Double else {
          return
        }
        guard let forecast2018 = forecastDict["Forecast_2018"] as? Double else {
          return
        }
        guard let forecast2019 = forecastDict["Forecast_2019"] as? Double else {
          return
        }
        guard let forecast2020 = forecastDict["Forecast_2020"] as? Double else {
          return
        }
        var forecastValuesArray = [Double]()
        var crimeRateArray = [CrimeRateModel]()
        var homeValueArray = [HomeValueModel]()
        var genderDataAry = [GenderRatioModel]()
        var rentDataAry = [RentPaidModel]()
        var totalHousesBuiltArray = [TotalHousesBuiltModel]()
        var householDistributionArray = [HouseholdDistributionModel]()
        forecastValuesArray.append(forecast2017)
        forecastValuesArray.append(forecast2018)
        forecastValuesArray.append(forecast2019)
        forecastValuesArray.append(forecast2020)
        
        guard let dataArray = dataDict["data"] as? NSArray else {return}
        for data in dataArray {
          guard let placeDict = data as? NSDictionary else{
            return
          }
          guard let crimeDataArray = placeDict["crime_data"] as? NSArray else {return}
          
          for crimeData in crimeDataArray{
            
            guard let crimeDict = crimeData as? NSDictionary else{
              return
            }
            guard let crimeName = crimeDict["crime_title"] as? NSString else{
              return
            }
            guard let crimeNumber = crimeDict["crime_counts"] as? NSInteger else{
              return
            }

            let crimeInstance = CrimeRateModel.init(crimeTitle: crimeName as String, crimeCount: crimeNumber)
            crimeRateArray.append(crimeInstance)
            
          }
          guard let homeOwnerDataArray = placeDict["homevalueOnwer"] as? NSArray else {return}
          
          for homeOwnerData in homeOwnerDataArray{
            
            guard let homeOwnerDict = homeOwnerData as? NSDictionary else{
              return
            }
            guard let valueDetail = homeOwnerDict["values_detail"] as? NSString else{
              return
            }
            guard let noOfHouses = homeOwnerDict["no_of_houses"] as? NSInteger else{
              return
            }
            
            let homeOwnerInstance = HomeValueModel.init(valuesDetail: valueDetail as String, noOfHouses: noOfHouses)
            homeValueArray.append(homeOwnerInstance)
            
          }
          
          guard let genderDataArray = placeDict["zipcode_gender"] as? NSArray else {return}
          
          
          for genderData in genderDataArray{
            
            guard let genderDict = genderData as? NSDictionary else{
              return
            }
            guard let under5Population = genderDict["under_5_pop_per"] as? Double else{
              return
            }
            guard let under18Population = genderDict["under_18_pop_per"] as? Double else{
              return
            }
            guard let above65Population = genderDict["above_65_pop_per"] as? Double else{
              return
            }
            guard let malePopulation = genderDict["male_pop_per"] as? Double else{
              return
            }
            guard let femalePopulation = genderDict["females_pop_per"] as? Double else{
              return
            }
            guard let whitePopulation = genderDict["white_persons_pop_per"] as? Double else{
              return
            }
            guard let blackPopulation = genderDict["black_persons_pop_per"] as? Double else{
              return
            }
            guard let otherPopulation = genderDict["other_persons_pop_per"] as? Double else{
              return
            }
            guard let fullTimeEarningPopulation = genderDict["worked_full_time_earnings_per"] as? Double else{
              return
            }
            guard let partTimeEarningPopulation = genderDict["worked_part_time_earnings_per"] as? Double else{
              return
            }
            
            
            let homeOwnerInstance = GenderRatioModel.init(under5Population: under5Population, under18Population: under18Population, above65Population: above65Population, femalePopulation: femalePopulation, malePopulation: malePopulation, whitePopulation: whitePopulation, blackPopulation: blackPopulation, othersPopulation: otherPopulation, fullTimeEarnings: fullTimeEarningPopulation, partTimeEarnings: partTimeEarningPopulation)
            genderDataAry.append(homeOwnerInstance)
            
          }
          
          guard let rentDataArray = placeDict["rent_by_renters"] as? NSArray else {return}
          for rentItem in rentDataArray{
            
            guard let rentItemDict = rentItem as? NSDictionary else{
              return
            }
            guard let priceDetail = rentItemDict["price_detail"] as? NSString else{
              return
            }
            guard let noOfPayers = rentItemDict["no_of_payers"] as? NSInteger else{
              return
            }
            
            let rentInstance = RentPaidModel.init(priceDetail: priceDetail as String, noOfPayers: noOfPayers)
            rentDataAry.append(rentInstance)
            
          }
          
          
          guard let housesBuiltDataArray = placeDict["housebuild_detail"] as? NSArray else {return}
          for houseItem in housesBuiltDataArray{
            
            guard let housesBuiltDict = houseItem as? NSDictionary else{
              return
            }
            guard let priceDetail = housesBuiltDict["housebuild_year"] as? NSString else{
              return
            }
            guard let noOfPayers = housesBuiltDict["no_of_builds"] as? NSInteger else{
              return
            }
            
            let housesBuiltInstance = TotalHousesBuiltModel.init(year: priceDetail as String, noOfHouses: noOfPayers)
            totalHousesBuiltArray.append(housesBuiltInstance)
            
          }
          
          guard let householdDataArray = placeDict["householddistricutio"] as? NSArray else {return}
          for householdItem in householdDataArray{
            
            
            guard let housesholdDict = householdItem as? NSDictionary else{
              return
            }
            guard let id = housesholdDict["id"] as? NSInteger else{
              return
            }
            guard let year = housesholdDict["year"] as? NSInteger else{
              return
            }
            
            guard let incomeDistribution = housesholdDict["income_distri"] as? NSString else{
              return
            }
            guard let noOfHouses = housesholdDict["no_of_houses"] as? NSInteger else{
              return
            }
            guard let zipcode = housesholdDict["zipcode"] as? NSInteger else{
              return
            }
            
            let housesBuiltInstance = HouseholdDistributionModel.init(id: id, year: year, incomeDistribution: incomeDistribution as String, noOfHouses: noOfHouses, zipCode: zipcode)
            householDistributionArray.append(housesBuiltInstance)
            
          }

        }

        let demographicsDataInstance = DemographicsModel(ForecastData: forecastValuesArray, CrimeRateData: crimeRateArray, HomeValueData: homeValueArray, GenderRatioData: genderDataAry, RentPaidData: rentDataAry, TotalHousesBuiltData: totalHousesBuiltArray, HouseholdDistributionData: householDistributionArray)
        completion(true, demographicsDataInstance)
      case .failure(let error):
        debugPrint(error.localizedDescription)
        completion(false, nil)
      }
      
    }
  }
  
  func getScheduleTour(params: [String: Any], completion:@escaping (Bool) -> ()){
    let url = scheduleTourUrl
    print(url)
    Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { response in

      print("Request: \(String(describing: response.request))")   // original url request
      print("Response: \(String(describing: response.response))") // http url response
      print("Result: \(response.result)")// response serialization result
      print(response)
      switch response.result{
      case .success(let value):
        guard let responseDict = value as? NSDictionary else {
          return
        }
        guard let responseMessage = responseDict["msg"] as? NSString else {return}
        self.responseMessage = responseMessage as String
        
        completion(true)
      case .failure(let error):
        debugPrint(error.localizedDescription)
        completion(false)
      }

    }
  }
  
  
  func getRequestToBook(params: [String: Any], completion:@escaping (Bool) -> ()){
    let url = requestToBookUrl
    print(url)
    let token =  UserDefaults.standard.string(forKey: SessionManager.keys.accessToken) ?? ""
    let header = [
      
      "Authorization":"JWT " + token
    ]
    print(params, "parameters")
    Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header).responseJSON { response in

      print("Request: \(String(describing: response.request))")   // original url request
      print("Response: \(String(describing: response.response))") // http url response
      print("Result: \(response.result)")// response serialization result
      print(response)
      switch response.result{
      case .success(let value):
        guard let responseDict = value as? NSDictionary else {
          return
        }
        guard let responseMessage = responseDict["msg"] as? NSString else {return}
        self.responseMessage = responseMessage as String
        completion(true)
      case .failure(let error):
        debugPrint(error.localizedDescription)
        completion(false)
      }

    }
  }
  
}
