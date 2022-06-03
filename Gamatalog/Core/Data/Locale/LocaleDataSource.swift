//
//  LocaleDataSource.swift
//  Gamatalog
//
//  Created by Angelica Roseanne on 22/11/21.
//

import Foundation
import RealmSwift
import Combine

protocol LocaleDataSourceProtocol: AnyObject {
    func getGameList() -> AnyPublisher<[GameEntity], Error>
    func addGameList(from games: [GameEntity]) -> AnyPublisher<Bool, Error>
    func getFavoritedGames() -> AnyPublisher<[GameEntity], Error>
    func addGameToFavorite(from game: GameEntity) -> AnyPublisher<Bool, Error>
    func removeGameFromFavorite(from game: GameEntity) -> AnyPublisher<Bool, Error>
}

final class LocaleDataSource: NSObject {
    
    private let realm: Realm?
    private init(realm: Realm?) {
        self.realm = realm
    }
    static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in return LocaleDataSource(realm: realmDatabase)
    }
    
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    
    func getGameList() -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            if let realm = self.realm {
                let games: Results<GameEntity> = {
                    realm.objects(GameEntity.self)
                }()
                completion(.success(games.toArray(ofType: GameEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func addGameList(
        from games: [GameEntity]
    ) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for game in games {
                            realm.add(game, update: .all)
                        }
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getFavoritedGames() -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            if let realm = self.realm {
                let games: Results<GameEntity> = {
                    realm.objects(GameEntity.self)
                        .filter("favorite = \(true)")
                }()
                completion(.success(games.toArray(ofType: GameEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func addGameToFavorite(from game: GameEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        if realm.isInWriteTransaction {
                            if realm.object(ofType: GameEntity.self, forPrimaryKey: game.id) == nil {
                                completion(.failure(DatabaseError.requestFailed))
                            } else {
                                game.favorite = true
                                realm.add(game, update: .all)
                                completion(.success(true))
                            }
                        } else {
                            completion(.failure(DatabaseError.requestFailed))
                        }
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func removeGameFromFavorite(from game: GameEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
          if let realm = self.realm {
            do {
              try realm.write {
                let objectsToDelete = realm.objects(GameEntity.self)
                  .filter("id = \(game.id)")
                
                realm.delete(objectsToDelete)
                completion(.success(false))
              }
            } catch {
              completion(.failure(DatabaseError.requestFailed))
            }
          } else {
            completion(.failure(DatabaseError.invalidInstance))
          }
        }
        .eraseToAnyPublisher()
    }
}

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
    
}
