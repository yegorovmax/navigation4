//
//  ProfileHeaderView.swift
//  navigation
//
//  Created by Max Egorov on 2/16/22.
//

import UIKit

protocol ProfileHeaderViewProtocol: AnyObject {
    func buttonAction(inputTextIsVisible: Bool, completion: @escaping () -> Void)
    func delegateAction(cell: ProfileHeaderView)
}

class ProfileHeaderView: UIView, UITextFieldDelegate, UIGestureRecognizerDelegate {
    var profileHeaderView : UIViewController?
    var statusText: String? = nil
  
     lazy var avatarImageView: UIImageView = {
         let img = UIImage(named: "picon.jpg") as UIImage?
         let imageView = UIImageView(image: img)
         let button = UIButton(type: UIButton.ButtonType.custom)
         button.setImage(img, for: .normal)
         
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 70.0
        imageView.clipsToBounds = true
         //imageView.addTarget(self, action: #selector(self.didTapAvatar), for: .touchUpInside)
         
         
         button.layer.cornerRadius = 10
         button.setTitle("Log in", for: .normal)
         let image = UIImage(named: "Color_Set")
         button.setBackgroundImage(image, for: .normal)
         if button.isSelected {
             button.alpha = 0.8
         } else if button.isHighlighted {
             button.alpha = 0.8
         } else {
             button.alpha = 1.0
         }
         button.setTitleColor(.white, for: .normal)
         button.addTarget(self, action: #selector(self.didTapAvatar), for: .touchUpInside)
         button.translatesAutoresizingMaskIntoConstraints = false
         button.clipsToBounds = true

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
        label.text  = "UserName"
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
        button.layer.shadowPath =  UIBezierPath(rect: button.bounds).cgPath
        
        return button
    }()
    
    private var buttonTopConstrain: NSLayoutConstraint?
    private var tapGestureRecognizer = UITapGestureRecognizer()
    
    weak var delegate: ProfileHeaderViewProtocol?
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) yas not been")
    }
  
    func createSubviews() {
        self.addSubview(firstStackView)
        self.addSubview(statusTextField)
        self.addSubview(setStatusButton)
        self.firstStackView.addArrangedSubview(avatarImageView)
        self.firstStackView.addArrangedSubview(labelStackView)
        self.labelStackView.addArrangedSubview(fullNameLabel)
        self.labelStackView.addArrangedSubview(statusLabel)
        self.statusTextField.delegate = self
        setupConstraints()
        self.setupTapGesture()
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
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
            NSLayoutConstraint.activate([topConstrain, leadingConstrain, trailingConstrain, textHeight, buttonTopConstrain].compactMap( {$0} ))
            
            statusTextField.becomeFirstResponder()
            
        } else {
            statusText = statusTextField.text!
            statusLabel.text = "\(statusText ?? "")"
            setStatusButton.setTitle("Show status", for: .normal)
            
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
    private func setupTapGesture() {
        self.tapGestureRecognizer.addTarget(self, action: #selector(self.handleTapGesture(_:)))
        self.avatarImageView.addGestureRecognizer(self.tapGestureRecognizer)
        self.avatarImageView.isUserInteractionEnabled = true
    }
    @objc func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        guard self.tapGestureRecognizer === gestureRecognizer else { return }
        
        delegate?.delegateAction(cell: self)
    }
    @objc private func didTapAvatar(){
        let gestureViewController = GestureViewController()
        profileHeaderView?.navigationController?.pushViewController(gestureViewController, animated: true)
    }
}

