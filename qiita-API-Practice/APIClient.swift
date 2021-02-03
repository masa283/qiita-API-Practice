//
//  APIClient.swift
//  qiita-API-Practice
//
//  Created by Masateru Maegawa on 2021/02/03.
//  Copyright © 2021 Masateru Maegawa. All rights reserved.
//

import Foundation

struct Article: Codable {
    var title: String
}


enum NetworkError: Error {
    case unknown
    case invalidResponse
    case invalidURL

}

class APIClient {
    static func request(success: @escaping ([Article]) -> (), // 通信成功時のクロージャ
                        failure: @escaping (Error) -> ()){    // 通信失敗時のクロージャ

        guard let url = URL(string: "http://qiita.com/api/v2/items") else {
            failure(NetworkError.invalidURL)
            return
        }

        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if (error != nil) {
            failure(error!)
                return
            }
            guard let data = data else {
                failure(NetworkError.unknown)
                return
            }

            let decoder = JSONDecoder()

            guard let articles = try? decoder.decode([Article].self, from: data) else {
                failure(NetworkError.invalidResponse)
                return
            }
            success(articles)
        })
        task.resume()
    }
}
