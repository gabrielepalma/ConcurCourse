//
//  Favorites+CoreDataProperties.swift
//  FavoriteCats
//
//  Created by i335287 on 25/04/2018.
//  Copyright © 2018 i335287. All rights reserved.
//
//

import Foundation
import CoreData


extension Favorites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorites> {
        return NSFetchRequest<Favorites>(entityName: "Favorites")
    }

    @NSManaged public var identifier: String?

}
