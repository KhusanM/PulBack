//
//  BannerImageCVC.swift
//  PulBack
//
//  Created by Kh's MacBook on 02.08.2021.
//

import UIKit

class BannerImageCVC: UICollectionViewCell {

    
    @IBOutlet weak var img: UIImageView!
    
    
    static func unib() -> UINib{
        return UINib(nibName: "BannerImageCVC", bundle: nil)
    }
    static var identifire = "BannerImageCVC"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(with: UIImage){
        img.image = with
    }
    
    

}


