//
//  FileSystemHelper.swift
//  FavoriteCats
//
//  Created by i335287 on 25/04/2018.
//  Copyright © 2018 i335287. All rights reserved.
//

import UIKit
import Foundation

class FileSystemHelper: NSObject {
    var directory : URL?
    override init() {
        directory = try? FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }

    func save(data : Data, identifier : String) {
        if let fileUrl = directory?.appendingPathComponent(identifier) {
            try? data.write(to: fileUrl)
        }
    }

    func read(identifier : String) -> Data? {
        if let fileUrl = directory?.appendingPathComponent(identifier) {
            return try? Data(contentsOf: fileUrl)
        }
        return nil
    }

}
