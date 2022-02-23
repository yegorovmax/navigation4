//
//  ProfileViewController.swift
//  navigation
//
//  Created by Max Egorov on 2/11/22.
//

import UIKit

class ProfileViewController: UIViewController {

    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var heightConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.profileHeaderView)
        setupView()
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
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
    
    internal override func viewWillLayoutSubviews() {
        profileHeaderView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        profileHeaderView.frame = CGRect(origin: CGPoint.zero, size: view.frame.size)
    }

    
    private func setupNaigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 35, width: screenSize.width, height: 100))
        let navItem = UINavigationItem(title: "Profile")
        
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
}
extension ProfileViewController: ProfileHeaderViewProtocol {
    
    func buttonAction(inputTextIsVisible: Bool, completion: @escaping () -> Void) {
        self.heightConstraint?.constant = inputTextIsVisible ? 250 : 220
        UIView.animate(withDuration: 0.2, delay: 0.0) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
}
