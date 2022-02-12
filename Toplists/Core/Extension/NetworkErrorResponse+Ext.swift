//
//  NetworkErrorResponse+Ext.swift
//  Toplists
//
//  Created by Yusuf Umar Hanafi on 12/02/22.
//

import Foundation

enum NetworkingErrorResponse: String, Error {
  case invalidResponse = "Terjadi kesalahan dalam pengambilan data"
  case invalidRequest  = "Terjadi kesalahan pada koneksi internet"
}

extension NetworkingErrorResponse: LocalizedError {
  var errorDescription: String? {
    return NSLocalizedString(rawValue, comment: "")
  }
}
