//
//  CatProvider.swift
//  FavoriteCats
//
//  Created by i335287 on 25/04/2018.
//  Copyright © 2018 i335287. All rights reserved.
//

import UIKit

class CatProvider: NSObject {
    var dataTask : URLSessionDataTask?
    func nextImage(completion: @escaping (Data?) -> Void) {
        dataTask?.cancel()
        print("querying http://thecatapi.com/api/images/get?format=src")
        if let url = URL(string: "http://thecatapi.com/api/images/get?format=src") {
            dataTask = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                print("response from http://thecatapi.com/api/images/get?format=src")
                guard error == nil else {
                    print("error: \(error?.localizedDescription ?? "")")
                    return
                }
                if let data = data, UIImage(data: data) != nil {
                    completion(data)
                    return
                }
            })
        }
        dataTask?.resume()
    }
}


