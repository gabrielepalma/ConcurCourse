//
//  FavoritesProtocol.swift
//  FavoriteCats
//
//  Created by i335287 on 25/04/2018.
//  Copyright © 2018 i335287. All rights reserved.
//

import UIKit

protocol FavoritesProtocol  {
    func numberOfFavorites() -> Int
    func data(atIndex: Int) -> Data?
    func image(atIndex: Int) -> UIImage?
    func identifier(atIndex : Int) -> String?
    func addFavorite(identifier: String, data: Data)
}

class InMemoryFavorites : FavoritesProtocol {
    var favorites : [(String, Data)] = [(String, Data)]()
   
    func numberOfFavorites() -> Int {
        return favorites.count
    }

    func image(atIndex: Int) -> UIImage? {
        if let data = data(atIndex: atIndex), let image = UIImage(data: data) {
            return image
        }
        return nil
    }

    func identifier(atIndex: Int) -> String? {
        if atIndex < favorites.count {
            return favorites[atIndex].0
        }
        return nil
    }

    func data(atIndex: Int) -> Data? {
        if atIndex < favorites.count {
            return favorites[atIndex].1
        }
        return nil
    }

    func addFavorite(identifier: String, data: Data) {
        guard UIImage(data: data) != nil else {
            return
        }
        favorites.append((identifier, data))
    }
}
