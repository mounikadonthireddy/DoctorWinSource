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
    @IBOutlet weak var joinBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var specialityLbl: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var postView: UIView!
    @IBOutlet weak var postViewHeight: NSLayoutConstraint!
    @IBOutlet weak var postPersonImage: UIImageView!
    @IBOutlet weak var personsCV: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var postBtn: UIButton!
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
        joinBtn.setCornerRadius(radius: 15)
        postBtn.setCornerRadius(radius: Float(postBtn.frame.height)/2)
        personImage.setCornerRadius(radius: Float(personImage.frame.width)/2)
        postPersonImage.setCornerRadius(radius: Float(postPersonImage.frame.width)/2)
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        
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
        personsCV.reloadData()
        if data.admin_status == true {
            joinBtn.setTitle("Edit", for: .normal)
        }
        else if data.join_status == false {
            joinBtn.setTitle("Join", for: .normal)
            postViewHeight.constant = 0
            postView.isHidden = true
        } else {
            joinBtn.setTitle("Joined", for: .normal)
            joinBtn.backgroundColor = UIColor.lightGray
            joinBtn.isEnabled = false
            postView.isHidden = false
            postViewHeight.constant = 70
        }
        if let urlString = data.profileImage {
            
            self.personImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
        }
        if let image = data.cover_image {
            self.bgImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + image), placeholderImage: UIImage(named: "loginBg"))
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
