//
//  MagazinVC.swift
//  PulBack
//
//  Created by Kh's MacBook on 06.08.2021.
//

import UIKit

class MagazinVC: UIViewController {

    
    
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
        
        
    }

    

}
