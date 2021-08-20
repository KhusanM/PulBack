//
//  LogOutVC.swift
//  PulBack
//
//  Created by apple on 07/08/21.
//

import UIKit

class LogOutVC: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.containerView.transform = .identity
        }
      
    }
    
    @IBAction func noBtnTapped(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func yesBtnTapped(_ sender: Any) {
        UserDefaults.standard.setValue(false, forKey: "isLogged")
        if let window = UIApplication.shared.keyWindow{
            window.rootViewController = UINavigationController(rootViewController: SignInVC(nibName: "SignInVC", bundle: nil))
            window.makeKeyAndVisible()
        }
        
        
    }
    

}
