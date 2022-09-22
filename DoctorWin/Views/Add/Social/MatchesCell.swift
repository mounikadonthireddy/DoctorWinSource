//
//  MatchesCell.swift
//  DoctorWin
//
//  Created by AHP on 19/09/2565 BE.
//

import UIKit

class MatchesCell: UITableViewCell {
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var aboutMeView: UIView!
    @IBOutlet weak var aboutMeImage: UIImageView!
    @IBOutlet weak var aboutMeViewHeight: NSLayoutConstraint!
    @IBOutlet weak var aboutMeLabel: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoViewHeight: NSLayoutConstraint!
    @IBOutlet weak var infoViewCV: UICollectionView!
    @IBOutlet weak var infoViewCVLayout: UICollectionViewFlowLayout!
    var profileInfoArray: [ProfileCharModel] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        aboutMeImage.setCornerRadiusWithBorderColor(radius: 10, color: UIColor.lightGray, borderWidth: 0.5)
       setUpInfoView()
    }
    func setUpInfoView() {
        infoViewCV.register(UINib.init(nibName: "MatchesInfoCell", bundle: nil), forCellWithReuseIdentifier: "MatchesInfoCell")
     
        infoViewCVLayout.scrollDirection = .vertical
        infoViewCVLayout.minimumLineSpacing = 0
        infoViewCVLayout.minimumInteritemSpacing = 0
        infoViewCVLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCellWith(data: MatchesModel) {
        
        if let aboutMe = data.intro {
            self.aboutMeLabel.text = aboutMe
        } else {
            self.aboutMeViewHeight.constant = 0
            self.aboutMeView.isHidden = true
        }
        if let infoArray = data.profile {
            profileInfoArray = infoArray
            infoViewCV.reloadData()
        }
        
        if let urlString1 = data.image1 {
            self.image1.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString1), placeholderImage: UIImage(named: "loginBg"))
        }
        if let urlString2 = data.image2 {
            self.image2.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString2), placeholderImage: UIImage(named: "loginBg"))
        }
        if let urlString3 = data.image3 {
            self.image3.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString3), placeholderImage: UIImage(named: "loginBg"))
        }
        
    }
    
}
extension MatchesCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == infoViewCV {
            return profileInfoArray.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       // if collectionView == infoViewCV {
            let cell: MatchesInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MatchesInfoCell", for: indexPath) as! MatchesInfoCell
            cell.configureCell(data: profileInfoArray[indexPath.row])
            return cell
        //}
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

//        if collectionView == categoryCollectionView {
//            let size = (categoryArray[indexPath.row].name as NSString).size(withAttributes: nil)
//            return CGSize(width: size.width + 50, height: 35)
//        } else {
        let yourWidth = collectionView.bounds.width/2 - 10
        return CGSize(width: yourWidth, height: 195)
//        }
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
}
