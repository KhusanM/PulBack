//
//  LanguageVC.swift
//  PulBack
//
//  Created by Kh's MacBook on 12.08.2021.
//

import UIKit

class LanguageVC: UIViewController {

    
    @IBOutlet weak var conteinerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conteinerView.transform = CGAffineTransform(translationX: 0, y: conteinerView.bounds.height)

    }

    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.conteinerView.transform = .identity
        }
    }

    @IBAction func dismisBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
