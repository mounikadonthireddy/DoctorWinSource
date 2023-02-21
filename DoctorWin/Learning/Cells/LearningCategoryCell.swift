//
//  LearningCategoryCell.swift
//  DoctorWin
//
//  Created by AHP on 12/10/2565 BE.
//

import UIKit
protocol ElearingCellSelected {
    func selectedCellWith(data: CourseModel)
    func openFellowshipView(selected: String)
}
class LearningCategoryCell: UITableViewCell {
    @IBOutlet weak var courseCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var subtitleLable: UILabel!
    var delegate: ElearingCellSelected?
    var coursesArray: [CourseModel] = []
    var fellowshipArray: [FellowshipModel] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        courseCollectionView.register(UINib.init(nibName: "LearningCell", bundle: nil), forCellWithReuseIdentifier: "LearningCell")
        courseCollectionView.register(UINib.init(nibName: "CarrierCategoryCell", bundle: nil), forCellWithReuseIdentifier: "CarrierCategoryCell")
        
         courseCollectionView.register(UINib.init(nibName: "TrendingCourseCell", bundle: nil), forCellWithReuseIdentifier: "TrendingCourseCell")
        self.courseCollectionView.delegate = self
        self.courseCollectionView.dataSource = self
        self.courseCollectionView.backgroundColor = UIColor.clear
        
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func getCourseArray(data: [CourseModel], title: String) {
        coursesArray = data
        self.titleLable.text = title
        courseCollectionView.reloadData()
    }
    func getFellowshipArray(data: [FellowshipModel]) {
        fellowshipArray = data
      
        courseCollectionView.reloadData()
    }
}

extension LearningCategoryCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.titleLable.text == "Fellowships" {
            return fellowshipArray.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if  self.titleLable.text  == "Trending Courses" {
            let cell: TrendingCourseCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCourseCell", for: indexPath) as! TrendingCourseCell
            subtitleLable.text = "The feature is now!"
            subtitleLable.isHidden = false
            cell.configureCell(data: coursesArray[indexPath.section])
            self.backgroundColor = UIColor.groupTableViewBackground
            cell.backgroundColor = UIColor.groupTableViewBackground
            
            return cell
        } else if self.titleLable.text == "Fellowships" {
            let cell: CarrierCategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarrierCategoryCell", for: indexPath) as! CarrierCategoryCell
            print("********************")
            print(fellowshipArray)
            cell.jobTypeName.numberOfLines = 0

            cell.configureCell(with:  fellowshipArray[indexPath.row])
           // cell.dropShadow()
            return cell
        } else {
            subtitleLable.isHidden = true
        let cell: LearningCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LearningCell", for: indexPath) as! LearningCell
        cell.configureCell(data: coursesArray[indexPath.section])
            self.backgroundColor = UIColor.white
            cell.backgroundColor = UIColor.white
            return cell
        }
       
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       // let size = (courseArray[indexPath.row].name as NSString).size(withAttributes: nil)
        if  self.titleLable.text  == "Trending Courses" {
            return CGSize(width: collectionView.bounds.width - 50 , height: collectionView.bounds.height - 30)
        } else {
        return CGSize(width: collectionView.bounds.width / 2.5, height: collectionView.bounds.height)
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
        
        return 10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return coursesArray.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if  self.titleLable.text  == "Trending Courses" {
            delegate?.selectedCellWith(data: coursesArray[indexPath.section])
            
        } else if self.titleLable.text == "Fellowships" {
            delegate?.openFellowshipView(selected: (fellowshipArray[indexPath.row].subcategory ?? ""))
        } else {
            delegate?.selectedCellWith(data: coursesArray[indexPath.section])
        }

    }
    
}
