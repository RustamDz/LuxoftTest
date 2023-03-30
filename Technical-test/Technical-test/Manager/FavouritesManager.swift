//
//  FavouritesManager.swift
//  Technical-test
//
//  Created by Rustam Dzhumaniazov on 30.03.2023.
//

import Foundation

class FavouritesManager {
    private static var favourites: Set<String> = Set()
    
    init() {
        let ud = UserDefaults.standard
        FavouritesManager.favourites = Set(ud.stringArray(forKey: "favourites") ?? [])
    }
    
    func isFavourite(quote: Quote) -> Bool {
        guard let key = quote.key else { return false }
        return FavouritesManager.favourites.contains(key)
    }
    
    func addFavourite(quote: Quote) {
        guard let key = quote.key else { return }
        FavouritesManager.favourites.insert(key)
        let ud = UserDefaults.standard
        ud.setValue(Array(FavouritesManager.favourites), forKey: "favourites")
        ud.synchronize()
    }
    
    func removeFavourite(quote: Quote) {
        guard let key = quote.key else { return }
        FavouritesManager.favourites.remove(key)
        let ud = UserDefaults.standard
        ud.setValue(Array(FavouritesManager.favourites), forKey: "favourites")
        ud.synchronize()
    }
}
