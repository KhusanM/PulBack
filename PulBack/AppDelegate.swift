//
//  AppDelegate.swift
//  PulBack
//
//  Created by Kh's MacBook on 29.07.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        let vc = SignInVC(nibName: "SignInVC", bundle: nil)
        let navVC = UINavigationController(rootViewController: vc)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        
        
        
        return true
    }

   

}

