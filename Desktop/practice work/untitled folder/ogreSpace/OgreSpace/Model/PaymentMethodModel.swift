//
//  PaymentMethodModel.swift
//  OgreSpace
//
//  Created by MAC on 31/07/2019.
//  Copyright © 2019 brainplow. All rights reserved.
//

import Foundation
struct paymentCardDetailModel {
  public private(set) var detailID: Int!
  public private(set) var paymentCardCVV: String!
  public private(set) var paymentCardType: String!
  public private(set) var expiryCardDate: String!
  public private(set) var cardNumber : String!
  public private(set) var zipCode: String!
  public private(set) var defualt: Bool!
  public private(set) var nickName: String!
  public private(set) var street_address: String!
  public private(set) var city: String!
  public private(set) var state: String!
  public private(set) var country: String!
  public private(set) var autopay: Bool!
  
}
