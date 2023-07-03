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
        itemName.text = nil
        itemImage.image = nil
        itemMaker.text = nil
    }
    
    func configure(okashi: Okashi) {
        itemName.text = okashi.name
        itemMaker.text = okashi.maker
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: okashi.image) {
                DispatchQueue.main.async {
                    self.itemImage.image = UIImage(data: imageData)
                }
            }
        }
    }
}
