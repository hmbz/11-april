//
//  GlobalStrings.swift
//  OgreSpace
//
//  Created by admin on 7/1/19.
//  Copyright © 2019 brainplow. All rights reserved.
//

import Foundation

//MARK:- URL
var baseUrl = "https://apis.officedoor.ai/"
var storagePath = "https://storage.officedoor.ai/OfficeImages/"
var storageFeaturesImages  = "https://storage.officedoor.ai/serviceslogo/"
var loginUrl = baseUrl + "login/"   // use
var isActiveUrl = baseUrl + "user/IsActive1/"
var socailLoginUrl = baseUrl + "/user/sociallogin/"
var forgotPassUrl = baseUrl + "user/ForgetPssword/" //use
var registerUrl = baseUrl + "user/createuser/" // use
var emailVerifyUrl = baseUrl + "user/EmailVerify/" // use
var usernameUrl = baseUrl + "user/UsernameVerify/" // use
var statesUrl = baseUrl + "office/state_list/" // use
var statePropertiesUrl = baseUrl + "office/state_properties/" // use
var SalePropertyUrl = baseUrl + "office/Sale_Property_android/" //use
var LeasePropertyUrl = baseUrl + "office/Lease_Proterties_android/"//use
var userProfileUrl = baseUrl + "user/GetUserDetail/" // use
var updateProfileUrl = baseUrl + "user/UpdateProfile/" //use
var changepasswordUrl = baseUrl + "/user/user_change_password/"
var detailUrl = baseUrl + "office/property_detail_by_id/"
var similarPropertyUrl = baseUrl + "office/similar_properties/"
var userFavoritesUrl = baseUrl + "office/get_user_favourite/"
//var searchLocationsUrl = baseUrl + "office/search_suggestions/"
let searchUrl = baseUrl + "office/Search_api/"
//var searchedResultsUrl = baseUrl + "office/search_properties1/"
var CategoriesUrl = baseUrl + "office/property_type/"
//var CategoryDetailUrl = baseUrl + "office/Category_Property_android/"
//var filterPropertyUrl = baseUrl + "office/filter_properties1/"
var paymentMethodUrl = baseUrl + "payment/cardinfo/"
var servicesUrl = baseUrl + "office/listing_services/"
var recentlyViewedUrl = baseUrl + "office/recently_viewed_android/"
var myPropertyUrl = baseUrl + "office/user_properties/"
var addListingUrl = baseUrl + "office/add_listing/"
var nearbyPlacesUrl = baseUrl + "office/nearbyPlaces/"
var requestToBookUrl = baseUrl + "office/request_book/"
var scheduleTourUrl = baseUrl + "office/schedule_tour/"
var demographicsUrl = baseUrl + "office/demographics_info/"
let addToFavouritesUrl = baseUrl + "office/user_favourite/"
let removeFromFavouritesUrl = baseUrl + "office/delete_user_favourite/"
let cadUrl = baseUrl + "office/default_cad/"

let propertyOverviewUrl = baseUrl +  "office/overview_list/"

//MARK:- Public Strings

let propertyTypeArray = ["Lease","Sale"]
let spaceTypeArray = ["Offices","Retail","Co Working","Land","Industrial"]
let minPricingArray = ["$ Any","$ 0","$ 100,000","$ 200,000","$ 300,000","$ 400,000","$ 500,000","$ 600,000","$ 700,000"]
let maxPricingArray = ["$ 100,000","$ 200,000","$ 300,000","$ 400,000","$ 500,000","$ 600,000","$ 700,000","$ 800,000"]
let minSpaceArray = ["500 sqft","1000 sqft","1500 sqft","2000 sqft","2500 sqft","3000 sqft","3500 sqft","4000 sqft"]
let maxSpaceArray = ["500 sqft","1000 sqft","1500 sqft","2000 sqft","2500 sqft","3000 sqft","3500 sqft","4000 sqft","4500 sqft"]

//MARK:- Type Alias
typealias CompletionHandler = (_ Success: Bool) -> ()

let strSpeechRecPerNotGranted = "Speech Recognition Permission not granted."
let strSpeechRecPerRestricted = "Speech Recognition Permission Restricted."
let strSpeechRecPerNotDetermined = "Speech Recognition Permission not Determined."

  let shareString : String = "Hi, I want to invite you to download and start using the FREE OgreSpace App for Listings, Demographics, AI-Driven Insights. OgreSpace - The Next Generation Commercial Real Estate Universe."

 let urlAppStore = URL.init(string: "https://apps.apple.com/us/app/ogrespace/id1470936840")!
//let strSpeechRecPerDenied = "Speech Recognition Permission not Determined."

