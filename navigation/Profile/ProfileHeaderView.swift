//
//  ProfileHeaderView.swift
//  navigation
//
//  Created by Max Egorov on 2/16/22.
//

import UIKit

protocol ProfileHeaderViewProtocol: AnyObject {
    func buttonAction(inputTextIsVisible: Bool, completion: @escaping () -> Void)
}

class ProfileHeaderView: UIView, UITextFieldDelegate {

    var statusText: String? = nil
  
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "picon.jpg"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 69.0
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
   
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.isHidden = true
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
  
//    button.setTitleColor(.white, for: .normal)
//    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
//    button.addTarget(self, action: #selector(titleButtonAction), for: .touchUpInside)
//    button.translatesAutoresizingMaskIntoConstraints = false
 
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(buttonAction),
                               for: .touchUpInside)
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowRadius = 4.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shouldRasterize = true
        
        return button
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var statusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Show status", for: .normal)
        button.tintColor = .white
        
        button.layer.cornerRadius = 16
        button.layer.shadowOffset.width = 4
        button.layer.shadowOffset.height = 4
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        
        button.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
  /*  private lazy var userStatus: UITextField = {
        let textField = UITextField()
        textField.isHidden = false
        textField.text = "Waiting for something..."
        textField.tintColor = .darkGray
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()*/
    private lazy var userPhoto: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "picon.jpg"))
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var buttonTopConstrain: NSLayoutConstraint?
    weak var delegate: ProfileHeaderViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.createSubviews()
        draw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("required init error")
    }
  
    private func draw() {
        self.addSubview(self.infoStackView)
        self.addSubview(self.statusButton)
        self.addSubview(self.statusTextField)
        self.infoStackView.addArrangedSubview(self.userPhoto)
        self.infoStackView.addArrangedSubview(self.labelsStackView)
        self.labelsStackView.addArrangedSubview(self.fullNameLabel)
        self.labelsStackView.addArrangedSubview(self.statusTextField)
        
        let topConstraint = self.infoStackView.topAnchor.constraint(equalTo: self.topAnchor)
        let leadingConstraint = self.infoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let trailingConstraint = self.infoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)

        let userPhotoAspectRatio = self.userPhoto.heightAnchor.constraint(equalTo: self.userPhoto.widthAnchor, multiplier: 1.0)
       
        self.buttonTopConstrain = self.statusButton.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 16)
        self.buttonTopConstrain?.priority = UILayoutPriority(rawValue: 999)
        let leadingButtonConstrain = self.statusButton.leadingAnchor.constraint(equalTo: self.infoStackView.leadingAnchor)
        let trailingButtonConstrain = self.statusButton.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor)
        let bottomButtonConstrain = self.statusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        let heightButtonConstrain = self.statusButton.heightAnchor.constraint(equalToConstant: 50)
        
        NSLayoutConstraint.activate([
            topConstraint, leadingConstraint, trailingConstraint,
            userPhotoAspectRatio,
            self.buttonTopConstrain, leadingButtonConstrain,
            trailingButtonConstrain, bottomButtonConstrain, heightButtonConstrain
        ].compactMap({ $0 }))
    }
    
    
  /*
    func createSubviews() {
        self.addSubview(firstStackView)
        self.addSubview(statusTextField)
        self.addSubview(setStatusButton)
        self.firstStackView.addArrangedSubview(avatarImageView)
        self.firstStackView.addArrangedSubview(labelStackView)
        self.labelStackView.addArrangedSubview(fullNameLabel)
        self.labelStackView.addArrangedSubview(statusLabel)

        setupConstraints()
        self.statusTextField.delegate = self
    }
  
    func setupConstraints() {
        let firstStackViewTopConstraint = self.firstStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        let firstStackViewLeadingConstraint = self.firstStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let firstStackViewTrailingConstraint = self.firstStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
       
        let avatarImageViewRatioConstraint = self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor, multiplier: 1.0)

        self.buttonTopConstrain = self.setStatusButton.topAnchor.constraint(equalTo: self.firstStackView.bottomAnchor, constant: 16)
        self.buttonTopConstrain?.priority = UILayoutPriority(rawValue: 999)
        let buttonLeadingConstraint = self.setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let buttonTrailingConstraint = self.setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let buttonHeightConstraint = self.setStatusButton.heightAnchor.constraint(equalToConstant: 50)
        let buttonBottomConstraint = self.setStatusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        
        NSLayoutConstraint.activate([
            firstStackViewTopConstraint, firstStackViewLeadingConstraint,
            firstStackViewTrailingConstraint, avatarImageViewRatioConstraint,
            self.buttonTopConstrain, buttonLeadingConstraint, buttonTrailingConstraint,
            buttonHeightConstraint, buttonBottomConstraint
        ].compactMap( {$0} ))
    }
    */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
    @objc private func didTapStatusButton() {
        let userText = statusTextField.text
        if userText != nil {
            print(userText!)
        }
    }
    @objc private func buttonAction() {
        let topConstrain = self.statusTextField.topAnchor.constraint(equalTo: self.firstStackView.bottomAnchor, constant: -10)
        let leadingConstrain = self.statusTextField.leadingAnchor.constraint(equalTo: self.labelStackView.leadingAnchor)
        let trailingConstrain = self.statusTextField.trailingAnchor.constraint(equalTo: self.firstStackView.trailingAnchor)
        let textHeight = self.statusTextField.heightAnchor.constraint(equalToConstant: 40)

        self.buttonTopConstrain = self.setStatusButton.topAnchor.constraint(equalTo: self.statusTextField.bottomAnchor, constant: 16)
        
        if self.statusTextField.isHidden {
            self.addSubview(self.statusTextField)
            statusTextField.text = statusText
            self.buttonTopConstrain?.isActive = false
            NSLayoutConstraint.activate([topConstrain, leadingConstrain, trailingConstrain, textHeight, buttonTopConstrain].compactMap( {$0} ))
            
        } else {
            statusText = statusTextField.text!
            statusLabel.text = "\(statusText ?? "")"
            
            self.statusTextField.removeFromSuperview()
            NSLayoutConstraint.deactivate([topConstrain, leadingConstrain, trailingConstrain, textHeight].compactMap( {$0} ))
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
