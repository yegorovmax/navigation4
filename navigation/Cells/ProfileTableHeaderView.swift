//
//  ProfileTableHeaderView.swift
//  navigation
//
//  Created by Max Egorov on 3/31/22.
//

import UIKit

protocol ProfileTableHeaderViewProtocol: AnyObject {
    func buttonAction(inputTextIsVisible: Bool, completion: @escaping () -> Void)
    func buttonAction2()

    func delegateActionAnimatedAvatar(cell: ProfileTableHeaderView)
}

class ProfileTableHeaderView: UITableViewHeaderFooterView {
    private let defaults = UserDefaults.standard
    private var buttonTopConstraint: NSLayoutConstraint?
    private var tapRemoveKeyBoard = UITapGestureRecognizer()
    var statusText: String?
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        
        return stackView
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "picon.jpg"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 70.0
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 40
        
        return stackView
    }()
    
    private lazy var titleStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.distribution = .fill
            stackView.spacing = 10

            return stackView
        }()
    
    private lazy var firstStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        
        return stackView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.text  = "USER"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14.0)
        
        return label
    }()
    
    private func draw() {
        self.addSubview(self.setStatusButton)
        self.addSubview(labelsStackView)
        self.addSubview(avatarImageView)
        
        self.labelsStackView.addArrangedSubview(self.fullNameLabel)
        self.labelsStackView.addArrangedSubview(self.statusTextField)
        
        let userPhotoTop = avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        let userPhotoLeft = avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let userPhotoWidth = avatarImageView.widthAnchor.constraint(equalToConstant: 120)
        let userPhotoHeight = avatarImageView.heightAnchor.constraint(equalToConstant: 120)
        
        let labelsStackViewTop = labelsStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 27)
        let labelsStackViewLeft = labelsStackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16)

        self.buttonTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor, constant: 16)
        self.buttonTopConstraint?.priority = UILayoutPriority(rawValue: 999)
        let leadingButtonConstraint = self.setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let trailingButtonConstraint = self.setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let heightButtonConstraint = self.setStatusButton.heightAnchor.constraint(equalToConstant: 50)
        
        NSLayoutConstraint.activate([
            userPhotoTop, userPhotoLeft, userPhotoWidth, userPhotoHeight,
            labelsStackViewTop, labelsStackViewLeft,
            self.buttonTopConstraint, leadingButtonConstraint, trailingButtonConstraint, heightButtonConstraint
        ].compactMap({ $0 }))
    }
    
    private lazy var statusTextField: UITextField = { 
        let textField = UITextField()
        textField.isHidden = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 15.0)
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 12.0
        textField.placeholder = "Enter Status"
        textField.clearButtonMode = .whileEditing
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 2.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.clipsToBounds = true
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var statusTextField2: UITextField = {
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
        textField.placeholder = "Enter Status"
        textField.clearButtonMode = .whileEditing
        
        return textField
        }()
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Update status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.layer.cornerRadius = 4
        //button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonAction2),
                         for: .touchUpInside)
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowRadius = 4.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shouldRasterize = true
        button.layer.shadowPath =  UIBezierPath(rect: button.bounds).cgPath
        
        return button
    }()
    
    private var buttonTopConstrain: NSLayoutConstraint?
    
    weak var delegate: ProfileTableHeaderViewProtocol?
    
    private var tapGestureRecognizer = UITapGestureRecognizer()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
       // self.draw()
        self.createSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubviews() {
//        self.addSubview(firstStackView)
//        self.addSubview(statusTextField)
//        self.addSubview(setStatusButton)
//        self.firstStackView.addArrangedSubview(avatarImageView)
//        self.firstStackView.addArrangedSubview(labelStackView)
//        self.labelStackView.addArrangedSubview(fullNameLabel)
//        self.labelStackView.addArrangedSubview(statusLabel)
//        self.setupConstraints()
//        self.setupTapGesture()
      //  buttonAction()
        
        
        self.addSubview(self.mainStackView)
        self.mainStackView.addArrangedSubview(self.avatarImageView)
        self.mainStackView.addArrangedSubview(self.labelStackView)
        self.labelStackView.addArrangedSubview(self.fullNameLabel)
        self.labelStackView.addArrangedSubview(self.statusLabel)
        self.addSubview(self.statusTextField)
        self.addSubview(self.setStatusButton)
        self.setupConstraints2()
        self.setupTapGesture()
    }
    
    func setupConstraints2() {
        NSLayoutConstraint.activate([
            self.mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            self.avatarImageView.widthAnchor.constraint(equalToConstant: 138),
            self.avatarImageView.heightAnchor.constraint(equalToConstant: 138),
            
            self.statusTextField.topAnchor.constraint(equalTo: self.mainStackView.bottomAnchor, constant: -10),
            self.statusTextField.leadingAnchor.constraint(equalTo: self.labelStackView.leadingAnchor),
            self.statusTextField.trailingAnchor.constraint(equalTo: self.labelStackView.trailingAnchor),
            self.statusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            self.setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            self.setStatusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            self.setStatusButton.topAnchor.constraint(equalTo: self.statusTextField.bottomAnchor, constant: 16)
        ])
    }
    
    
    func setupConstraints() {
        let firstStackViewTopConstraint = self.firstStackView.topAnchor.constraint(equalTo: self.topAnchor)
        let firstStackViewLeadingConstraint = self.firstStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let firstStackViewTrailingConstraint = self.firstStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let avatarImageViewRatioConstraint = self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor, multiplier: 1.0)
        self.buttonTopConstrain = self.setStatusButton.topAnchor.constraint(equalTo: self.firstStackView.bottomAnchor, constant: 16)
        self.buttonTopConstrain?.priority = UILayoutPriority(rawValue: 999)
        let buttonLeadingConstraint = self.setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let buttonTrailingConstraint = self.setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let buttonHeightConstraint = self.setStatusButton.heightAnchor.constraint(equalToConstant: 50)
        let buttonBottomConstraint = self.setStatusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        
        NSLayoutConstraint.activate([
            firstStackViewTopConstraint, firstStackViewLeadingConstraint,
            firstStackViewTrailingConstraint, avatarImageViewRatioConstraint,
            self.buttonTopConstrain, buttonLeadingConstraint, buttonTrailingConstraint,
            buttonHeightConstraint, buttonBottomConstraint
        ].compactMap( {$0} ))
    }
    
    @objc func buttonAction2() {
        guard statusTextField.text != "" else {
            statusTextField.shake()
            return
        }
        statusText = self.statusTextField.text!
        statusLabel.text = "\(statusText ?? "")"
        self.statusTextField.text = nil
        self.endEditing(true)
    }
    
    @objc func buttonAction() {
        let topConstrain = self.statusTextField.topAnchor.constraint(equalTo: self.firstStackView.bottomAnchor, constant: -10)
        let leadingConstrain = self.statusTextField.leadingAnchor.constraint(equalTo: self.labelStackView.leadingAnchor)
        let trailingConstrain = self.statusTextField.trailingAnchor.constraint(equalTo: self.firstStackView.trailingAnchor)
        let textHeight = self.statusTextField.heightAnchor.constraint(equalToConstant: 40)
        self.buttonTopConstrain = self.setStatusButton.topAnchor.constraint(equalTo: self.statusTextField.bottomAnchor, constant: 16)
        
        if self.statusTextField.isHidden {
            self.addSubview(self.statusTextField)
            statusTextField.text = nil
            setStatusButton.setTitle("Set status", for: .normal)
            self.buttonTopConstrain?.isActive = false
            NSLayoutConstraint.activate(
                [topConstrain, leadingConstrain, trailingConstrain,
                 textHeight, buttonTopConstrain]
                    .compactMap( {$0} ))
            statusTextField.becomeFirstResponder()
        } else {
            guard statusTextField.text != "" else {
                statusTextField.shake()
                return
            }
            statusText = statusTextField.text!
            statusLabel.text = "\(statusText ?? "")"
            setStatusButton.setTitle("Update status", for: .normal)
            self.statusTextField.removeFromSuperview()
            NSLayoutConstraint.deactivate([
                topConstrain, leadingConstrain, trailingConstrain, textHeight
            ].compactMap( {$0} ))
        }
        self.delegate?.buttonAction(inputTextIsVisible: self.statusTextField.isHidden) { [weak self] in
            self?.statusTextField.isHidden.toggle()
        }
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        let status: String = textField.text ?? ""
        print("Новый статус = \(status)")
    }
}

extension ProfileTableHeaderView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
}

extension ProfileTableHeaderView: UIGestureRecognizerDelegate {
    private func setupTapGesture() {
        self.tapGestureRecognizer.addTarget(self, action: #selector(self.handleTapGesture(_:)))
        self.avatarImageView.addGestureRecognizer(self.tapGestureRecognizer)
        self.avatarImageView.isUserInteractionEnabled = true
    }
    
    @objc func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        guard self.tapGestureRecognizer === gestureRecognizer else { return }
        delegate?.delegateActionAnimatedAvatar(cell: self)
    }
}
