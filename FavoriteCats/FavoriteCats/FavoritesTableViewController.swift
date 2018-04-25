//
//  FavoritesTableViewController.swift
//  FavoriteCats
//
//  Created by i335287 on 25/04/2018.
//  Copyright © 2018 i335287. All rights reserved.
//

import UIKit

class FavoritesTableViewCell : UITableViewCell {
    @IBOutlet var catImage : UIImageView?
    @IBOutlet var catIdentifier : UILabel?
}

class FavoritesTableViewController: UITableViewController {

    var model : FavoritesProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.numberOfFavorites() ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FavoritesTableViewCell else {
            return UITableViewCell()
        }

        if let identifier = model?.identifier(atIndex: indexPath.row) {
            cell.catIdentifier?.text = identifier
        }

        if let image = model?.image(atIndex: indexPath.row) {
            cell.catImage?.image = image
        }

        return cell
    }

}
