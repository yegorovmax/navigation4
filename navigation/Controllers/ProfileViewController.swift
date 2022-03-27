//
//  ProfileViewController.swift
//  navigation
//
//  Created by Max Egorov on 2/11/22.
//

import UIKit

protocol ProfileHeaderViewProtocol: AnyObject {
    func buttonAction(inputTextIsVisible: Bool, completion: @escaping () -> Void)
}



class ProfileViewController: UIViewController {
    
    
    struct ViewModel: ViewModelProtocol {
        var button: String
        var textfield: String
    }
    
    private var dataSource: [News.Article] = []
    
    private lazy var jsonDecoder: JSONDecoder = {
        return JSONDecoder()
    }()

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

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.register(ProfileTableHederView.self, forHeaderFooterViewReuseIdentifier: "TableHeder")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        return tableView
    }()

    
    private var isExpanded: Bool = true
    private var height = 236
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        tapGesturt()
    }
    
    func tapGesturt() {
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing))
        self.view.addGestureRecognizer(tapGesture)
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
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableHeder") as! ProfileTableHederView
        view.delegate = self
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        isExpanded ? 236 : 266 // I-й способ
        // CGFloat(height) // II-й способ
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            
            return cell
        }
        
        let article = self.dataSource[indexPath.row]
//        let viewModel = PostTableViewCell.ViewModel(
//        //
//            )
        return cell
    }
}

// MARK: EXTENSIONS
extension ProfileViewController: ProfileHeaderViewProtocol {
    
    func buttonAction(inputTextIsVisible: Bool, completion: @escaping () -> Void) {
        self.tableView.beginUpdates()
        self.isExpanded = !inputTextIsVisible // I-й способ
        // self.height = inputTextIsVisible ? 266 : 236 // II-й способ
        self.tableView.endUpdates()
        UIView.animate(withDuration: 0.2, delay: 0.0) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
}
