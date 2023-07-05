//
//  TableViewCell.swift
//  PracticeMVC
//
//  Created by Atto Rari on 2023/06/28.
//

import UIKit

final class TableViewCell: UITableViewCell {

    @IBOutlet private weak var itemImage: UIImageView!
    @IBOutlet private weak var itemName: UILabel!
    @IBOutlet private weak var itemMaker: UILabel!
    
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
