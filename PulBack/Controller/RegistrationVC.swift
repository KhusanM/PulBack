//
//  RegistrationVC.swift
//  PulBack
//
//  Created by Kh's MacBook on 31.07.2021.
//

import UIKit

class RegistrationVC: UIViewController {

    
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var surNameTF: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        
        
        
    }
    
    @objc func tap(sender: UITapGestureRecognizer){
        view.endEditing(true)
    }

    @IBAction func checkBtnTapped(_ sender: Any) {
        if checkBtn.currentImage == UIImage(named: "check"){
            checkBtn.setImage(UIImage(named: "uncheck"), for: .normal)
        }else{
            checkBtn.setImage(UIImage(named: "check"), for: .normal)
        }
        
        
    }
    
    
    @IBAction func registrationBtnTapped(_ sender: Any) {
        let vc = OTPVC(nibName: "OTPVC", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    

}
