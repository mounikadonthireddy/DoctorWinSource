//
//  CourseCategoryCell.swift
//  DoctorWin
//
//  Created by AHP on 13/10/2565 BE.
//

import UIKit
protocol CategeryCellSelectedDelegate {
    func selectedWith(data: CoursesCategoryModel)
    func openFellowshipView1(selected: String)
}
class CourseCategoryCell: UITableViewCell {
  
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var subtitleLable: UILabel!
    @IBOutlet weak var viewBtn: UIButton!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var courseCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    var delegate: CategeryCellSelectedDelegate?
    var courseArray: [CoursesCategoryModel] = []
    var fellowshipArray: [FellowshipModel] = []
    var index = -1
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        courseCollectionView.register(UINib.init(nibName: "CarrierCategoryCell", bundle: nil), forCellWithReuseIdentifier: "CarrierCategoryCell")
        self.courseCollectionView.delegate = self
        self.courseCollectionView.dataSource = self
        self.courseCollectionView.backgroundColor = UIColor.white
        
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    func configureCell(data: [CoursesCategoryModel], index:Int) {
        courseArray = data
        self.index = index
        height.constant = 140
        self.titleLable.text = ""
        self.subtitleLable.text = ""
        viewBtn.isHidden = true
        courseCollectionView.reloadData()
    }
    func getFellowshipArray(data: [FellowshipModel], index: Int) {
        fellowshipArray = data
        height.constant = 180
        self.titleLable.text = "Fellowships"
        self.subtitleLable.text = "Step out or step in!"
        self.index = index
        viewBtn.isHidden = false
        courseCollectionView.reloadData()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
extension CourseCategoryCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if index == 0 {
            return courseArray.count
        } else if index == 4 {
            return fellowshipArray.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CarrierCategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarrierCategoryCell", for: indexPath) as! CarrierCategoryCell
        
        cell.jobTypeName.numberOfLines = 0
        if index == 0 {
        cell.configureCell(with:  courseArray[indexPath.row])
        } else if index == 4 {
            cell.configureCell(with: fellowshipArray[indexPath.row])
        }
       // cell.dropShadow()
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if index == 0 {
            return CGSize(width: 100, height: 140)
        } else {
            return CGSize(width: 100, height: 80)
        }
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
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if index == 4 {
            delegate?.openFellowshipView1(selected: (fellowshipArray[indexPath.row].subcategory ?? ""))
        } else if index == 0 {
            delegate?.selectedWith(data: courseArray[indexPath.row])
            }
    }
}
