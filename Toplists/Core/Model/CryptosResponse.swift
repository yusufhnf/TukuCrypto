//
//  CryptosResponse.swift
//  Toplists
//
//  Created by Yusuf Umar Hanafi on 12/02/22.
//

import Foundation

struct CryptosResponse: Decodable {
  let message : String
  let type    : Int
  let data    : [ToplistData]
  
  enum CodingKeys: String, CodingKey {
    case message = "Message"
    case type    = "Type"
    case data    = "Data"
  }
}

struct ToplistData: Decodable {
  let coinInfo : CoinInfoData
  let raw: Raw?
  
  enum CodingKeys: String, CodingKey {
    case coinInfo = "CoinInfo"
    case raw  = "RAW"
  }
}

struct CoinInfoData: Decodable {
  let id: String
  let name: String
  let fullName: String
  
  enum CodingKeys: String, CodingKey {
    case id = "Id"
    case name = "Name"
    case fullName = "FullName"
  }
}

struct Raw: Decodable{
  let usd: RawUsd
  
  private enum CodingKeys: String, CodingKey {
    case usd = "USD"
  }
}

struct RawUsd: Decodable {
  let price: Double
  let open24Hour: Double
  
  private enum CodingKeys: String, CodingKey {
    case price = "PRICE"
    case open24Hour = "OPEN24HOUR"
  }
}


