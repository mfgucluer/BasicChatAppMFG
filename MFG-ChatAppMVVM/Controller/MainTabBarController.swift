//
//  MainTabBarController.swift
//  MFG-ChatAppMVVM
//
//  Created by Mustafa Fatih on 5/9/24.
//

import UIKit

class MainTabBarController: UITabBarController {

    let wallVC = WallViewController()
    let moreVC = MoreViewController()
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .systemBackground
                
        let vc1 = UINavigationController(rootViewController: wallVC)
        let vc2 = UINavigationController(rootViewController: moreVC)
        
        
        vc1.title = "Duvarım"
        vc1.tabBarItem.image = UIImage(systemName: "folder")
        vc1.tabBarItem.selectedImage = UIImage(systemName: "folder.fill")

        vc2.title = "Daha Fazla"
        vc2.tabBarItem.image = UIImage(systemName: "ellipsis.circle")
        vc2.tabBarItem.selectedImage = UIImage(systemName: "ellipsis.circle.fill")
        
        setViewControllers([vc1,vc2], animated: true)
        tabBar.barTintColor = .black
        
        selectedIndex = 0 //always start vc1 when open tabbar
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    

    

}
