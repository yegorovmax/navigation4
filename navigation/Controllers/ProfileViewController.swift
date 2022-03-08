//
//  ProfileViewController.swift
//  navigation
//
//  Created by Max Egorov on 2/11/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero) 
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var heightConstraint: NSLayoutConstraint?
    
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

    override func viewDidLoad() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        super.viewDidLoad()
        setupNavigationBar()
        self.view.addSubview(self.profileHeaderView)
        setupView()
        setTitleStackView()
    }
    
    private func setupNavigationBar() {
           self.navigationItem.title = "Profile"
       }
    
    
    internal override func viewWillLayoutSubviews() {
        profileHeaderView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        profileHeaderView.frame = CGRect(origin: CGPoint.zero, size: view.frame.size)
    }
    
    private func setupView() {
        self.view.backgroundColor = .lightGray
        
        let viewTopConstraint = self.profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let viewLeadingConstraint = self.profileHeaderView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
        let viewTrailingConstraint = self.profileHeaderView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        self.heightConstraint = self.profileHeaderView.heightAnchor.constraint(equalToConstant: 220)
        NSLayoutConstraint.activate([
            viewTopConstraint, viewLeadingConstraint, viewTrailingConstraint, self.heightConstraint
        ].compactMap( {$0} ))
    }

    func setTitleStackView() {
        self.view.addSubview(self.titleStackView)
        self.titleStackView.addArrangedSubview(titleTextField)
        self.titleStackView.addArrangedSubview(titleButton)
        
        let titleStackViewCenterY = self.titleStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        let titleStackViewLeadingConstraint = self.titleStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
        let titleStackViewTrailingConstraint = self.titleStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)

        
        let titleTextFieldHeightAnchor = self.titleTextField.heightAnchor.constraint(equalToConstant: 40)
        let titleButtonHeightAnchor = self.titleButton.heightAnchor.constraint(equalToConstant: 50)
        NSLayoutConstraint.activate([titleStackViewCenterY, titleStackViewLeadingConstraint,
                                     titleStackViewTrailingConstraint, titleTextFieldHeightAnchor,
                                     titleButtonHeightAnchor
                                    ].compactMap( {$0} ))
    }
    
    @objc private func titleButtonAction() {
        self.navigationItem.title = titleTextField.text!
        titleTextField.text = nil
    }
}
extension ProfileViewController: ProfileHeaderViewProtocol {
    func buttonAction(inputTextIsVisible: Bool, completion: @escaping () -> Void) {
        self.heightConstraint?.constant = inputTextIsVisible ? 250 : 220

        UIView.animate(withDuration: 0.2, delay: 0.0) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
}
