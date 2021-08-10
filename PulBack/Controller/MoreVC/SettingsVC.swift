//
//  SettingsVC.swift
//  PulBack
//
//  Created by Kh's MacBook on 06.08.2021.
//

import UIKit

class SettingsVC: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigation()
        
    }

    func initNavigation(){
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shouldRemoveShadow(true)
        navigationItem.title = "Созламалар"
        navigationController?.navigationBar.tintColor = .black
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
    }
    
    @IBAction func logOutBtnTapped(_ sender: Any) {
        let vc = LogOutVC(nibName: "LogOutVC", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: false, completion: nil)
    }
    
}
