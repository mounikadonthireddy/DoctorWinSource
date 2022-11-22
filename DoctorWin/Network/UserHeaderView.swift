//
//  UserHeaderView.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 09/05/22.
//

import UIKit

class UserHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var inviteBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var joinBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var specialityLbl: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var personsCV: UICollectionView!
    @IBOutlet weak var personsCVHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var adminViewHeight: NSLayoutConstraint!
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: [ "Post","Cases", "Questions", "Answers"])
            interfaceSegmented.selectorViewColor = .blue
            interfaceSegmented.selectorTextColor = .blue
            //interfaceSegmented.delegate = self
        }
    }
    var imageArray: [GenderImageModel] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        interfaceSegmented.delegate = self
        joinBtn.setCornerRadius(radius: 5)
        inviteBtn.setCornerRadius(radius: 5)
        shareBtn.setCornerRadius(radius: 5)
        self.personImage.setCornerRadiusWithBorderColor(radius: 10, color: UIColor.white, borderWidth: 4)
      
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        bgView.setCornerRadiusWithBorderColor(radius: 8, color: UIColor.lightGray, borderWidth: 0.5)
        
        personsCV.register(UINib.init(nibName: "PersonImageCell", bundle: nil), forCellWithReuseIdentifier: "PersonImageCell")
        
    }
    
    func configureView(data: ProfileDataModel) {
        nameLbl.text = "\(data.profileName ?? "")"
        specialityLbl.text = (data.speciality ?? "") + " at \(data.currentLocation ?? "" )"
        if let urlString = data.profileImage {
            
            self.personImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
        }
//        if let image = data.cov {
//            self.bgImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + image), placeholderImage: UIImage(named: "loginBg"))
//        }
        // interfaceSegmented.delegate = self
        
    }
    func configureView(data: GroupProfileModel) {
        nameLbl.text = "\(data.name_of_group ?? "")"
        specialityLbl.text = data.description ?? ""
        followBtn.setTitle("\(data.number_of_joined ?? 0) Participants", for: .normal)
        specialityLbl.text = data.description ?? ""
        imageArray = data.group_joined_image ?? []
        if imageArray.count == 0 {
            personsCVHeight.constant = 0
        } else {
            personsCVHeight.constant = 30
        }
        personsCV.reloadData()
        if data.admin_status == true {
            joinBtn.setTitle("Edit", for: .normal)
            adminViewHeight.constant = 20
        }
        else if data.join_status == false {
            joinBtn.setTitle("Join", for: .normal)
            adminViewHeight.constant = 0
        } else {
            joinBtn.setTitle("Joined", for: .normal)
            joinBtn.backgroundColor = UIColor.lightGray
            joinBtn.isEnabled = false
            adminViewHeight.constant = 20
        }
        if let urlString = data.profileImage {
            
            self.personImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
        }
        if let image = data.cover_image {
            self.bgImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + image), placeholderImage: UIImage(named: "loginBg"))
        }
        if let image = data.image {
            self.personImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + image), placeholderImage: UIImage(named: "loginBg"))
        }
        // interfaceSegmented.delegate = self
        
    }
    
}
extension UserHeaderView: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        
    }
    
    
}
extension UserHeaderView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: PersonImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonImageCell", for: indexPath) as! PersonImageCell
        cell.configure(data: imageArray[indexPath.row])
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: 20, height: 20)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2) //.zero
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
    
    
    
}
