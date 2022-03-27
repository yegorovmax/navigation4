//
//  PostTableViewCell.swift
//  navigation
//
//  Created by Max Egorov on 3/26/22.
//

import UIKit
class PostTableViewCell: UITableViewCell {
    struct ViewModel: ViewModelProtocol {
        var button: String
        var textfield: String       
    }
    
    
    private func setupNavigationBar() {
               //self.navigationItem.title = "Profile"
           }
    
    private lazy var titleStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.distribution = .fill
            stackView.spacing = 10

            return stackView
        }()
        
        private lazy var titleTextField: UITextField = {
            let textField = UITextField()
           // textField.isHidden = true
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.backgroundColor = .white
            textField.textColor = .black
            textField.font = UIFont.systemFont(ofSize: 15.0)
            textField.layer.borderWidth = 1.0
            textField.layer.borderColor = UIColor.black.cgColor
            textField.layer.cornerRadius = 12.0
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 2.0))
            textField.leftView = leftView
            textField.leftViewMode = .always
            textField.clipsToBounds = true
            textField.placeholder = "Enter Titile"
            textField.clearButtonMode = .whileEditing

            return textField
        }()
        
        private lazy var titleButton: UIButton = {
            let button = UIButton()
            button.backgroundColor = .blue
            button.layer.cornerRadius = 4
            button.setTitle("Change title", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
            button.addTarget(self, action: #selector(titleButtonAction), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
            button.layer.shadowRadius = 4.0
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOpacity = 0.7
            button.layer.shouldRasterize = true
         
            return button
        }()

    
    
    
    private func setupView() {
//        self.contentView.addSubview(self.authorLabel)
//        self.contentView.addSubview(self.postImageView)
//        self.contentView.addSubview(self.descriptionLabel)
//        self.contentView.addSubview(self.likeStackView)
//        self.likeStackView.addArrangedSubview(self.likeTitle)
//        self.likeStackView.addArrangedSubview(self.viewTitle)
//        setupConstraints()
    }
    
    
    @objc private func titleButtonAction() {
           // self.navigationItem.title = titleTextField.text!
            titleTextField.text = nil
        }
}
