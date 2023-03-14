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
            interfaceSegmented.selectorViewColor = .black
            interfaceSegmented.selectorTextColor = .black
            interfaceSegmented.textColor = .lightGray
            //interfaceSegmented.delegate = self
        }
    }
    var imageArray: [GenderImageModel] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        interfaceSegmented.delegate = self
        joinBtn.setCornerRadius(radius: Float(joinBtn.frame.height)/2)
        personImage.setCornerRadius(radius: Float(personImage.frame.height)/2)

        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        bgView.setCornerRadiusWithBorderColor(radius: 8, color: UIColor.lightGray, borderWidth: 0.5)
        
        personsCV.register(UINib.init(nibName: "PersonImageCell", bundle: nil), forCellWithReuseIdentifier: "PersonImageCell")
        
    }
    
    func configureView(data: ProfileDataModel) {
        nameLbl.text = "\(data.name ?? "")"
        specialityLbl.text = (data.speciality ?? "") + " at \(data.current_job_location ?? "" )"
        if let urlString = data.image {
            
            self.personImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
        }
//        if let image = data.cov {
//            self.bgImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + image), placeholderImage: UIImage(named: "loginBg"))
//        }
        // interfaceSegmented.delegate = self
        
    }
    func configureView(data: GroupProfileModel) {
        nameLbl.text = "\(data.name ?? "")"
        specialityLbl.text = data.description ?? ""
        if let count = data.total_joined {
            followBtn.setTitle("\(count) Participants", for: .normal)
        }
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
           // adminViewHeight.constant = 20
        }
        else if data.joined_status == false {
            joinBtn.setTitle("Join", for: .normal)
            //adminViewHeight.constant = 0
        } else {
            joinBtn.setTitle("Joined", for: .normal)
            joinBtn.backgroundColor = UIColor(rgb: 0xEEEEEE)
            joinBtn.isEnabled = false
            //adminViewHeight.constant = 20
        }
        if let urlString = data.image {
            
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
       // return imageArray.count
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: PersonImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonImageCell", for: indexPath) as! PersonImageCell
        cell.configure(data: imageArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 25, height: 25)
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
