//
//  ArticlesViewController.swift
//  navigation
//
//  Created by Max Egorov on 2/28/22.
//

import UIKit

final class ArticlesViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PhotosListViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.register(PhotosListViewCell.self, forCellReuseIdentifier: "ProfileHeadCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        return tableView
    }()
    
    private lazy var jsonDecoder: JSONDecoder = {
        return JSONDecoder()
    }()
    
    private var dataSource: [Articles.Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.fetchArticles { [weak self] articles in
            self?.dataSource = articles
            self?.tableView.reloadData()
        }
    }
    
    private func setupView() {
        self.view.addSubview(self.tableView)
        
        let topConstraint = self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leadingConstraint = self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingConstraint = self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomConstraint = self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        NSLayoutConstraint.activate([
            topConstraint, leadingConstraint, trailingConstraint, bottomConstraint
        ])
    }
    
    private func fetchArticles(completion: @escaping ([Articles.Article]) -> Void) {
        if let path = Bundle.main.path(forResource: "jsonFile", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonFile = try self.jsonDecoder.decode(Articles.self, from: data)
                print("json data: \(jsonFile)")
                completion(jsonFile.articles)
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            fatalError("Invalid filename/path.")
        }
    }
}

extension ArticlesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 21  // self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileHeadCell", for: indexPath) as! PhotosListViewCell
            
            return cell
        } else {

            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PhotosListViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            
            let article = self.dataSource[indexPath.row - 1]
            let viewModel = PhotosListViewCell.ViewModel(title: article.title, description: article.description, image: article.image, likes: article.likes, views: article.views)
            cell.setup(with: viewModel)
            
            return cell
        }
    }
}


