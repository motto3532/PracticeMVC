//
//  TableViewController.swift
//  PracticeMVC
//
//  Created by Atto Rari on 2023/06/28.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let cellClassName = "TableViewCell"
    let reuseID = "cell"
    
    var okashiList: [Okashi] = []
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            //xib読み込み
            let cellNib = UINib(nibName: cellClassName, bundle: nil)
            //TableViewにセルを登録
            tableView.register(cellNib, forCellReuseIdentifier: reuseID)
            //推定の高さ
            tableView.estimatedRowHeight = 200 * 10
            //実際の高さ
            tableView.rowHeight = 200
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        searchOkashi(keyword: "カレー味")
    }
    
    func searchOkashi(keyword: String) {
        //検索ワード
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        //リクエストURL
        guard let req_url = URL(string: "https://sysbird.jp/toriko/api/?apikey=guest&format=json&keyword=\(keyword_encode)&max=10&order=r") else {
            return
        }
        
        //リクエスト
        let req = URLRequest(url: req_url)
        //セッション
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        //タスク
        let task = session.dataTask(with: req, completionHandler: {(data, response, error) in
            session.finishTasksAndInvalidate()
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(ResultJson.self, from: data!)
                
                if let items = json.item {
                    for item in items {
                        if let name = item.name, let maker = item.maker, let image = item.image {
                            let newOkashi = Okashi(name: name, maker: maker, image: image)
                            self.okashiList.append(newOkashi)
                        }
                    }
                    self.tableView.reloadData()
                }
            } catch {
                print(error)
            }
        })
        task.resume()
    }
    
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
