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
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        if UserDefaults.standard.bool(forKey: "isLogged"){
            let vc = TabbarVC()
            window?.rootViewController = vc
        }else{
            let vc = SignInVC(nibName: "SignInVC", bundle: nil)
            let navVC = UINavigationController(rootViewController: vc)
            window?.rootViewController = navVC
        }
        
        window?.makeKeyAndVisible()
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        return true
    }

   

}

