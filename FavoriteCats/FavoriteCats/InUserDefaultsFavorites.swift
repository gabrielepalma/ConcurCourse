//
//  InUserDefaultsFavorites.swift
//  FavoriteCats
//
//  Created by i335287 on 25/04/2018.
//  Copyright © 2018 i335287. All rights reserved.
//

import UIKit

class InUserDefaultsFavorites: FavoritesProtocol {
    var favorites : [String]?
    let fileHelper = FileSystemHelper()

    init() {
        favorites = UserDefaults.standard.object(forKey: "favorites") as? [String] ?? [String]()
    }
    func numberOfFavorites() -> Int {
        return favorites?.count ?? 0
    }

    func data(atIndex: Int) -> Data? {
        if let identifier = identifier(atIndex: atIndex) {
            return fileHelper.read(identifier: identifier)
        }
        return nil
    }

    func image(atIndex: Int) -> UIImage? {
        if let data = data(atIndex: atIndex), let image = UIImage(data: data) {
            return image
        }
        return nil
    }

    func identifier(atIndex: Int) -> String? {
        if let favorites = favorites {
            if atIndex < favorites.count {
                return favorites[atIndex]
            }
        }
        return nil
    }

    func addFavorite(identifier: String, data: Data) {
        fileHelper.save(data: data, identifier: identifier)
        favorites?.append(identifier)
        UserDefaults.standard.set(favorites, forKey: "favorites")
    }


}
