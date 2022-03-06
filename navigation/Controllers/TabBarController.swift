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
        case articles
        
        var title: String {
            switch self {
            case .feed:
                return "Home"
            case .profile:
                return "Profile"
            case .articles:
                return "Articles"
            }
        }
        
        var image: UIImage? {
            switch self {
            case .feed:
                return UIImage(systemName: "house")
            case .profile:
                return UIImage(systemName: "person.circle")
            case .articles:
                return UIImage(systemName: "flame.circle")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()
    }
    
    private func setupTabBar() {
        let items: [TabBarItem] = [.feed, /*.articles,*/ .profile]
        
        self.viewControllers = items.map({ tabBarIten in
            switch tabBarIten {
            case .feed:
                return UINavigationController(rootViewController: FeedViewController())
            case .articles:
                return UINavigationController(rootViewController: ArticlesViewController())
            case .profile:
                //return UINavigationController(rootViewController: ProfileViewController())

                return UINavigationController(rootViewController: LogInViewController())
            }
        })
        self.viewControllers?.enumerated().forEach({ (index, vc) in
            vc.tabBarItem.title = items[index].title
            vc.tabBarItem.image = items[index].image
        })
    }
}
