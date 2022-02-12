//
//  PostViewController.swift
//  navigation
//
//  Created by Max Egorov on 2/11/22.
//

import UIKit

class PostViewController: UIViewController {
    var titlePost: String = "Anonymous"
    private lazy var button: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(clickButton))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.navigationItem.title = titlePost
        self.navigationItem.rightBarButtonItem = button
      
    }
    @objc private func clickButton() {
        let infoViewController = InfoViewController()
        infoViewController.modalPresentationStyle = .automatic
        present(infoViewController, animated: true, completion: nil)
    }
}
