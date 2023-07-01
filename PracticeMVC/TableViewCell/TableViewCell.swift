//
//  TableViewCell.swift
//  PracticeMVC
//
//  Created by Atto Rari on 2023/06/28.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemMaker: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemName = nil
        itemImage = nil
        itemMaker = nil
    }
}
