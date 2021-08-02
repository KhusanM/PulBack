//
//  TabbarVC.swift
//  PulBack
//
//  Created by Kh's MacBook on 02.08.2021.
//

import UIKit

class TabbarVC: UITabBarController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor  = .clear
        let v1 = HomeVC(nibName: "HomeVC", bundle: nil)
        v1.tabBarItem.image = UIImage(named: "home")
        let navFont = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .light)]
        UINavigationBar.appearance().titleTextAttributes = navFont
        let nav1 = UINavigationController(rootViewController: v1)

        
        let v2 = QrCodeVC(nibName: "QrCodeVC", bundle: nil)
        v2.tabBarItem.image = UIImage(named: "qr-code")
        let nav2 = UINavigationController(rootViewController: v2)
        
        
        let v3 = MoreVC(nibName: "MoreVC", bundle: nil)
        v3.tabBarItem.image = UIImage(named: "more")
        let nav3 = UINavigationController(rootViewController: v3)
        
        
        
        
        
        self.viewControllers = [nav1, nav2, nav3]
    }
   

}
