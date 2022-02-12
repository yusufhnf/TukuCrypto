//
//  NewsResponse.swift
//  Toplists
//
//  Created by Yusuf Umar Hanafi on 12/02/22.
//

import Foundation

struct NewsResponse: Decodable {
  let message : String
  let type    : Int
  let data    : [NewsData]
  
  enum CodingKeys: String, CodingKey {
    case message = "Message"
    case type    = "Type"
    case data    = "Data"
  }
}

struct NewsData: Decodable {
  let title       : String
  let body        : String
  let sourceData  : SourceData
  
  enum CodingKeys: String, CodingKey {
    case title, body
    case sourceData = "source_info"
  }
}

struct SourceData: Decodable {
  let name: String
}
