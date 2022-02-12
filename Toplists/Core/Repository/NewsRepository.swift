//
//  NewsRepository.swift
//  Toplists
//
//  Created by Yusuf Umar Hanafi on 12/02/22.
//

import Foundation

class NewsRepository: ApiService {
  static let shared = NewsRepository()
  func getCryptosData(categoryParams: String, completion: @escaping (Result<Data, NetworkingErrorResponse>) -> Void) {
    let url = AppConstants.Network.newsUrl + "\(categoryParams)"
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
