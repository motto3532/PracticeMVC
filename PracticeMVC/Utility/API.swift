//
//  API.swift
//  PracticeMVC
//
//  Created by Atto Rari on 2023/07/04.
//

import Foundation

final class API {
    static let shared = API()
    private init() {}
    
    func searchOkashi(keyword: String, completion: (([Okashi]) -> Void)? = nil) {
        //検索ワード
        guard let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        //URL
        let urlStr = "https://sysbird.jp/toriko/api/?apikey=guest&format=json&max=10&order=r"
        let urlStrWithParameter = urlStr + "&keyword=\(encodedKeyword)"
        guard let url = URL(string: urlStrWithParameter) else {
            completion?([])
            return
        }
        
        //リクエスト
        let urlRequest = URLRequest(url: url)
        
        //セッション
        let session = URLSession.shared
        
        //タスク
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                completion?([])
                return
            }
            //アンラップ
            guard
                let data = data,
                let responseJson = try? JSONDecoder().decode(ResponseData.self, from: data)/*try?は失敗したらnil。つまりアンラップ失敗*/
            else {
                completion?([])
                return
            }
            //通信成功
            let okashiList = responseJson.item
            completion?(okashiList)
        }
        //タスク実行
        task.resume()
    }
}
