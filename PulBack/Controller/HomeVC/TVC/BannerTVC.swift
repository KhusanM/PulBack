//
//  BannerTVC.swift
//  PulBack
//
//  Created by Kh's MacBook on 02.08.2021.
//

import UIKit

class BannerTVC: UITableViewCell {

    static func unib() -> UINib{
        return UINib(nibName: "BannerTVC", bundle: nil)
    }
    static var identifire = "BannerTVC"
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(BannerImageCVC.unib(), forCellWithReuseIdentifier: BannerImageCVC.identifire)
        }
    }
    
    @IBOutlet weak var pageContr: UIPageControl!
    @IBOutlet weak var heightForImg: NSLayoutConstraint!
    
    var images = ["img1","img2","img3","img4","img5"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pageContr.numberOfPages = images.count
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func pageController(_ sender: Any) {
        
    }
    
}

extension BannerTVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerImageCVC.identifire, for: indexPath) as! BannerImageCVC
        
        cell.updateCell(with: UIImage(named: images[indexPath.row])!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width, height: 270)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2

        pageContr.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }

}
