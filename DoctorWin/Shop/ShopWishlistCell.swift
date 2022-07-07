//
//  ShopWishlistCell.swift
//  DoctorWin
//
//  Created by AHP on 05/07/2565 BE.
//

import UIKit

class ShopWishlistCell: UITableViewCell {
    var salesArray: [ShopModel] = []
    var recentArray: [ShopModel] = []
    var bookmarkArray: [ShopModel] = []
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(UINib.init(nibName: "ShopCVCell", bundle: nil), forCellWithReuseIdentifier: "ShopCVCell")

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension ShopWishlistCell : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return salesArray.count
        } else if section == 1 {
            return recentArray.count
        } else {
            return bookmarkArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: ShopCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCVCell", for: indexPath) as! ShopCVCell
        if indexPath.section == 0 {
            cell.configureCell(data: salesArray[indexPath.row])
        } else if indexPath.section == 1 {
            cell.configureCell(data: recentArray[indexPath.row])
        } else {
            cell.configureCell(data: bookmarkArray[indexPath.row])
        }
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let yourWidth = collectionView.bounds.width/2 - 10
        return CGSize(width: yourWidth, height: 205)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //.zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let str = UIStoryboard(name: "Shop", bundle: nil)
//        let nextVC = str.instantiateViewController(withIdentifier: "ShopDetailsViewController") as! ShopDetailsViewController
//        if indexPath.section == 0 {
//            nextVC.productId = salesArray[indexPath.row].id
//        } else if indexPath.section == 1 {
//            nextVC.productId =  recentArray[indexPath.row].id
//        } else {
//            nextVC.productId = bookmarkArray[indexPath.row].id
//        }
//        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
