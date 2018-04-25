//
//  GalleryViewController.swift
//  FavoriteCats
//
//  Created by i335287 on 25/04/2018.
//  Copyright © 2018 i335287. All rights reserved.
//

import UIKit
import Foundation

class GalleryViewController: UIViewController {

    let model : FavoritesProtocol = InMemoryFavorites()
    let catProvider = CatProvider()

    var currentData : Data?
    @IBOutlet var imageView : UIImageView?
    @IBOutlet var spinner : UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if currentData == nil {
            next()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setCurrentImageData(data : Data?) {
        if let data = data, let image = UIImage(data: data) {
            self.currentData = data
            self.imageView?.image = image
            self.spinner?.isHidden = true
            self.spinner?.stopAnimating()
        }
        else {
            self.currentData = nil
            self.imageView?.image = nil
            self.spinner?.isHidden = false
            self.spinner?.startAnimating()
        }
    }

    func next() {
        setCurrentImageData(data: nil)
        catProvider.nextImage { [weak self] (data) in
            DispatchQueue.main.async {
                if let strongSelf = self {
                    strongSelf.setCurrentImageData(data: data)
                }
            }
        }
    }

    @IBAction func discard() {
        next()
    }

    @IBAction func save() {
        guard let data = currentData, UIImage(data: data) != nil else {
            return
        }
        model.addFavorite(identifier: UUID().uuidString, data: data)
        next()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FavoritesTableViewController {
            vc.model = model
        }
    }


}
