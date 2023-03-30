//
//  ImageSectionTVCell.swift
//  DoctorWin
//
//  Created by AHP on 26/02/2566 BE.
//

import UIKit

class ImageSectionTVCell: UITableViewCell {
    @IBOutlet weak var answerBtn: UIButton!
    @IBOutlet weak var askBtn: UIButton!
    @IBOutlet weak var courseCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    var courseArray = ["For you", "My Queries", "write articals", "Post news", "Write blogs", "Publish journal"]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        answerBtn.setCornerRadius(radius: 10)
        askBtn.setCornerRadius(radius: 10)
        courseCollectionView.register(UINib.init(nibName: "CourseNameCell", bundle: nil), forCellWithReuseIdentifier: "CourseNameCell")
        self.courseCollectionView.delegate = self
        self.courseCollectionView.dataSource = self
        self.courseCollectionView.backgroundColor = UIColor.white
        
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 10
        collectionViewLayout.minimumInteritemSpacing = 10
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func answerClicked(_ sender: UIButton) {
        askBtn.backgroundColor = UIColor.white
        askBtn.titleLabel?.textColor = #colorLiteral(red: 0, green: 0.381624639, blue: 0.6041520834, alpha: 1)
        answerBtn.backgroundColor = #colorLiteral(red: 0, green: 0.381624639, blue: 0.6041520834, alpha: 1)
        answerBtn.titleLabel?.textColor = UIColor.white
        
    }
    @IBAction func askClicked(_ sender: UIButton) {
        answerBtn.backgroundColor = UIColor.white
        answerBtn.titleLabel?.textColor = #colorLiteral(red: 0, green: 0.381624639, blue: 0.6041520834, alpha: 1)
        askBtn.backgroundColor = #colorLiteral(red: 0, green: 0.381624639, blue: 0.6041520834, alpha: 1)
        askBtn.titleLabel?.textColor = UIColor.white
    }
}
extension ImageSectionTVCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courseArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CourseNameCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseNameCell", for: indexPath) as! CourseNameCell
        
        cell.name.text = courseArray[indexPath.item]
        cell.name.backgroundColor = UIColor.white
        cell.setCornerRadiusWithBorderColor(radius: 3, color: UIColor.secondaryLabel, borderWidth: 0.5)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (courseArray[indexPath.row] as NSString).size(withAttributes: nil)
        return CGSize(width: size.width + 40, height: collectionView.bounds.height)
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) //.zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}
