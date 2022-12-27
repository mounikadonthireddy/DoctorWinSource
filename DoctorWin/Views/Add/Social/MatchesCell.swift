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
    @IBOutlet weak var interestView: UIView!
    @IBOutlet weak var interestViewHeight: NSLayoutConstraint!
    @IBOutlet weak var interestViewCV: UICollectionView!
    @IBOutlet weak var interestViewCVLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var lookingView: UIView!
    @IBOutlet weak var lookingLabel: UILabel!
    @IBOutlet weak var lookingViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imagesViewCVLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var imagesView: UIView!
    @IBOutlet weak var imagesViewHeight: NSLayoutConstraint!
    @IBOutlet weak var image3Height: NSLayoutConstraint!
    @IBOutlet weak var image2Height: NSLayoutConstraint!
    @IBOutlet weak var imagesViewCV: UICollectionView!
    var profileInfoArray: [ProfileCharModel] = []
    var profileInterestArray: [ProfileInterestModel] = []
    var profileImagesArray: [GenderImageModel] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        aboutMeImage.setCornerRadiusWithBorderColor(radius: 10, color: UIColor.lightGray, borderWidth: 0.5)
        lookingLabel.dropShadow()
        lookingLabel.setCornerRadiusWithBorderColor(radius: 10, color: UIColor.lightGray, borderWidth: 0.5)
        setUpInfoView()
        setUpInterestView()
        setUpImagesView()
    }
    func setUpInfoView() {
        infoViewCV.register(UINib.init(nibName: "MatchesInfoCell", bundle: nil), forCellWithReuseIdentifier: "MatchesInfoCell")
        
        infoViewCVLayout.scrollDirection = .vertical
        infoViewCVLayout.minimumLineSpacing = 0
        infoViewCVLayout.minimumInteritemSpacing = 0
        infoViewCVLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func setUpInterestView() {
        interestViewCV.register(UINib.init(nibName: "CourseNameCell", bundle: nil), forCellWithReuseIdentifier: "CourseNameCell")
        
        interestViewCVLayout.scrollDirection = .vertical
        interestViewCVLayout.minimumLineSpacing = 0
        interestViewCVLayout.minimumInteritemSpacing = 0
        interestViewCVLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func setUpImagesView() {
        imagesViewCV.register(UINib.init(nibName: "ConnectImageCell", bundle: nil), forCellWithReuseIdentifier: "ConnectImageCell")
        
        imagesViewCVLayout.scrollDirection = .vertical
        imagesViewCVLayout.minimumLineSpacing = 0
        imagesViewCVLayout.minimumInteritemSpacing = 0
        imagesViewCVLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
        if let aboutMe = data.looking_for {
            self.lookingLabel.text = "   " + aboutMe
        } else {
            self.lookingViewHeight.constant = 0
            self.lookingView.isHidden = true
        }
        if let infoArray = data.profile {
            profileInfoArray = infoArray
            var infoHeight = 80
            var rowCount = 0
            if profileInfoArray.count % 2 != 0 {
                rowCount = profileInfoArray.count/2 + 1
            } else {
                rowCount = profileInfoArray.count/2
            }
            infoHeight = infoHeight * rowCount
            infoViewHeight.constant = CGFloat(infoHeight + 75)
            infoViewCV.reloadData()
        } else {
            infoView.isHidden = true
            infoViewHeight.constant = 0
        }
        if let interestArray = data.interest {
            profileInterestArray = interestArray
            var infoHeight = 60
            var rowCount = 0
            if profileInterestArray.count % 2 != 0 {
                rowCount = profileInterestArray.count/2 + 1
            } else {
                rowCount = profileInterestArray.count/2
            }
            infoHeight = infoHeight * rowCount
            interestViewHeight.constant = CGFloat(infoHeight +  75)
            interestViewCV.reloadData()
        } else {
            interestView.isHidden = true
            interestViewHeight.constant = 0
        }
        
        if let imagesArray = data.image {
            profileImagesArray = imagesArray
            var infoHeight = 400
            infoHeight = infoHeight * profileImagesArray.count
            imagesViewHeight.constant = CGFloat(infoHeight)
            imagesViewCV.reloadData()
        } else {
            imagesView.isHidden = true
            imagesViewHeight.constant = 0
        }
        
        if let urlString1 = data.image1 {
            self.image1.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString1), placeholderImage: UIImage(named: "loginBg"))
        }
        if let urlString2 = data.image2 {
            self.image2.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString2), placeholderImage: UIImage(named: "loginBg"))
            image2Height.constant = 400
        } else {
            image2Height.constant = 0
        }
        if let urlString3 = data.image3 {
            self.image3.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString3), placeholderImage: UIImage(named: "loginBg"))
            image3Height.constant = 400
        } else {
            image3Height.constant = 0
        }
        
    }
    
}
extension MatchesCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == infoViewCV {
            return profileInfoArray.count
        } else if collectionView == interestViewCV {
            return profileInterestArray.count
        } else if collectionView == imagesViewCV {
            return profileImagesArray.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == infoViewCV {
            let cell: MatchesInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MatchesInfoCell", for: indexPath) as! MatchesInfoCell
            cell.configureCell(data: profileInfoArray[indexPath.row])
            cell.dropShadow()
            return cell
        } else if collectionView == interestViewCV {
            let cell: CourseNameCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseNameCell", for: indexPath) as! CourseNameCell
            
            cell.name.text = profileInterestArray[indexPath.item].name
            cell.name.backgroundColor = UIColor.white
            cell.dropShadow()
            return cell
        } else {
            let cell: ConnectImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConnectImageCell", for: indexPath) as! ConnectImageCell
            cell.configureCell(data: profileImagesArray[indexPath.row])
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == interestViewCV {
           
            if let value = profileInterestArray[indexPath.row].name {
               let size = (value as NSString).size(withAttributes: nil)
                return CGSize(width: size.width + 70, height: 55)
            } else {
                return CGSize(width: 50, height: 55)
            }
           
        } else if collectionView == infoViewCV {
            let yourWidth = collectionView.bounds.width/2 - 10
            return CGSize(width: yourWidth, height: 70)
        } else {
            let yourWidth = collectionView.bounds.width
            return CGSize(width: yourWidth, height: 400)
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
}
