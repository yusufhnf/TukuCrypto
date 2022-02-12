//
//  CryptosRepository.swift
//  Toplists
//
//  Created by Yusuf Umar Hanafi on 12/02/22.
//

import Foundation

class CryptosRepository: ApiService {
  static let shared = CryptosRepository()
  func getCryptosData(completion: @escaping (Result<Data, NetworkingErrorResponse>) -> Void) {
    let url = AppConstants.Network.cryptoBaseUrl + AppConstants.Network.cryptoDataEndpoint
    get(url) { result in
      switch result {
      case let .success(value):
        completion(.success(value))
      case let .failure(error):
        completion(.failure(error))
      }
    }
  }
}
