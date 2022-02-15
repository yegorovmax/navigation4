//
//  InfoViewController.swift
//  navigation
//
//  Created by Max Egorov on 2/11/22.
//

import UIKit

class InfoViewController: UIViewController {
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.layer.cornerRadius = 12
        button.setTitle("Показать алерт", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .opaqueSeparator
        self.view.addSubview(self.button)
    
        self.button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true 
        self.button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc private func buttonAction() {
        self.showAlert()
    }
    private func showAlert() {
        let alertController = UIAlertController(title: "ВНИМАНИЕ", message: "Ты хочешь узнать правду?", preferredStyle: .alert)
        let yesButton = UIAlertAction(title: "Да", style: .default) { Action in
            print("Нажата кнопка Да")
        }
        let noButton = UIAlertAction(title: "Нет", style: .cancel) { Action in
            print("Нажата кнопка Нет")
        }
        alertController.addAction(yesButton)
        alertController.addAction(noButton)
        present(alertController, animated: true, completion: nil)
    }
}
