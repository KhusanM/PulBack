//
//  MoreVC.swift
//  PulBack
//
//  Created by Kh's MacBook on 02.08.2021.
//

import UIKit
import BarcodeScanner


struct ProductDM {
    var count : String
    var price: String
}

class MoreVC: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    
    var product: [ProductDM] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.image = UserDefaults.standard.imageForKey(key: "Img")
        initNavigation()
        updateUserInfo()
    }
    
    private func updateUserInfo(){
        self.fullNameLbl.text = "\(Cache.getUser()?.first_name ?? "") \(Cache.getUser()?.last_name ?? "")"
        self.phoneNumberLbl.text = "\(Cache.getUser()?.phone_number ?? "")"
    }
    
    
    func initNavigation(){
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shouldRemoveShadow(true)
        navigationController?.navigationBar.tintColor = .gray
        let callCentrBtn = UIBarButtonItem(image: UIImage(named: "call-center"), style: .done, target: self, action: #selector(callBtnTapped))
        let qrQode = UIBarButtonItem(image: UIImage(named: "qr-code-1"), style: .done, target: self, action: #selector(qrQodeBtnTapped))
        let settings = UIBarButtonItem(image: UIImage(named: "settings"), style: .done, target: self, action: #selector(settingsBtnTapped))
        
        navigationItem.leftBarButtonItem = callCentrBtn
        navigationItem.rightBarButtonItems = [settings, qrQode]
    }
    
    @objc func callBtnTapped(){
        callNumber(phoneNumber: "+998919180033")
    }
    
    @objc func qrQodeBtnTapped(){
        let viewController = BarcodeScannerViewController()
        viewController.codeDelegate = self
        viewController.errorDelegate = self
        viewController.dismissalDelegate = self
        
        present(viewController, animated: true, completion: nil)
    }
    
    @objc func settingsBtnTapped(){
        let vc = SettingsVC(nibName: "SettingsVC", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func callNumber(phoneNumber:String) {
            if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
          }
        }
    
    @IBAction func editProfileBtnTapped(_ sender: Any) {
        navigationController?.pushViewController(EditProfile(nibName: "EditProfile", bundle: nil), animated: true)
    }
    @IBAction func languageBtnTapped(_ sender: Any) {
        let vc = LanguageVC(nibName: "LanguageVC", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: false, completion: nil)
        
    }
    
}


extension MoreVC: BarcodeScannerCodeDelegate {
  func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
    print(code)
    
    controller.reset()
    
    Network.requestWithToken(url: "/item/get-by-barcode", method: .post, param: ["barcode" : code]) { data in
        if let data = data{
            print(data)
            
            self.product = data["data"]["prices"].arrayValue.map { item in ProductDM(count: item["from"].stringValue, price: item["price"].stringValue)
                
            }
            print(self.product)
        }
    }
  }
}

extension MoreVC: BarcodeScannerErrorDelegate {
  func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
    print(error)
  }
}

extension MoreVC: BarcodeScannerDismissalDelegate {
  func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
    controller.dismiss(animated: true, completion: nil)
  }
}
