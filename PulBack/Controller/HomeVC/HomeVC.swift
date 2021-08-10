//
//  HomeVC.swift
//  PulBack
//
//  Created by Kh's MacBook on 02.08.2021.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.register(BalanceTVC.unib(), forCellReuseIdentifier: BalanceTVC.identifire)
            tableView.register(BannerTVC.unib(), forCellReuseIdentifier: BannerTVC.identifire)
            tableView.register(MagazinTVC.unib(), forCellReuseIdentifier: MagazinTVC.identifire)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigation()
        
    }
    
    private func initNavigation(){
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "PulBack"
        navigationController?.navigationBar.shouldRemoveShadow(true)
        
    }

    
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: BalanceTVC.identifire, for: indexPath) as! BalanceTVC
            if isSmallScreen{
                for i in cell.lbls{
                    i.font = UIFont.systemFont(ofSize: 15)
                }
                for j in cell.mediumLbls{
                    j.font = UIFont.systemFont(ofSize: 15, weight: .medium)
                }
            }
            
            return cell
            
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: BannerTVC.identifire, for: indexPath) as! BannerTVC
            if isSmallScreen{
                cell.heightForImg.constant = 170
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: MagazinTVC.identifire, for: indexPath) as! MagazinTVC
            
            if isSmallScreen{
                cell.tiinLbl.font = UIFont.systemFont(ofSize: 15, weight: .medium)
                cell.adressLbl.font = UIFont.systemFont(ofSize: 13, weight: .light)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2{
            let vc = MagazinVC(nibName: "MagazinVC", bundle: nil)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
