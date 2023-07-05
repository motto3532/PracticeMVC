//
//  TableViewController.swift
//  PracticeMVC
//
//  Created by Atto Rari on 2023/06/28.
//

import UIKit

final class TableViewController: UIViewController {
    private let cellClassName = "TableViewCell"
    private let reuseID = "cell"
    
    private var okashiList: [Okashi] = []
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            //xib読み込み
            let cellNib = UINib(nibName: cellClassName, bundle: nil)
            //TableViewにセルを登録
            tableView.register(cellNib, forCellReuseIdentifier: reuseID)
            //推定の高さ
            tableView.estimatedRowHeight = 200 * 10
            //実際の高さ
            tableView.rowHeight = 200
            //何も表示するものないからhidden
            tableView.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        //循環参照注意
        API.shared.searchOkashi(keyword: "カレー味") {[weak self] okashiList in /*弱参照*/
            //selfが解放されている場合を考慮して、Optional Chainingで安全にアクセス
            self?.okashiList = okashiList
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.tableView.isHidden = false
            }
        }
    }
}
    
extension TableViewController: UITableViewDelegate {
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return okashiList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(okashi: okashiList[indexPath.row])
        return cell
    }
}
