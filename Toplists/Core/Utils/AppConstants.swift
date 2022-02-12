//
//  AppConstants.swift
//  Toplists
//
//  Created by Yusuf Umar Hanafi on 09/02/22.
//

import Foundation

struct AppConstants {
  struct Network {
    static let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String
    static let cryptoBaseUrl = "https://min-api.cryptocompare.com"
    static let cryptoWsUrl = "wss://streamer.cryptocompare.com/v2?api_key=\(apiKey ?? "")"
    static let newsUrl = "\(cryptoBaseUrl)/data/v2/news/?categories="
    static let cryptoDataEndpoint = "/data/top/totaltoptiervolfull?limit=50&tsym=USD"
  }
  struct Title {
    static let homeTitle = "Toplists"
  }
  struct CellIdentifier {
    static let cryptoCell = "CryptoCellIdentifier"
  }
}
