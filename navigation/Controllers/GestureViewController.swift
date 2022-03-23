//
//  GestureViewController.swift
//  navigation
//
//  Created by Max Egorov on 3/8/22.
//

import UIKit

class GestureViewController: UIViewController {
    
    private lazy var userPhotoGesture: UIImageView = {
        let userPhotoGesture = UIImageView(image: UIImage(named: "1"))
        userPhotoGesture.layer.borderWidth = 3.0
        userPhotoGesture.layer.borderColor = UIColor.lightGray.cgColor
        userPhotoGesture.layer.cornerRadius = 50
        userPhotoGesture.layer.masksToBounds = true
        userPhotoGesture.isUserInteractionEnabled = true
        userPhotoGesture.translatesAutoresizingMaskIntoConstraints = false
        return userPhotoGesture
    }()
    
    private lazy var viewUser: UIView = {
        let viewUser = UIView()
        viewUser.alpha = 0
        viewUser.isUserInteractionEnabled = false
        viewUser.translatesAutoresizingMaskIntoConstraints = false
        return viewUser
    }()
    
    private lazy var buttonMultiply: UIImageView = {
        let buttonMultiply = UIImageView(image: UIImage(systemName: "multiply"))
        buttonMultiply.tintColor = .black
        buttonMultiply.alpha = 0
        buttonMultiply.isUserInteractionEnabled = true
        buttonMultiply.translatesAutoresizingMaskIntoConstraints = false
        return buttonMultiply
    }()
    
    private var tapUserPhotoGesture = UITapGestureRecognizer()
    private var tapButtonMultiply = UITapGestureRecognizer()
    
    private var topConstraint: NSLayoutConstraint?
    private var leftConstraint: NSLayoutConstraint?
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
       
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(userPhotoGesture)
        view.backgroundColor = .white
        setUpImage()
        setUpView()
        setUpButton()
        setUpGesture()
    }
    
    private func setUpImage() {

        topConstraint = userPhotoGesture.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        leftConstraint = userPhotoGesture.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        widthConstraint = userPhotoGesture.widthAnchor.constraint(equalToConstant: 100)
        heightConstraint = userPhotoGesture.heightAnchor.constraint(equalToConstant: 100)
        
        NSLayoutConstraint.activate([topConstraint, leftConstraint,
                                     widthConstraint, heightConstraint].compactMap({ $0 }))
    }
    
    private func setUpView() {
            self.view.addSubview(viewUser)
            
           let viewUserTop = viewUser.topAnchor.constraint(equalTo: userPhotoGesture.bottomAnchor)
           let viewUserLeft = viewUser.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
           let viewUserRight = viewUser.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
           let viewUserBottom = viewUser.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        
        NSLayoutConstraint.activate([viewUserTop, viewUserLeft, viewUserRight, viewUserBottom])
    }
    
    private func setUpButton() {
        self.view.addSubview(buttonMultiply)
        
        let buttonMultiplyTop = buttonMultiply.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16)
        let buttonMultiplyRight = buttonMultiply.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        let buttonMultiplyWidth = buttonMultiply.widthAnchor.constraint(equalToConstant: 20)
        let buttonMultiplyHeight = buttonMultiply.heightAnchor.constraint(equalToConstant: 25)
        
        NSLayoutConstraint.activate([buttonMultiplyTop, buttonMultiplyRight, buttonMultiplyWidth, buttonMultiplyHeight])
    }
    
    private func setUpGesture() {
        tapUserPhotoGesture.addTarget(self, action: #selector(handleTapGesture(_:)))
        userPhotoGesture.addGestureRecognizer(self.tapUserPhotoGesture)
        
        tapButtonMultiply.addTarget(self, action: #selector(buttonMultiplyTap(_:)))
        buttonMultiply.addGestureRecognizer(self.tapButtonMultiply)
    }
    
    @objc func handleTapGesture(_ gestureRecognazer: UITapGestureRecognizer) {
        guard tapUserPhotoGesture === gestureRecognazer else { return }
        
        topConstraint?.constant =  (view.frame.height - view.frame.width) / 4
        leftConstraint?.constant =  0
        widthConstraint?.constant = view.frame.width
        heightConstraint?.constant = view.frame.width
        userPhotoGesture.layer.cornerRadius =  0
        viewUser.alpha = 0.5
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        } completion: { _ in
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.5) {
            self.buttonMultiply.alpha = 1
        } completion: { _ in
        }
    }
 
    @objc func buttonMultiplyTap(_ gestureRecognazer: UITapGestureRecognizer) {
        guard tapButtonMultiply === gestureRecognazer else { return }
        
        topConstraint?.constant =  16
        leftConstraint?.constant =  16
        widthConstraint?.constant =  100
        heightConstraint?.constant =  100
        userPhotoGesture.layer.cornerRadius =  heightConstraint!.constant / 2
        viewUser.alpha =  0
        buttonMultiply.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        } completion: { _ in
        }
    }
}
