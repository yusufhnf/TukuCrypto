//
//  ApiService.swift
//  Toplists
//
//  Created by Yusuf Umar Hanafi on 12/02/22.
//

import Foundation
import Alamofire

class ApiService: Any {
  func get(_ url: String, parameters: Parameters? = nil, completion: @escaping (Result<Data, NetworkingErrorResponse>) -> Void) {
    let header : HTTPHeaders = []
    AF.request(url,method: .get, parameters: parameters, headers: header).validate().responseData { response in
      switch response.result {
      case let .success(value):
        completion(.success(value))
      case .failure(_):
        completion(.failure(.invalidResponse))
      }
    }
  }
}
