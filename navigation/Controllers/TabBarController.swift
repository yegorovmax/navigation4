//
//  TabBarController.swift
//  navigation
//
//  Created by Max Egorov on 2/15/22.
//

import UIKit

class TabBarController: UITabBarController {
    
    private enum TabBarItem {
        case feed
        case profile
        
        var title: String {
            switch self {
            case .feed:
                return "Лента"
            case .profile:
                return "Профиль"
            }
        }
        
        var image: UIImage? {
            switch self {
            case .feed:
                return UIImage(systemName: "house")
            case .profile:
                return UIImage(systemName: "person.circle")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()
    }
    
    private func setupTabBar() {
        let items: [TabBarItem] = [.feed, .profile]
        
        self.viewControllers = items.map({ tabBarIten in
            switch tabBarIten {
            case .feed:
                return UINavigationController(rootViewController: FeedViewController())
            case .profile:
                return ProfileViewController()
            }
        })
        self.viewControllers?.enumerated().forEach({ (index, vc) in
            vc.tabBarItem.title = items[index].title
            vc.tabBarItem.image = items[index].image
        })
    }
}
