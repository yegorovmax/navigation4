//
//  LogInViewController.swift
//  navigation
//
//  Created by Max Egorov on 2/25/22.
//

//textField.placeholder = "E-mail of phone"
//textField.clearButtonMode = .whileEditing

import UIKit

class LogInViewController: UIViewController {
    
    let user = User(login: "a@a.aa", password: "aa")
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var logoView: UIImageView = {
        let logoView = UIImageView(image: UIImage(named: "logo.jpg"))
        logoView.translatesAutoresizingMaskIntoConstraints = false
        
        return logoView
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16.0)
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(20, 0, 0)
        textField.placeholder = "E-mail of phone"
        textField.clearButtonMode = .whileEditing
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16.0)
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(20, 0, 0)
        textField.placeholder = "Password"
        textField.clearButtonMode = .whileEditing
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        return textField
    }()
    
    private lazy var initButton: UIButton = {
        let button = UIButton()
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
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        tapGesturt()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.logoView)
        self.scrollView.addSubview(loginTextField)
        self.scrollView.addSubview(passwordTextField)
        self.scrollView.addSubview(initButton)
        self.view.addSubview(errorLabel)
    }
    
    func setupConstraints() {
        let scrollViewTopConstraint = self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let scrollViewRightConstraint = self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16)
        let scrollViewBottomConstraint = self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        let scrollViewLeftConstraint = self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16)
        
        let logoViewCenterX = self.logoView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        let logoViewTopConstraint = self.logoView.topAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: -193)
        let logoViewHeightAnchor = self.logoView.heightAnchor.constraint(equalToConstant: 100)
        let logoViewWidthAnchor = self.logoView.widthAnchor.constraint(equalToConstant: 100)
        
        let loginTextFieldTopConstraint = self.loginTextField.bottomAnchor.constraint(equalTo: self.logoView.bottomAnchor, constant: 120)
        let loginTextFieldWidthAnchor = self.loginTextField.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        let loginTextFieldHeightAnchor = self.loginTextField.heightAnchor.constraint(equalToConstant: 50)
        
        let passwordTextFieldTopConstraint = self.passwordTextField.topAnchor.constraint(equalTo: self.loginTextField.bottomAnchor, constant: -1)
        let passwordTextFieldWidthAnchor = self.passwordTextField.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        let passwordTextFieldHeightAnchor = self.passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        
        let initButtonTopConstraint = self.initButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 16)
        let initButtonWidthAnchor = self.initButton.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        let initButtonHeightAnchor = self.initButton.heightAnchor.constraint(equalToConstant: 50)
        let errorLabelTopConstraint = self.errorLabel.topAnchor.constraint(equalTo: self.initButton.bottomAnchor, constant: 16)
        let errorLabelRightConstraint = self.errorLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16)
        let errorLabelLeftConstraint = self.errorLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16)
        
        NSLayoutConstraint.activate([
            scrollViewTopConstraint, scrollViewRightConstraint,
            scrollViewBottomConstraint,scrollViewLeftConstraint,
            logoViewCenterX, logoViewTopConstraint,
            logoViewWidthAnchor, logoViewHeightAnchor,
            loginTextFieldTopConstraint, loginTextFieldWidthAnchor,
            loginTextFieldHeightAnchor,
            passwordTextFieldTopConstraint, passwordTextFieldWidthAnchor,
            passwordTextFieldHeightAnchor,
            initButtonTopConstraint, initButtonWidthAnchor,
            initButtonHeightAnchor,
            errorLabelTopConstraint, errorLabelRightConstraint, errorLabelLeftConstraint
        ])
    }
    
    @objc private func buttonAction() {
        
        if //isEmpty(textField: loginTextField),
            validationEmail(textField: loginTextField), validationPassword(textField: passwordTextField) {
           
            if //isEmpty(textField: passwordTextField),
                validationPassword(textField: passwordTextField) {
                let controller = TabBarController()
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
        
        
    }
    
    private func checkCount(inputString: UITextField, givenString: String) {
        guard inputString.text!.count < givenString.count - 1 ||
                inputString.text!.count > givenString.count - 1 else {
                    errorLabel.text = ""
                    
                    return
                }
        errorLabel.textColor = .red
        errorLabel.text = "\(String(describing: inputString.placeholder!)) contains \(givenString.count) simbols"
    }
}

extension LogInViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text ?? "") + string
        let result: String
        
        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
        }
        
        if textField == loginTextField {
            checkCount(inputString: loginTextField, givenString: user.login)
        } else {
            checkCount(inputString: passwordTextField, givenString: user.password)
        }
        textField.text = result
        
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == loginTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            loginTextField.becomeFirstResponder()
        }
        
        return true
    }
}

extension LogInViewController {
    
    private func isEmpty(textField: UITextField) -> Bool {
        guard textField.text != "" else {
            textField.shake()
            return false
        }
        
        return true
    }
    
    private func validationEmail(textField: UITextField) -> Bool {
                
        guard isEmpty(textField: textField) else {
            return false
        }
        
        guard textField.text!.isValidEmail else {
            openAlert(title: "Error",
                      message: "Invalid email format..",
                      alertStyle: .alert, actionTitles: ["Try again"],
                      actionStyles: [.default],
                      actions: [{ _ in
            }])
            
            return false
        }
        guard textField.text?.lowercased() == user.login.lowercased() else {
            openAlert(title: "Error",
                      message: "Wrong email..",
                      alertStyle: .alert, actionTitles: ["Try again"],
                      actionStyles: [.default],
                      actions: [{ _ in
            }])
            
            return false
        }
        
        return true
    }
    
    private func validationPassword(textField: UITextField) -> Bool {
        guard isEmpty(textField: textField) else {
            return false
        }
        guard textField.text == user.password else {
            openAlert(title: "Error",
                      message: "Wrong password..",
                      alertStyle: .alert, actionTitles: ["Try again"],
                      actionStyles: [.default],
                      actions: [{ _ in
            }])
            
            return false
        }
        
        return true
    }
    
    func tapGesturt() {
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            let initButtonBottomY = self.initButton.frame.origin.y + initButton.frame.height
            let keyboardOriginY = self.view.frame.height - keyboardHeight
            let contentOffset = keyboardOriginY < initButtonBottomY ? initButtonBottomY - keyboardOriginY + 50 : 0
            
            self.scrollView.contentOffset = CGPoint(x: 0, y: contentOffset)
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        self.view.endEditing(true)
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}
