//
//  LiveProgressCryptoResponse.swift
//  Toplists
//
//  Created by Yusuf Umar Hanafi on 12/02/22.
//

import Foundation

struct LiveProgressCryptoResponse: Codable {
  let type: String
  let fromSymbol: String
  let price: Double
  let open24Hour: Double?
  
  private enum CodingKeys: String, CodingKey {
    case type = "TYPE"
    case fromSymbol = "FROMSYMBOL"
    case price = "PRICE"
    case open24Hour = "OPEN24HOUR"
  }
}
