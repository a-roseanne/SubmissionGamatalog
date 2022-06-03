//
//  APICall.swift
//  Gamatalog
//
//  Created by Angelica Roseanne on 20/11/21.
//

import Foundation

func getApiKey() -> String {
    guard let filePath = Bundle.main.path(forResource: "PrivateInfo", ofType: "plist") else {
      fatalError("Couldn't find file Private Keys")
    }
    let plist = NSDictionary(contentsOfFile: filePath)
    guard let value = plist?.object(forKey: "API_KEY") as? String else {
      fatalError("Couldn't find key 'API_KEY'")
    }
    return value
}

struct API {
    static let baseUrl = "https://api.rawg.io/api/games"
}

protocol Endpoint {
    var url: String { get }
}

enum Endpoints {
    enum Gets: Endpoint {
        case gameList
        case gameDetail
        case gameScreenshot
        case searchGame
        
        public var url: String {
            switch self {
            case .gameList:
                return "\(API.baseUrl)?key=\(getApiKey())"
            case .gameDetail:
                return "\(API.baseUrl)/"
            case .gameScreenshot:
                return "\(API.baseUrl)/"
            case .searchGame:
                return "\(API.baseUrl)?search="
            }
        }
    }
}
