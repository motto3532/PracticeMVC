//
//  TableViewController.swift
//  PracticeMVC
//
//  Created by Atto Rari on 2023/06/28.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource {
    let cellClassName = "TableViewCell"
    let reuseId = "TableViewCell"
    
    var users: [UserModel] = []

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let cellNib = UINib(nibName: cellClassName, bundle: nil)
            tableView.register(cellNib, forCellReuseIdentifier: reuseId)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tableView.isHidden = true
        
        //APIでユーザーを取得してくる代わり
        let newUsers: [[String: Any]] = [
            ["name": "たろう", "age": 18, "occupation": "東京"],
            ["name": "かな", "age": 22, "occupation": "福岡"],
            ["name": "こうき", "age": 30, "occupation": "広島"],
            ["name": "ゆうこ", "age": 14, "occupation": "北海道"],
            ["name": "たけし", "age": 50, "occupation": "富山"],
            ["name": "さき", "age": 33, "occupation": "千葉"],
        ]
        
        for user in newUsers {
            users.append(
                UserModel(
                    name: user["name"] as! String,
                    age: user["age"] as! Int,
                    occupation: user["occupation"] as! String
                )
            )
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as? TableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: reuseId)
        }
        
        let user = users[indexPath.row]
        cell.configure(user: user)
        
        return cell
    }
}
