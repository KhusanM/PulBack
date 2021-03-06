//
//  BalanceTVC.swift
//  PulBack
//
//  Created by Kh's MacBook on 02.08.2021.
//

import UIKit

class BalanceTVC: UITableViewCell {

    static func unib() -> UINib{
        return UINib(nibName: "BalanceTVC", bundle: nil)
    }
    static var identifire = "BalanceTVC"
    
    @IBOutlet weak var sumLbl: UILabel!
    @IBOutlet var lbls: [UILabel]!
    @IBOutlet var mediumLbls: [UILabel]!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateCell(with balance: String){
        self.sumLbl.text = balance
    }
    
}
