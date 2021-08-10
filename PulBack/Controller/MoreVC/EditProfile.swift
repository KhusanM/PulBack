//
//  EditProfile.swift
//  PulBack
//
//  Created by Kh's MacBook on 06.08.2021.
//

import UIKit

class EditProfile: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigation()
        
    }

    func initNavigation(){
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shouldRemoveShadow(true)
        navigationController?.navigationBar.tintColor = .black
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        let settings = UIBarButtonItem(image: UIImage(named: "settings"), style: .done, target: self, action: #selector(settingsBtnTapped))
        
        
        navigationItem.rightBarButtonItems = [settings]
    }
    
    @objc func settingsBtnTapped(){
        
    }

}
