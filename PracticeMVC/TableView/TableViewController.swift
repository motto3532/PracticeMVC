//
//  TableViewController.swift
//  PracticeMVC
//
//  Created by Atto Rari on 2023/06/28.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let cellClassName = "TableViewCell"
    let reuseId = "TableViewCell"
    
    var itemList: [(name: String, maker: String, link: URL, image: URL)] = []

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let cellNib = UINib(nibName: cellClassName, bundle: nil)
            tableView.register(cellNib, forCellReuseIdentifier: reuseId)
            
            tableView.estimatedRowHeight = UITableView.automaticDimension
            tableView.rowHeight = UITableView.automaticDimension
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //self.tableView.isHidden = true
        
        //API
        let keyword = "サラダ"
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        guard let req_url = URL(string: "https://sysbird.jp/toriko/api/?apikey=guest&format=json&keyword=\(keyword_encode)&max=10&order=r") else {
            return
        }
        print("req_url:", req_url)
        let req = URLRequest(url: req_url)
        print("req:", req)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: req, completionHandler: {(data, response, error) in
            session.finishTasksAndInvalidate()
            do {
                let decoder = JSONDecoder()
                print("decoder:", decoder)
                print("data:", data!)
                let json = try decoder.decode(ResultItems.self, from: data!)
                print("json:", json)
                
                if let items = json.items {
                    for item in items {
                        if let name = item.name, let maker = item.maker, let link = item.url, let image = item.image {
                            let newItem = (name, maker, link, image)
                            self.itemList.append(newItem)
                        }
                    }
                    self.tableView.reloadData()
                }
            } catch {
                print("error:", error)
            }
        })
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as? TableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: reuseId)
        }
        
        cell.itemName.text = itemList[indexPath.row].name
        cell.itemMaker.text = itemList[indexPath.row].maker
        if let imageData = try? Data(contentsOf: itemList[indexPath.row].image) {
            cell.itemImage.image = UIImage(data: imageData)
        }
        
        return cell
    }
}
