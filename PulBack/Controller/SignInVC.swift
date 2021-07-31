//
//  SignInVC.swift
//  PulBack
//
//  Created by Kh's MacBook on 29.07.2021.
//

import UIKit
import FlagPhoneNumber

class SignInVC: UIViewController {


    @IBOutlet weak var textField: FPNTextField!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var pulBackBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var infoLbl: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        lblLink()
        navigationController?.navigationBar.isHidden = true
    }
    
    func setup() {

        signInBtn.layer.cornerRadius = signInBtn.frame.height/2
        
        textField.layer.cornerRadius = textField.frame.height/2
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.black.cgColor
        textField.rightViewMode = .always
        textField.setFlag(countryCode: .UZ)
        textField.flagButtonSize = CGSize(width: 47, height: 44)
        
        if isSmallScreen() {
            infoLbl.font = UIFont.systemFont(ofSize: 15)
            //pulBackBtnHeight.constant = 45
            signInBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
            textField.font = UIFont.systemFont(ofSize: 16)
        }

    }
    
    
    @IBAction func enterBtnTapped(_ sender: Any) {
        let vc = RegistrationVC(nibName: "RegistrationVC", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    

}

extension SignInVC {
    
    func lblLink() {
        
        let text = (infoLbl.text)!
        let underlineAttriString = NSMutableAttributedString(string: text)
        let termsRange = (text as NSString).range(of: "мана бундан бошланг")
        
        underlineAttriString.addAttribute(
            .foregroundColor,
            value: UIColor.black,
            range: termsRange)
        if isSmallScreen() {
            underlineAttriString.addAttribute(
                .font, value:UIFont.systemFont(ofSize: 15, weight: .medium), range: termsRange)
        }else {
            underlineAttriString.addAttribute(
                .font, value:UIFont.systemFont(ofSize: 17, weight: .medium), range: termsRange)
        }
        
        underlineAttriString.addAttribute(
            NSAttributedString.Key .underlineStyle, value: 1, range:termsRange)
        
        infoLbl.attributedText = underlineAttriString
        infoLbl.isUserInteractionEnabled = true
        infoLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(lblTapped(_:))))
        
    }
    
    @objc func lblTapped(_ gesture: UITapGestureRecognizer){
        let termsRange = (infoLbl.text! as NSString).range(of: "мана бундан бошланг")
        if gesture.didTapAttributedTextInLabel(label: infoLbl, inRange: termsRange ){
            print("lbl")
        }
    }
}
