//
//  TableViewCell.swift
//  PracticeMVC
//
//  Created by Atto Rari on 2023/06/28.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var occupationLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        ageLabel.text = nil
        occupationLabel.text = nil
    }
    
    func configure(user: UserModel) {
        nameLabel.text = user.name
        ageLabel.text = user.age
        occupationLabel.text = user.occupation
    }
    
}
