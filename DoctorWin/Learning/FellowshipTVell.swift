//
//  FellowshipTVell.swift
//  DoctorWin
//
//  Created by AHP on 15/01/2566 BE.
//

import UIKit

class FellowshipTVell: UITableViewCell {
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet weak var cVLayout1: UICollectionViewFlowLayout!
    @IBOutlet weak var cVLayout2: UICollectionViewFlowLayout!
    @IBOutlet weak var cvHeight: NSLayoutConstraint!
    var categoryArray : [FellowshipModel] = []
    var courseArray: [LearningCategoryModel] = []
    var selectedText: String = ""
    var selectedCourseArray: [LearningCategoryModel] = []
  
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cVLayout2.scrollDirection = .vertical
        cVLayout2.minimumLineSpacing = 0
        cVLayout2.minimumInteritemSpacing = 0
        cVLayout2.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        
        cVLayout1.scrollDirection = .horizontal
        cVLayout1.minimumLineSpacing = 0
        cVLayout1.minimumInteritemSpacing = 0
        cVLayout1.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView1.register(UINib.init(nibName: "ShopCategoryCell", bundle: nil), forCellWithReuseIdentifier: "ShopCategoryCell")
        collectionView2.register(UINib.init(nibName: "LearningCell", bundle: nil), forCellWithReuseIdentifier: "LearningCell")
    }
    func loadData() {
        self.selectedCourseArray = self.courseArray.filter {
            ($0.subcategory ?? "") == selectedText
        }
        if selectedText == "All" {
            self.selectedCourseArray = self.courseArray
        }
        collectionView1.reloadData()
        collectionView2.reloadData()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func loadData(array: [FellowshipModel], array1:[LearningCategoryModel], selected:String) {
        self.categoryArray = array
       
        self.categoryArray.insert(FellowshipModel(image: "", subcategory: "All"), at: 0)
        self.courseArray = array1
        self.selectedCourseArray = array1.filter {
            $0.subcategory == selected
        }
        if selected == "All" {
            self.selectedCourseArray = self.courseArray
        }
        collectionView1.reloadData()
        collectionView2.reloadData()
        cvHeight.constant = 1000
    }
    
}
extension FellowshipTVell : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionView1 {
            return categoryArray.count
        } else {
            return selectedCourseArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionView1 {
            let cell: ShopCategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCategoryCell", for: indexPath) as! ShopCategoryCell
            cell.bgView.setCornerRadiusWithBorderColor(radius: 5, color: UIColor.secondaryLabel, borderWidth: 0.5)
            
            if selectedText == categoryArray[indexPath.row].subcategory {
                cell.bgView.backgroundColor  = UIColor.red
            } else {
                cell.bgView.backgroundColor  = UIColor.clear
            }
            cell.configureCell(data: categoryArray[indexPath.row],selected: selectedText)
            return cell
            
        }  else {
            let cell: LearningCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LearningCell", for: indexPath) as! LearningCell
            cell.configureCell(data: selectedCourseArray[indexPath.row])
                return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if collectionView == collectionView1 {
            
            
            let size = ((categoryArray[indexPath.row].subcategory ?? "") as NSString).size(withAttributes: nil)
            return CGSize(width: size.width + 70, height: 50)
        }  else {
        let yourWidth = collectionView.bounds.width/2 - 10
        return CGSize(width: yourWidth, height: 320)
        }
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
         if collectionView == collectionView1 {
             selectedText = categoryArray[indexPath.row].subcategory ?? ""
             self.loadData()
            
        }
    }
    
    
}

