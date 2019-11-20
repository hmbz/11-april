//
//  detailModel.swift
//  OgreSpace
//
//  Created by admin on 7/10/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import Foundation


struct serviceModel {
  
  public private(set) var mapId :Int?
  public private(set) var ourService :String?
  public private(set) var otherService :String?
  public private(set) var logo16px :String?
  public private(set) var logo64px :String?
  public private(set) var checkBool :Bool?
  
}


struct detailModel {
  
  public private(set) var servicesArray :[serviceModel]?
  public private(set) var resultId :Int?
  public private(set) var property_link :String?
  public private(set) var Address :String?
  public private(set) var latitude :String?
  public private(set) var longitude :String?
  public private(set) var property_type :String?
  public private(set) var pic_url :String?
  public private(set) var one_pic :String?
  public private(set) var property_id :String?
  public private(set) var description :String?
  public private(set) var price :String?
  public private(set) var presented_name :String?
  public private(set) var state :String?
  public private(set) var zipcode :String?
  public private(set) var city : String?
  public private(set) var country :String?
  public private(set) var services :String?
  public private(set) var property_title :String?
  public private(set) var contact_no :String?
  public private(set) var active_bool :Bool?
  public private(set) var property_area :String?
  public private(set) var price_type :String?
  public private(set) var post_type :String?
  public private(set) var subspace_status :Bool?
  public private(set) var created :String?
  public private(set) var mappedbool :Bool?
  public private(set) var demographics :Bool?
  
}
struct userFavoritesModel {
  
  public private(set) var resultsId :Int?
  public private(set) var propertyId :Int?
  public private(set) var propertyTitle :String?
  public private(set) var propertyType :String?
  public private(set) var onePic :String?
  public private(set) var price :String?
  public private(set) var propertyArea :String?
  public private(set) var address :String?
  public private(set) var postType :String?
  public private(set) var latitude :String?
  public private(set) var longitude :String?
  public private(set) var createdAt :String?
  public private(set) var user :Int?
}


struct NearbyPlacesModel {
  
  let placeName: String?
  let placeAddress : String?
  let placeDistance :Int?
  let latitude: Double?
  let longitude: Double?
  
  
}

struct DemographicsModel {
  
//  let PopulationByOcupationData: PopulationByOcupationModel?
//  let EducationData: EducationModel?
//  let PopulationData: PopulationModel?
//  let EconomyData: EconomyModel?
//  let HomeOwnerDetailData: HomeOwnerDetailModel?
  let ForecastData: [Double]?
  let CrimeRateData: [CrimeRateModel]?
  let HomeValueData: [HomeValueModel]?
  let GenderRatioData: [GenderRatioModel]?
  let RentPaidData: [RentPaidModel]?
  let TotalHousesBuiltData: [TotalHousesBuiltModel]?
  let HouseholdDistributionData: [HouseholdDistributionModel]?
//  let PopulationByOcupation: PopulationByOcupationModel?
//  let PopulationByOcupation: PopulationByOcupationModel?
//  let PopulationByOcupation: PopulationByOcupationModel?
//  let PopulationByOcupation: PopulationByOcupationModel?
//  let PopulationByOcupation: PopulationByOcupationModel?
  
}

struct PopulationByOcupationModel {
  
  public private(set) var id :Float?
  public private(set) var agricultureForestryFishingHunting :Float?
  public private(set) var year :Float?
  public private(set) var miningOilGas :Float?
  public private(set) var construction :Float?
  public private(set) var manufacturing :Float?
  public private(set) var wholesaleTrade :Float?
  public private(set) var retailTrade :Float?
  public private(set) var transportationWareHousing :Float?
  public private(set) var utilities :Float?
  public private(set) var information :Float?
  public private(set) var financeInsurance :Float?
  public private(set) var realEstate :Float?
  public private(set) var scientificTechnical :Float?
  public private(set) var managementComapnies :Float?
  public private(set) var administrativeSupportWaste :Float?
  public private(set) var educationalServices :Float?
  public private(set) var healthCare :Float?
  public private(set) var artsEntertainment :Float?
  public private(set) var foodServices :Float?
  public private(set) var otherServices :Float?
  public private(set) var publicAdministration :Float?
  public private(set) var ZipCode :Float?

  
}

struct EducationModel {
  
  public private(set) var lessThanHighSchoolDiploma :Float?
  public private(set) var highSchoolGraduate :Float?
  public private(set) var associateDegree :Float?
  public private(set) var bachelorDegree :Float?
  public private(set) var MasterDegree :Float?
  public private(set) var enrolledPublicHighSchool :Float?
  public private(set) var enrolledPrivateHighSchool :Float?
  public private(set) var notEnrolledSchool :Float?
  public private(set) var professionalSchoolDegree :Float?
  public private(set) var doctorateDegree :Float?
  
}

struct PopulationModel {
  
  public private(set) var totalPoulation :Int?
  public private(set) var populationPRSQmile :Int?
  public private(set) var landArea :Float?
  public private(set) var waterArea :Float?
  public private(set) var populationYear :String?


}

struct EconomyModel {
  
  public private(set) var unemployementRate :Float?
  public private(set) var recentJobGrowth :Float?
  public private(set) var futureJobGrowth :Float?
  public private(set) var salesTaxes :Float?
  public private(set) var incomeTaxes :Float?
  public private(set) var incomePerCap :Float?
  public private(set) var familyMedianIncome :Float?
  
}

struct HomeOwnerDetailModel {
  
  public private(set) var unemployementRate :Float?
  public private(set) var recentJobGrowth :Float?
  public private(set) var futureJobGrowth :Float?
  public private(set) var salesTaxes :Float?
  public private(set) var incomeTaxes :Float?
  public private(set) var incomePerCap :Float?
  public private(set) var familyMedianIncome :Float?
  
}

struct ForecastModel {
  
  public private(set) var changePopulationPercent :Float?
  public private(set) var changePopulation :Float?
  public private(set) var growthRate :Float?
  public private(set) var foreCast2017 :Float?
  public private(set) var foreCast2018 :Float?
  public private(set) var foreCast2019 :Float?
  public private(set) var foreCast2020 :Float?
  
}

struct CrimeRateModel {
  
  public private(set) var crimeTitle :String?
  public private(set) var crimeCount :Int?
  
}

struct HomeValueModel {
  
  public private(set) var valuesDetail :String?
  public private(set) var noOfHouses :Int?
  
}

struct GenderRatioModel {
  
  public private(set) var under5Population :Double?
  public private(set) var under18Population :Double?
  public private(set) var above65Population :Double?
  public private(set) var femalePopulation :Double?
  public private(set) var malePopulation :Double?
  public private(set) var whitePopulation :Double?
  public private(set) var blackPopulation :Double?
  public private(set) var othersPopulation :Double?
  public private(set) var fullTimeEarnings :Double?
  public private(set) var partTimeEarnings :Double?
  
}

struct RentPaidModel {
  
  public private(set) var priceDetail :String?
  public private(set) var noOfPayers :Int?
  
  
}

struct TotalHousesBuiltModel {
  
  public private(set) var year :String?
  public private(set) var noOfHouses :Int?
  
}

struct HouseholdDistributionModel {
  
  public private(set) var id :Int?
  public private(set) var year :Int?
  public private(set) var incomeDistribution :String?
  public private(set) var noOfHouses :Int?
  public private(set) var zipCode :Int?

}
