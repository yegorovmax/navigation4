//
//  AnimatedAvatarViewController.swift
//  navigation
//
//  Created by Max Egorov on 3/11/22.
//

import UIKit

class AnimatedAvatarViewController: UIViewController {
    
    private lazy var avatarImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "picon.jpg"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 50.0
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    private lazy var viewUser: UIView = {
        let viewUser = UIView()
        viewUser.alpha = 0
        viewUser.isUserInteractionEnabled = false
        viewUser.translatesAutoresizingMaskIntoConstraints = false
        return viewUser
    }()
    
    private var tapUserPhotoGesture = UITapGestureRecognizer()
    private var tapButtonMultiply = UITapGestureRecognizer()
    private var topConstraint: NSLayoutConstraint?
    private var leftConstraint: NSLayoutConstraint?
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    
    private var widthAvatarImage: NSLayoutConstraint?
    private var heightAvatarImage: NSLayoutConstraint?
    private var positionXAvatarImage: NSLayoutConstraint?
    private var positionYAvatarImage: NSLayoutConstraint?
    
    private lazy var buttonMultiply: UIButton = {
        let buttonMultiply = UIButton()
        let image = UIImage(systemName: "multiply")
        buttonMultiply.setBackgroundImage(image, for: .normal)
        buttonMultiply.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        buttonMultiply.tintColor = .white
        buttonMultiply.alpha = 0
        buttonMultiply.isUserInteractionEnabled = true
        buttonMultiply.translatesAutoresizingMaskIntoConstraints = false
        return buttonMultiply
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(avatarImage)
        self.view.backgroundColor = .black.withAlphaComponent(0.0)
    
        setupSubView()
        self.view.layoutIfNeeded()
        expand()
        
    }
    
    private func setupSubView() {  
        self.view.addSubview(avatarImage)
        self.view.addSubview(buttonMultiply)
        
        self.widthAvatarImage = self.avatarImage.widthAnchor.constraint(equalToConstant: 138)
        self.heightAvatarImage = self.avatarImage.heightAnchor.constraint(equalToConstant: 138)
        self.positionXAvatarImage = self.avatarImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 63)
        self.positionYAvatarImage = self.avatarImage.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        
        let buttonTopConstrain = self.buttonMultiply.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16)
        let buttonTrailingConstraint = self.buttonMultiply.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        let buttonHeightConstraint = self.buttonMultiply.heightAnchor.constraint(equalToConstant: 40)
        let buttonWidthConstraint = self.buttonMultiply.widthAnchor.constraint(equalToConstant: 40)
        
        NSLayoutConstraint.activate([
            self.widthAvatarImage, self.heightAvatarImage, self.positionXAvatarImage, self.positionYAvatarImage,
            buttonTopConstrain, buttonTrailingConstraint, buttonHeightConstraint, buttonWidthConstraint
        ].compactMap( {$0} ))
    }
    
    private func expand() {
        NSLayoutConstraint.deactivate([
           self.positionXAvatarImage, self.positionYAvatarImage, self.widthAvatarImage, self.heightAvatarImage
        ].compactMap( {$0} ))
        
        self.widthAvatarImage = self.avatarImage.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        self.heightAvatarImage = self.avatarImage.heightAnchor.constraint(equalTo: self.view.widthAnchor)
        self.positionXAvatarImage = self.avatarImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        self.positionYAvatarImage = self.avatarImage.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        
        UIView.animate(withDuration: 3, animations: { 
            NSLayoutConstraint.activate([
               self.positionXAvatarImage, self.positionYAvatarImage, self.widthAvatarImage, self.heightAvatarImage
            ].compactMap( {$0} ))
            self.avatarImage.layer.cornerRadius = 0.0
            self.view.backgroundColor = .black.withAlphaComponent(0.8)
            self.view.layoutIfNeeded()
        }) { _ in
            UIView.animate(withDuration: 0.25) {
            self.buttonMultiply.alpha = 1
            }
        }
    }
    
    func colapse() {
        NSLayoutConstraint.deactivate([
            self.positionXAvatarImage, self.positionYAvatarImage, self.widthAvatarImage, self.heightAvatarImage
        ].compactMap( {$0} ))
        
        self.widthAvatarImage = self.avatarImage.widthAnchor.constraint(equalToConstant: 138)
        self.heightAvatarImage = self.avatarImage.heightAnchor.constraint(equalToConstant: 138)
        self.positionXAvatarImage = self.avatarImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 63)
        self.positionYAvatarImage = self.avatarImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
        
        UIView.animate(withDuration: 3, animations: {
            NSLayoutConstraint.activate([
                self.positionXAvatarImage, self.positionYAvatarImage, self.widthAvatarImage, self.heightAvatarImage
            ].compactMap( {$0} ))
            self.avatarImage.layer.cornerRadius = 70.0
            self.view.backgroundColor = .black.withAlphaComponent(0.8)
            self.buttonMultiply.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            self.view.removeFromSuperview()
        }
    }
    
      @objc private func clickButton() {
          colapse()
      }
    
    private func setUpImage() {

        topConstraint = avatarImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        leftConstraint = avatarImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        widthConstraint = avatarImage.widthAnchor.constraint(equalToConstant: 100)
        heightConstraint = avatarImage.heightAnchor.constraint(equalToConstant: 100)
        
        NSLayoutConstraint.activate([topConstraint, leftConstraint,
                                     widthConstraint, heightConstraint].compactMap({ $0 }))
    }
    
    private func setUpView() {
            self.view.addSubview(viewUser)
            
           let viewUserTop = viewUser.topAnchor.constraint(equalTo: avatarImage.bottomAnchor)
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
        avatarImage.addGestureRecognizer(self.tapUserPhotoGesture)
        
        tapButtonMultiply.addTarget(self, action: #selector(buttonMultiplyTap(_:)))
        buttonMultiply.addGestureRecognizer(self.tapButtonMultiply)
    }
    
    @objc func handleTapGesture(_ gestureRecognazer: UITapGestureRecognizer) {
        guard tapUserPhotoGesture === gestureRecognazer else { return }
        
        topConstraint?.constant =  (view.frame.height - view.frame.width) / 4
        leftConstraint?.constant =  0
        widthConstraint?.constant = view.frame.width
        heightConstraint?.constant = view.frame.width
        avatarImage.layer.cornerRadius =  0
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
        avatarImage.layer.cornerRadius =  heightConstraint!.constant / 2
        viewUser.alpha =  0
        buttonMultiply.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        } completion: { _ in
        }
    }
}
