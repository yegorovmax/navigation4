//
//  FeedViewController.swift
//  navigation
//
//  Created by Max Egorov on 2/11/22.
//

import UIKit

class FeedViewController: UIViewController {
    var post = Post(title: "Мой пост")
    
//    private lazy var button: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = .blue
//        button.layer.cornerRadius = 12
//        button.setTitle("Перейти на пост", for: .normal)
//        button.setTitleColor(.lightGray, for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
//        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10

        return stackView
    }()
    
    private lazy var button1: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.layer.cornerRadius = 12
        button.setTitle("Перейти на пост", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var button2: UIButton = {
        let button = UIButton()
        button.backgroundColor = .yellow
        button.layer.cornerRadius = 12
        button.setTitle("Перейти на пост", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.backButtonTitle = "Back"
        self.navigationItem.title = "Home"
        setButtonStackView()
    }
        
    func setButtonStackView() {
        self.view.addSubview(self.buttonStackView)
        self.buttonStackView.addArrangedSubview(button1)
        self.buttonStackView.addArrangedSubview(button2)
        
        let buttonStackViewCenterY = self.buttonStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        let buttonStackViewLeadingConstraint = self.buttonStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
        let buttonStackViewTrailingConstraint = self.buttonStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        
        let firstButtonHeightAnchor = self.button1.heightAnchor.constraint(equalToConstant: 50)
        let secondButtonHeightAnchor = self.button2.heightAnchor.constraint(equalToConstant: 50)
        NSLayoutConstraint.activate([buttonStackViewCenterY, buttonStackViewLeadingConstraint,
                                     buttonStackViewTrailingConstraint, firstButtonHeightAnchor,
                                     secondButtonHeightAnchor
                                    ].compactMap( {$0} ))
    }
    
    @objc private func buttonAction() {
        let postViewController = PostViewController()
        postViewController.titlePost = post.title
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
}
