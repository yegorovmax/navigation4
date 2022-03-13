//
//  ProfileViewController.swift
//  navigation
//
//  Created by Max Egorov on 2/11/22.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private var dataSource: [Articles.Article] = []
    
    private lazy var jsonDecoder: JSONDecoder = {
        return JSONDecoder()
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotoCell")
        tableView.register(PhotosListViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        return tableView
    }()
    
    private lazy var tableHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var heightConstraint: NSLayoutConstraint?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        tapGesturt()
       
        self.fetchArticles { [weak self] articles in
            self?.dataSource = articles
            self?.tableView.reloadData()
        }
      
        self.tableView.tableHeaderView = tableHeaderView
        setupProfileHeadView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateHeaderViewHeight(for: tableView.tableHeaderView)
    }
    
    private func setupTableView() {
        self.view.addSubview(self.tableView)
        
        let topConstraint = self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leadingConstraint = self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingConstraint = self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomConstraint = self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        NSLayoutConstraint.activate([
            topConstraint, leadingConstraint, trailingConstraint, bottomConstraint
        ])
    }
    
    private func setupProfileHeadView() {
        self.view.backgroundColor = .lightGray
        
        let topConstraint = self.tableHeaderView.topAnchor.constraint(equalTo: tableView.topAnchor)
        let leadingConstraint = self.tableHeaderView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor)
        let trailingConstraint = self.tableHeaderView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor)
        let widthConstraint = self.tableHeaderView.widthAnchor.constraint(equalTo: tableView.widthAnchor)
        self.heightConstraint = self.tableHeaderView.heightAnchor.constraint(equalToConstant: 220)
        let bottomConstraint = self.tableHeaderView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        
        NSLayoutConstraint.activate([
            topConstraint, leadingConstraint, trailingConstraint, bottomConstraint,
            heightConstraint, widthConstraint
        ].compactMap( {$0} ))
    }
    
    // MARK: Data coder
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
    func tapGesturt() {
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func updateHeaderViewHeight(for header: UIView?) {
        guard let header = header else { return }
        header.frame.size.height = header.systemLayoutSizeFitting(CGSize(width: view.bounds.width, height: CGFloat(heightConstraint!.constant))).height
    }
}

// MARK: - UITableView Data Source
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.dataSource.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotosTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                
                return cell
            }
            cell.delegate = self
            cell.layer.shouldRasterize = true
            cell.layer.rasterizationScale = UIScreen.main.scale
        
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PhotosListViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                
                return cell
            }
            let article = self.dataSource[indexPath.row]
            let viewModel = PhotosListViewCell.ViewModel(author: article.title, description: article.description, image: article.image, likes: article.likes, views: article.views)
            cell.setup(with: viewModel)
            
            return cell
        }
    }
}

extension ProfileViewController: ProfileHeaderViewProtocol {
    func delegateAction(cell: ProfileHeaderView) {
    }
    
    
    func buttonAction(inputTextIsVisible: Bool, completion: @escaping () -> Void) {
        self.heightConstraint?.constant = inputTextIsVisible ? 250 : 220

        self.tableView.beginUpdates()
        self.tableView.reloadSections(IndexSet(0..<1), with: .automatic)
        self.tableView.endUpdates()
        
        UIView.animate(withDuration: 0.2, delay: 0.0) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
}

extension ProfileViewController: PhotosTableViewCellProtocol {
    
    func delegateButtonAction(cell: PhotosTableViewCell) {
        let photosViewController = PhotosViewController()
        self.navigationController?.pushViewController(photosViewController, animated: true)
    }
}
