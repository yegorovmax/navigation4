////
////  DelFAstViewController.swift
////  navigation
////
////  Created by Max Egorov on 2/28/22.
////
//
//import UIKit
//
//class DelFAstViewController: UIViewController {
//    private lazy var profileHeaderView: ProfileHeaderView = {
//        let view = ProfileHeaderView(frame: .zero)
//        view.delegate = self
//        view.translatesAutoresizingMaskIntoConstraints = false // отключаем AutoresizingMask
//        
//        return view
//    }()
//    
//    private var heightConstraint: NSLayoutConstraint?
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupNavigationBar()
//        self.view.addSubview(self.profileHeaderView)
//        setupProfileHeadView()
//        tapGesturt()
//    }
//    
//    private func setupNavigationBar() {
//           self.navigationItem.title = "Flame"
//       }
//    
//        
//    private func setupProfileHeadView() {
//        self.view.backgroundColor = .lightGray
//        
//        let viewTopConstraint = self.profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor) // верх
//        let viewLeadingConstraint = self.profileHeaderView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor) // левый край
//        let viewTrailingConstraint = self.profileHeaderView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor) // левый край
//        self.heightConstraint = self.profileHeaderView.heightAnchor.constraint(equalToConstant: 220) // высота
//        NSLayoutConstraint.activate([
//            viewTopConstraint, viewLeadingConstraint, viewTrailingConstraint, self.heightConstraint
//        ].compactMap( {$0} )) // Активация констрейнов
//    }
//    
// 
//    func tapGesturt() { // метод скрытия клавиатуры при нажатии на экран
//        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing))
//        self.view.addGestureRecognizer(tapGesture)
//    }
//    
//}
//
//extension DelFAstViewController: ProfileHeaderViewProtocol { // разширение разширения вью
//
//    func buttonAction(inputTextIsVisible: Bool, completion: @escaping () -> Void) {
//        self.heightConstraint?.constant = inputTextIsVisible ? 250 : 220
//
//        UIView.animate(withDuration: 0.2, delay: 0.0) { // замедляем открытие/закрытие текстового поля
//            self.view.layoutIfNeeded()
//        } completion: { _ in
//            completion()
//        }
//    }
//}
//    
