//
//  RemoteDataSource.swift
//  Gamatalog
//
//  Created by Angelica Roseanne on 20/11/21.
//

import Alamofire
import SwiftUI
import Combine

protocol RemoteDataSourceProtocol: AnyObject {
    func getGameList() -> AnyPublisher<[GameResponse], Error>
    func getGameDetail(gameId: Int, result: @escaping (Result<String, URLError>) -> Void)
    func getGameScreenshot(gameId: Int, result: @escaping (Result<[GameImg], URLError>) -> Void)
}

final class RemoteDataSource: NSObject {
    private override init() { }
    
    static let sharedInstance: RemoteDataSource =  RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getGameList() -> AnyPublisher<[GameResponse], Error> {
        return Future<[GameResponse], Error> { completion in
            if let url = URL(string: Endpoints.Gets.gameList.url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GamesResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.results))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getGameDetail(gameId: Int, result: @escaping (Result<String, URLError>) -> Void) {
        guard let url = URL(string: Endpoints.Gets.gameDetail.url + "\(gameId)?key=\(getApiKey())") else { return }
        
        AF.request(url)
            .validate()
            .responseDecodable(of: GameDetailResponse.self) { response in
                switch response.result {
                case .success(let value): result(.success(value.description))
                case .failure:
                    result(.failure(.invalidResponse))
                }
            }
    }
    
    func getGameScreenshot(gameId: Int, result: @escaping (Result<[GameImg], URLError>) -> Void) {
        guard let url = URL(string: Endpoints.Gets.gameScreenshot.url + "\(gameId)/screenshots?key=\(getApiKey())") else { return }
        
        AF.request(url)
            .validate()
            .responseDecodable(of: GameScreenshots.self) { response in
                switch response.result {
                case .success(let value): result(.success(value.results))
                case .failure:
                    result(.failure(.invalidResponse))
                }
            }
    }
}
