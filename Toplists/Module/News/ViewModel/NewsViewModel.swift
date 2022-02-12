//
//  NewsViewModel.swift
//  Toplists
//
//  Created by Yusuf Umar Hanafi on 12/02/22.
//

import Foundation

class NewsViewModel {
  private let newsRepository: NewsRepository
  var newsData: [NewsData] = []
  
  init(newsRepository: NewsRepository = NewsRepository.shared) {
    self.newsRepository = newsRepository
  }
  
  func fetchNews(_ category: String, completion: @escaping ([NewsData]?, NetworkingErrorResponse?) -> Void) {
    DispatchQueue.global().async {
      self.newsRepository.getCryptosData(categoryParams: category) { result in
        switch result {
        case let .success(data):
          do {
            let dataObj = try JSONDecoder().decode(NewsResponse.self, from: data)
            let newsData = dataObj.data
            completion(newsData, nil)
          } catch {
            completion(nil, .invalidResponse)
          }
        case .failure(_):
          completion(nil, .invalidRequest)
        }
      }
    }
  }
}
