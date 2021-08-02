//
//  MagazinTVC.swift
//  PulBack
//
//  Created by Kh's MacBook on 02.08.2021.
//

import UIKit

class MagazinTVC: UITableViewCell {

    
    static func unib() -> UINib{
        return UINib(nibName: "MagazinTVC", bundle: nil)
    }
    static var identifire = "MagazinTVC"
    
    @IBOutlet weak var tiinLbl: UILabel!
    @IBOutlet weak var adressLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
