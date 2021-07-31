//
//  OTPVC.swift
//  PulBack
//
//  Created by Kh's MacBook on 31.07.2021.
//

import UIKit

class OTPVC: UIViewController {

    
    @IBOutlet weak var phoneNumberLbl: UILabel!{
        didSet{
            if isSmallScreen(){
                phoneNumberLbl.font = UIFont.systemFont(ofSize: 15)
            }
        }
    }
    @IBOutlet weak var helpLbl: UILabel!{
        didSet{
            if isSmallScreen(){
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOtpView()
        circleView.createCircularPath(radius: 30, lineWidth: 5, bgLineColor: .clear, progressColor: .green, firstDuration: 6)
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

  
    @IBAction func backBtnTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func confirmBtnTapped(_ sender: Any) {
        
    }
    
}


extension OTPVC: OTPFieldViewDelegate{
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        true
    }
    
    func enteredOTP(otp: String) {
        print(otp)
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
