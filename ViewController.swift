//
//  ViewController.swift
//  Stiri2
//
//  Created by Cristian Macovei on 08.03.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return table
    }()
    
    private var viewModelss = [NewsTableViewCellViewModel]()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        title = "News"
        view.backgroundColor = .systemBackground
        
        print("APICaller about to be called")
        
        APICaller.shared.getTopStories { results in
            switch results {
            case .success(let articles):
                print("Case success")
                self.viewModelss = articles.compactMap({
                    NewsTableViewCellViewModel(title: $0.title,
                                               subTitle: $0.description ?? "No decription",
                                               imageURL: URL(string: $0.urlToImage ?? ""))
                })
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("There was an error: \(error)")
            }
            print("Whatever")
            
            
            /// REWRITE THIS TO SEE WHAT IS WRONG
            
            //        APICaller.shared.getTopStories { [weak self] result in
            //            switch result {
            //            case .success(let articles):
            //                print("Case success")
            //                self?.viewModelss = articles.compactMap({
            //                    NewsTableViewCellViewModel(
            //                        title: $0.title,
            //                        subTitle: $0.description ?? "No description",
            //                        imageURL: URL(string: $0.urlToImage ?? "")
            //                    )
            //                })
            //                print(articles.count)
            //                DispatchQueue.main.async {
            //                    self?.tableView.reloadData()
            //                }
            //
            //            case .failure(let error):
            //                print("Case error")
            //                print(error)
            //            }
        }
        print("Whatever")
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //print(tableView.dataSource)
        tableView.frame = view.bounds
    }

    //Table View Protocols
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelss.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell1 = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            fatalError()
        }
        print(cell1.description)
        cell1.configure(with: viewModelss[indexPath.row])
        return cell1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

