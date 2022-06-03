//
//  CustomErrorExt.swift
//  Gamatalog
//
//  Created by Angelica Roseanne on 20/11/21.
//

import Foundation

enum URLError: LocalizedError {

  case invalidResponse
  case addressUnreachable(URL)
  
  var errorDescription: String? {
    switch self {
    case .invalidResponse:
        return "Sorry, invalid response"
    case .addressUnreachable(let url):
        return "\(url.absoluteString) is unreachable."
    }
  }
}

enum DatabaseError: LocalizedError {

  case invalidInstance
  case requestFailed
  
  var errorDescription: String? {
    switch self {
    case .invalidInstance: return "Invalid Instance database"
    case .requestFailed: return "Sorry, failed request"
    }
  }

}
