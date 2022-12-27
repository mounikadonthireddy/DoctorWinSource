//
//  ShopCategoryViewController.swift
//  DoctorWin
//
//  Created by AHP on 30/06/2565 BE.
//

import UIKit

class ShopCategoryViewController: ViewController {
    var shopArray : [ShopModel] = []
    var shopVM = ShopViewModel()

    @IBOutlet weak var shopCollectionView: UICollectionView!
    @IBOutlet weak var shopCVLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var categoryName: UILabel!
    var categorySelected = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shopCollectionView.register(UINib.init(nibName: "ShopCell", bundle: nil), forCellWithReuseIdentifier: "ShopCell")
        shopCVLayout.scrollDirection = .vertical
        shopCVLayout.minimumLineSpacing = 0
        shopCVLayout.minimumInteritemSpacing = 0
        shopCVLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        categoryName.text = categorySelected
        
        // Do any additional setup after loading the view.
        shopVM.delegate = self
        // Do any additional setup after loading the view.
        loadShopData()
    }
    func loadShopData() {
       showLoader()
        shopVM.getShopData(userID: User.shared.userID, category: categorySelected)
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension ShopCategoryViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ShopCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCell", for: indexPath) as! ShopCell
        cell.configureCell(data: shopArray[indexPath.row])
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/2 - 10
        return CGSize(width: yourWidth, height: 195)
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) //.zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 5
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let str = UIStoryboard(name: "Shop", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "ShopDetailsViewController") as! ShopDetailsViewController
        nextVC.productId = shopArray[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    
}
extension ShopCategoryViewController: ShopDelegate {
    func didReciveShopBannerData(response: [ImageBannerModel]?, error: String?) {
        
    }
    
    func didReciveShopData(response: ShopResponseModel?, error: String?) {
        self.dismiss()
        if let data = response {
            shopArray = data.shopResponse ?? []
        }
        shopCollectionView.reloadData()
    }
    
    func didReciveShopCategoryData(response: [ShopCategoryModel]?, error: String?) {
     
        
    }
    
    
}

