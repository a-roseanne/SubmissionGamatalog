//
//  Injection.swift
//  Gamatalog
//
//  Created by Angelica Roseanne on 20/11/21.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
    
    private func provideRepository() -> GameRepositoryProtocol {
        let realm = try? Realm()
        
        let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return GameRepository.sharedInstance(locale, remote)
    }
    
    func provideHome() -> HomeUseCase {
        let repo = provideRepository()
        return HomeInteractor(repository: repo)
    }
    
    func provideDetail(game: GameModel) -> DetailUseCase {
        let repo = provideRepository()
        return DetailInteractor(repository: repo, game: game)
    }
    
    func provideFavorite() -> FavoriteUseCase {
      let repository = provideRepository()
      return FavoriteInteractor(repository: repository)
    }
}
