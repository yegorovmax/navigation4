//
//  ProfileViewController.swift
//  navigation
//
//  Created by Max Egorov on 2/11/22.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 130
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //private var heightConstraint: NSLayoutConstraint?
    
/*    private lazy var titleStackView: UIStackView = {
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
*/
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.setupView()
        navigationItem.title = "Profile"
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setupNavigationBar() {
           self.navigationItem.title = "Profile"
       }
    
    private func setupView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.profileHeaderView)
        
        let topConstraint = self.profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let leadingConstraint = self.profileHeaderView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
        let trailingConstraint = self.profileHeaderView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        let heightConstraint = self.profileHeaderView.heightAnchor.constraint(equalToConstant: 170)
        
        let tableViewTop = self.tableView.topAnchor.constraint(equalTo: self.profileHeaderView.bottomAnchor, constant: 20)
        let tableViewLeft = self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
        let tableViewRight = self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        let tableViewHeight = self.tableView.heightAnchor.constraint(equalToConstant: 130)
        
        NSLayoutConstraint.activate([
            topConstraint, leadingConstraint, trailingConstraint, heightConstraint, tableViewTop, tableViewLeft, tableViewRight, tableViewHeight
        ])
    }
    
}

/*    func setTitleStackView() {
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
extension ProfileViewController: ProfileHeaderViewProtocol{
    func buttonAction(inputTextIsVisible: Bool, completion: @escaping () -> Void) {
        self.heightConstraint?.constant = inputTextIsVisible ? 250 : 220

        UIView.animate(withDuration: 0.2, delay: 0.0) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    } */


extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as! PhotosTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photosViewController = PhotosViewController()
        navigationController?.pushViewController(photosViewController, animated: true)
    }
}
