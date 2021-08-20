//
//  OTPVC.swift
//  PulBack
//
//  Created by Kh's MacBook on 31.07.2021.
//

import UIKit


struct UserDM : Codable{
    var first_name: String
    var last_name: String
    var point_balance: Double
    var phone_number: String
    var user_id: String
    var token: String
    
}
class OTPVC: UIViewController {

    
    @IBOutlet weak var phoneNumberLbl: UILabel!{
        didSet{
            if isSmallScreen{
                phoneNumberLbl.font = UIFont.systemFont(ofSize: 15)
            }
        }
    }
    @IBOutlet weak var helpLbl: UILabel!{
        didSet{
            if isSmallScreen{
                helpLbl.font = UIFont.systemFont(ofSize: 15)
            }
        }
    }
    @IBOutlet weak var otpTextFieldView: OTPFieldView!
    
    
    @IBOutlet weak var circleView: TimerView!{
        didSet{
            circleView.delegate = self
        }
    }
    
    var phone_number = ""
    var otp = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupOtpView()
        circleView.createCircularPath(radius: 30, lineWidth: 5, bgLineColor: .clear, progressColor: .green, firstDuration: 60)
        circleView.progressAnimation()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))

    }
    
    @objc func tap(sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    
    func setupOtpView(){
            self.otpTextFieldView.fieldsCount = 4
            self.otpTextFieldView.fieldBorderWidth = 2
            self.otpTextFieldView.defaultBorderColor = UIColor.black
            self.otpTextFieldView.filledBorderColor = UIColor.green
            self.otpTextFieldView.cursorColor = UIColor.red
            self.otpTextFieldView.displayType = .underlinedBottom
            self.otpTextFieldView.fieldSize = 40
            self.otpTextFieldView.separatorSpace = 8
            self.otpTextFieldView.shouldAllowIntermediateEditing = false
            self.otpTextFieldView.delegate = self
            self.otpTextFieldView.initializeUI()
    }

    private func sendUserDM(){
        let param = [
            "phone_number": phone_number,
            "otp": otp
        ]
        
            Network.request(url: "/client/sign-verify", method: .post, param: param, header: nil) { data in
                if let data = data{
                    let statusCode = data["code"].intValue
                    
                    switch statusCode {
                    case 0:
                        let user = UserDM(first_name: data["data"]["first_name"].stringValue,
                                          last_name: data["data"]["last_name"].stringValue,
                                          point_balance: data["data"]["point_balance"].doubleValue,
                                          phone_number: data["data"]["phone_number"].stringValue,
                                          user_id: data["data"]["user_id"].stringValue,
                                          token: data["data"]["token"].stringValue)
                        
                        Cache.saveUser(user: user)
                        Cache.saveUserToken(token: data["data"]["token"].stringValue)
                        
                        
                        if let window = UIApplication.shared.keyWindow{
                            window.rootViewController = TabbarVC(nibName: "TabbarVC", bundle: nil)
                            window.makeKeyAndVisible()
                        }
                    
                    default:
                        ShowAlert.showAlert(text: data["message"].stringValue, forState:.error)
                    }
                }
            }
        
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func confirmBtnTapped(_ sender: Any) {
        
       sendUserDM()
    }
    
}


extension OTPVC: OTPFieldViewDelegate{
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        true
    }
    
    func enteredOTP(otp: String) {
        self.otp = otp
    }
    
    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        false
    }
    
    
}

extension OTPVC: TimerViewDelegate{
    func refreshTimeView() {
        print("refresh")
    }
    
    
}
