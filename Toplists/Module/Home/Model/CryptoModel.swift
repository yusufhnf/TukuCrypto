//
//  CryptoModel.swift
//  Toplists
//
//  Created by Yusuf Umar Hanafi on 11/02/22.
//

import Foundation

enum CryptosModel {
  struct DisplayedCryptos {
    let name: String
    let fullName: String
    var price: String?
    var priceChange: String?
    var isNegative: Bool?
    let hasEmptyPrice: Bool
  }
  
  struct ResponseCryptos {
    let hasEmptyPrice: Bool
    let name: String
    let fullName: String
    let price: Double?
    let priceChangePct: Double?
    let priceChange: Double?
    let isNegative: Bool?
  }
  
  enum FetchCryptos {
    struct Response {
      let responseCryptos: [ResponseCryptos]?
      var error: NetworkingErrorResponse?
    }
    struct ViewModel {
      var error: NetworkingErrorResponse?
      var displayedCryptos: [DisplayedCryptos]?
    }
  }
  
  enum SubscribePriceChange {
    struct Response {
      let updatedCryptos: ResponseCryptos
      let index: Int
    }
    
    struct ViewModel {
      let index: Int
      let displayedCryptos: DisplayedCryptos
    }
  }
}
