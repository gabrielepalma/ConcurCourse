//
//  InCoreDataFavorites.swift
//  FavoriteCats
//
//  Created by i335287 on 25/04/2018.
//  Copyright © 2018 i335287. All rights reserved.
//

import UIKit
import CoreData

class InCoreDataFavorites: FavoritesProtocol {
    var appDelegate : AppDelegate?
    var resultController : NSFetchedResultsController<NSFetchRequestResult>?
    let fileHelper = FileSystemHelper()

    init() {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        if let appDelegate = appDelegate {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
            let sort = NSSortDescriptor(key: "identifier", ascending: true)
            fetchRequest.sortDescriptors = [sort]
            resultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            try? resultController?.performFetch()
        }
    }

    func numberOfFavorites() -> Int {
        return resultController?.fetchedObjects?.count ?? 0
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
        if let resultController = resultController, let item = resultController.fetchedObjects![atIndex] as? Favorites {
            return item.identifier
        }
        return nil
    }

    func addFavorite(identifier: String, data: Data) {
        if let appDelegate = appDelegate {
            fileHelper.save(data: data, identifier: identifier)
            let newItem = Favorites(context: appDelegate.persistentContainer.viewContext)
            newItem.identifier = identifier
            appDelegate.saveContext()
            try? resultController?.performFetch()
        }
    }


}
