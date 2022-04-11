//
//  ProfileViewController.swift
//  navigation
//
//  Created by Max Egorov on 2/11/22.
//
//private var dataSource: [Articles.Article] = []

import UIKit

final class ProfileViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotoCell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.register(ProfileTableHeaderView.self, forHeaderFooterViewReuseIdentifier: "TableHeder")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        return tableView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupTableView() {
        self.view.addSubview(self.tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableHeder") as! ProfileTableHeaderView
        view.delegate = self
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            
            return 250
        } else {
            
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            
            return 1
        } else {
            
            return newsArticles.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotosTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                
                return cell
            }
            cell.selectionStyle = .none
            cell.delegate = self
            cell.layer.shouldRasterize = true
            cell.layer.rasterizationScale = UIScreen.main.scale
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                
                return cell
            }
            cell.selectionStyle = .none
            cell.delegate = self
            let article = newsArticles[indexPath.row]
            let viewModel = PostTableViewCell.ViewModel(
                author: article.author,
                description: article.description,
                image: article.image,
                likes: article.likes,
                views: article.views)
            cell.setup(with: viewModel)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.section == 0 {

            return .none
        } else {

            return .delete
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.tableView.beginUpdates()
        newsArticles.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        self.tableView.endUpdates()
    }
}

extension ProfileViewController: ProfileTableHeaderViewProtocol {
    
    func buttonAction(inputTextIsVisible: Bool, completion: @escaping () -> Void) {
        self.tableView.beginUpdates()
      //  self.isExpanded = !inputTextIsVisible
        self.tableView.endUpdates()
        UIView.animate(withDuration: 0.2, delay: 0.0) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
    
    func buttonAction2() {
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    func delegateActionAnimatedAvatar(cell: ProfileTableHeaderView) {
        let animatedAvatarViewController = AnimatedAvatarViewController()
        self.view.addSubview(animatedAvatarViewController.view)
        self.addChild(animatedAvatarViewController)
        animatedAvatarViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            animatedAvatarViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animatedAvatarViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animatedAvatarViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            animatedAvatarViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        animatedAvatarViewController.didMove(toParent: self)
    }
}

extension ProfileViewController: PhotosTableViewCellProtocol {
    func delegateButtonAction(cell: PhotosTableViewCell) {
        let photosViewController = PhotosViewController()
        self.navigationController?.pushViewController(photosViewController, animated: true)
    }
}

extension ProfileViewController: PostTableViewCellProtocol {
    func tapPostImageViewGestureRecognizerDelegate(cell: PostTableViewCell) {
        
        let presentPostViewController = FullPostView()
        guard let index = self.tableView.indexPath(for: cell)?.row else { return }
        let indexPath = IndexPath(row: index, section: 1)
        newsArticles[indexPath.row].views += 1
        let article = newsArticles[indexPath.row]

        let viewModel = FullPostView.ViewModel(
            author: article.author,
            description: article.description,
            image: article.image,
            likes: article.likes,
            views: article.views)

        presentPostViewController.setup(with: viewModel)
        self.view.addSubview(presentPostViewController)

        presentPostViewController.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            presentPostViewController.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            presentPostViewController.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            presentPostViewController.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            presentPostViewController.topAnchor.constraint(equalTo: view.topAnchor)
        ])

        self.tableView.reloadRows(at: [indexPath], with: .fade)
    }

    func tapLikeTitleGestureRecognizerDelegate(cell: PostTableViewCell) {
        guard let index = self.tableView.indexPath(for: cell)?.row else { return }
        let indexPath = IndexPath(row: index, section: 1)
        newsArticles[index].likes += 1
        self.tableView.reloadRows(at: [indexPath], with: .fade)
    }
}
