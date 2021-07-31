//
//  CustomButton.swift
//  PulBack
//
//  Created by Kh's MacBook on 31.07.2021.
//

import UIKit

class CustomButton: UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBtn()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupBtn()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupBtn()
    }
    
    func setupBtn(){
        self.layer.cornerRadius = self.bounds.height/2
        self.backgroundColor = AppColors.custom_red
        self.clipsToBounds = true
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
}
