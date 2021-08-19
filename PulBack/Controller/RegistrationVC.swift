//
//  RegistrationVC.swift
//  PulBack
//
//  Created by Kh's MacBook on 31.07.2021.
//

import UIKit

class RegistrationVC: UIViewController {

    
    @IBOutlet weak var registrationLbl: UILabel!
    @IBOutlet weak var openPageLbl: UILabel!
    @IBOutlet weak var buyLbl: UILabel!
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var nameTF: UITextField!{
        didSet{
            nameTF.delegate = self
        }
    }
    @IBOutlet weak var surNameTF: UITextField!
    @IBOutlet weak var registrationBtn: CustomButton!
    @IBOutlet weak var heightForTF: NSLayoutConstraint!
    
    
    var phone_number = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerKeyboardNotifications()
        setupFont()
        
    }
    
    private func setupFont(){
        if isSmallScreen{
            registrationLbl.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            openPageLbl.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            heightForTF.constant = 40
            buyLbl.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            registrationBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            nameTF.font = UIFont.systemFont(ofSize: 17)
            surNameTF.font = UIFont.systemFont(ofSize: 17)
        }
    }

    private func sendUserDM(){
        let param = [
            "first_name": nameTF.text!,
            "last_name": surNameTF.text!,
            "phone_number": phone_number
        ]
        
        if nameTF.text!.isEmpty{
            ShowAlert.showAlert(text: "Name must not be empty!", forState: .error)
        }else if checkBtn.currentImage != UIImage(named: "check"){
            ShowAlert.showAlert(text: "Check must not be empty!", forState: .error)
        }else{
            Network.request(url: "/client/sign-up", method: .post, param: param, header: nil) { data in
                if let data = data{
                    let statusCode = data["code"].intValue
                    
                    switch statusCode {
                    case 0:
                        
                        let vc = OTPVC(nibName: "OTPVC", bundle: nil)
                        vc.phone_number = self.phone_number
                        self.navigationController?.pushViewController(vc, animated: true)
                    default:
                        ShowAlert.showAlert(text: data["message"].stringValue, forState:.error)
                    }
                }
            }
        }
        
        
        
    }
    @IBAction func checkBtnTapped(_ sender: Any) {
        if checkBtn.currentImage == UIImage(named: "check"){
            checkBtn.setImage(UIImage(named: "uncheck"), for: .normal)
        }else{
            checkBtn.setImage(UIImage(named: "check"), for: .normal)
        }
        
        
    }
    
    
    @IBAction func registrationBtnTapped(_ sender: Any) {
        sendUserDM()
        
        
    }
    

}

extension RegistrationVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTF{
            nameTF.resignFirstResponder()
            surNameTF.becomeFirstResponder()
        }
        return true
    }
}

//MARK: - Keyboard Handling

extension RegistrationVC {
    
    func registerKeyboardNotifications() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
        
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let _ = keyboardInfo.cgRectValue.size
        
        
        UIView.animate(withDuration: 0.5) {
            if self.isSmallScreen{
                self.view.transform = CGAffineTransform(translationX: 0, y: -70)
            }
            
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.5) {
            self.view.transform = .identity
        }
    }

}
