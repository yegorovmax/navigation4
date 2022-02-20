//
//  ProfileHeaderView.swift
//  navigation
//
//  Created by Max Egorov on 2/16/22.
//

import UIKit

protocol ProfileHeaderViewProtocol: AnyObject {
    func didTapStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> Void)
}

final class ProfileHeaderView: UIView {
    var statusText: String? = nil

    private lazy var avatarImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "picon.jpg"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 61.0
        imageView.clipsToBounds = true
        
        return imageView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        
        return stackView
    }()
   
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text  = "USER NAME"
        nameLabel.textColor = .black
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        
        return nameLabel
    }()
  
    private lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.text = nil
        statusLabel.textColor = .gray
        statusLabel.font = UIFont.systemFont(ofSize: 14.0)
        
        return statusLabel
    }()
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // textField
    private lazy var textField: UITextField = {
        let textField = UITextField()
        //textField.isHidden = true
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
        textField.placeholder = "Add Startus"
        textField.addTarget(self, action: #selector(ProfileHeaderView.statusTextChanged(_:)), for: .editingChanged)
        return textField
    }()

    //button
    private lazy var statusButton: UIButton = {
        let statusButton = UIButton()
        statusButton.setTitle("Show status", for: .normal)
        statusButton.setTitleColor(.white, for: .normal)
        statusButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        statusButton.backgroundColor = .blue
        statusButton.layer.cornerRadius = 4
        //statusButton.addTarget(self, action: #selector(self.didTapStatusButton), for: .touchUpInside)
        statusButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        statusButton.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        statusButton.layer.shadowRadius = 4.0
        statusButton.layer.shadowColor = UIColor.black.cgColor
        statusButton.layer.shadowOpacity = 0.7
        statusButton.layer.shouldRasterize = true
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        return statusButton
    }()
    
    private var buttonTopConstraint: NSLayoutConstraint?
    weak var delegate: ProfileHeaderViewProtocol?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
        setupConstraints()
    }
    // восстанавливаем интерфейс
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubviews()
        setupConstraints()
    }
   
    func createSubviews() {
        addSubview(avatarImage)
        addSubview(textField)
        addSubview(statusButton)
        addSubview(stackView)
        //addSubview(infoStackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(statusLabel)
    }
    // Устанавливаем констрейны
    func setupConstraints() {
        // image
        self.avatarImage.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 51).isActive = true // 35+16=51
        self.avatarImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        self.avatarImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
        self.avatarImage.widthAnchor.constraint(equalToConstant: 120).isActive = true
        // stackView
        self.stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 62).isActive = true // 35+27=62
        self.stackView.leadingAnchor.constraint(equalTo: self.avatarImage.trailingAnchor, constant: 20).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        self.stackView.heightAnchor.constraint(equalToConstant: 80).isActive = true
       
        // textField
        self.textField.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 8).isActive = true
        self.textField.leadingAnchor.constraint(equalTo: self.avatarImage.trailingAnchor, constant: 16).isActive = true
        self.textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        self.textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // button
        self.statusButton.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 34).isActive = true
        self.statusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        self.statusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        self.statusButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    // add text
    @objc private func buttonAction() {
        statusText = textField.text!
        statusLabel.text = "\(statusText ?? "")"
    }

    @objc func statusTextChanged(_ textField: UITextField) {
        let status: String = textField.text ?? ""
        print("Новый статус = \(status)")
    }
    
    @objc private func didTapStatusButton() {
        if self.textField.isHidden {
            self.addSubview(self.textField)
            
   //         self.buttonTopConstraint?.isActive = false // Если констрейнт будет жестким, необходимо деактивировать его, иначе будет конфликт констрейнтов, и Auto Layout не сможет однозначно определить фреймы textField'а.
            
            let topConstraint = self.textField.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 10)
            let leadingConstraint = self.textField.leadingAnchor.constraint(equalTo: self.infoStackView.leadingAnchor)
            let trailingConstraint = self.textField.trailingAnchor.constraint(equalTo: self.textField.trailingAnchor)
            let heightTextFieldConstraint = self.textField.heightAnchor.constraint(equalToConstant: 34) // Не указав высоту textField'а, получается неоднозначность/неопределенность констрейнтов. Auto Layout на основе этой неопределенности имеет множество решений (height для stackView, textField), выбирая оптимальное, а не необходимое, то есть вместо 34pts для textField'а растягивается stackView.
            self.buttonTopConstraint = self.statusButton.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 20)
            
            NSLayoutConstraint.activate([
                topConstraint, leadingConstraint, trailingConstraint, heightTextFieldConstraint, self.buttonTopConstraint
            ].compactMap({ $0 }))
        } else {
            #warning("Убрать textField из вью!")
        }
        
        self.delegate?.didTapStatusButton(textFieldIsVisible: self.textField.isHidden) { [weak self] in
            self?.textField.isHidden.toggle()
        }
    }
}
