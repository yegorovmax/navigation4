//
//  ProfileViewController.swift
//  navigation
//
//  Created by Max Egorov on 2/11/22.
//

import UIKit

class ProfileViewController: UIViewController {

    let profileHeaderView = ProfileHeaderView()
    
    private var heightConstraint: NSLayoutConstraint?
    
//    private lazy var profileHeaderView: ProfileHeaderView = {
//        let view = ProfileHeaderView(frame: .zero)
//        view.delegate = self
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()

    
    override func viewDidLoad() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(profileHeaderView)
        self.setupNaigationBar()
        //self.setupView()
        
    }
    
    internal override func viewWillLayoutSubviews() {
        profileHeaderView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        profileHeaderView.frame = CGRect(origin: CGPoint.zero, size: view.frame.size)
    }

//    private func setupView() {
//        self.view.backgroundColor = .red
//        self.view.addSubview(self.profileHeaderView)
//        let topConstraint = self.profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
//        let leadingConstraint = self.profileHeaderView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
//        let trailingConstraint = self.profileHeaderView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
//        self.heightConstraint = self.profileHeaderView.heightAnchor.constraint(equalToConstant: 170)
//
//        NSLayoutConstraint.activate([
//            topConstraint, leadingConstraint, trailingConstraint, self.heightConstraint
//        ].compactMap({ $0 }))
//    }
    private func setupNaigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 35, width: screenSize.width, height: 100))
        let navItem = UINavigationItem(title: "Profile")
        
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
}
extension ProfileViewController: ProfileHeaderViewProtocol {
    
    func didTapStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> Void) {
        self.heightConstraint?.constant = textFieldIsVisible ? 214 : 170
        
        UIView.animate(withDuration: 0.3, delay: 0.0) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
}
