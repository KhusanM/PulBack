//
//  EditProfile.swift
//  PulBack
//
//  Created by Kh's MacBook on 06.08.2021.
//

import UIKit
import MobileCoreServices


class EditProfile: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var surnameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigation()
        updateUserInfo()
        imgView.image = UserDefaults.standard.imageForKey(key: "Img")
    }
    
    private func updateUserInfo(){
        self.nameTF.text = Cache.getUser()?.first_name ?? ""
        self.surnameTF.text = Cache.getUser()?.last_name ?? ""
        self.phoneNumberTF.text = Cache.getUser()?.phone_number ?? ""
        
        self.phoneNumberTF.isEnabled = false
        self.nameTF.isEnabled = false
        self.surnameTF.isEnabled = false
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
    
    @IBAction func changePhotoBtnTapped(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.mediaTypes = [kUTTypeImage as String]
        
        vc.delegate = self
        
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        UserDefaults.standard.setImage(image: imgView.image, forKey: "Img")
        navigationController?.popViewController(animated: true)
    }
    
}
//MARK: - ImageView Delegate

extension EditProfile: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! CFString
        switch mediaType {
        case kUTTypeImage:
            
            let originalImg = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            self.imgView.image = originalImg
            UserDefaults.standard.setImage(image: originalImg, forKey: "Img")
        default:
            break
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension UserDefaults {
    
    func imageForKey(key: String) -> UIImage? {
        var image: UIImage?
        if let imageData = data(forKey: key) {
            image = NSKeyedUnarchiver.unarchiveObject(with: imageData) as? UIImage
        }
        return image
    }
    
    func setImage(image: UIImage?, forKey key: String) {
        var imageData: NSData?
        if let image = image {
            imageData = NSKeyedArchiver.archivedData(withRootObject: image) as NSData?
        }
        set(imageData, forKey: key)
    }
    
}
