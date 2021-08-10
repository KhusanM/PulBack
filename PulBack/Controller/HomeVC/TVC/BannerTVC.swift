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
    
    @IBOutlet weak var pageContr: SnakePageControl!
    @IBOutlet weak var heightForImg: NSLayoutConstraint!
    
    var scrollingTimer = Timer()
    var images = ["img1","img2","img3","img4","img5"]
    var counter = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        pageContr.pageCount = images.count
        DispatchQueue.main.async {
            self.scrollingTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }

    
    @objc func changeImage(){
        if counter < images.count{
            let index = IndexPath.init(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            
            counter += 1
        }else{
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            
        }
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
        let offSet = scrollView.contentOffset.x/scrollView.bounds.width
      

        pageContr.progress = CGFloat(offSet)
    }

}
