//
//  ViewController.swift
//  qiita-API-Practice
//
//  Created by Masateru Maegawa on 2021/02/03.
//  Copyright © 2021 Masateru Maegawa. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var articles: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        // 通信のリクエストを送信
        APIClient.request(success: {(articles) in // 通信成功時のクロージャ
            DispatchQueue.main.async {
                self.articles = articles
                self.tableView.reloadData()
            }
        }) { (error) in
            print(error)
        }
    }
}

extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = articles[indexPath.row].title
        return cell
    }
}




