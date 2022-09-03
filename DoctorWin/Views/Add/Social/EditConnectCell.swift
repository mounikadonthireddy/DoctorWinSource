//
//  EditConnectCell.swift
//  DoctorWin
//
//  Created by AHP on 07/07/2565 BE.
//

import UIKit
import iOSDropDown

class EditConnectCell: UITableViewCell {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var bioTF: UITextField!
    @IBOutlet weak var livingTF: UITextField!
    @IBOutlet weak var qualificationTF: DropDown!
    @IBOutlet weak var professionTF: DropDown!
    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var genderTF: DropDown!
    @IBOutlet weak var interest: UIButton!
    @IBOutlet weak var courseCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var InterestCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout1: UICollectionViewFlowLayout!
    var imageArray: [GenderImageModel] = []
    var interestArray: [ProfileInterestModel] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        courseCollectionView.register(UINib.init(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        // Do any additional setup after loading the view.
        InterestCollectionView.register(UINib.init(nibName: "CourseNameCell", bundle: nil), forCellWithReuseIdentifier: "CourseNameCell")
        
        self.courseCollectionView.delegate = self
        self.courseCollectionView.dataSource = self
        self.courseCollectionView.backgroundColor = UIColor.white
        
        self.InterestCollectionView.delegate = self
        self.InterestCollectionView.dataSource = self
        self.InterestCollectionView.backgroundColor = UIColor.white
        
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionViewLayout1.scrollDirection = .vertical
        collectionViewLayout1.minimumLineSpacing = 0
        collectionViewLayout1.minimumInteritemSpacing = 0
        collectionViewLayout1.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureCell(data: ConnectProfileModel) {
        nameTF.text = data.name
        bioTF.text = data.intro
        livingTF.text = data.living
        qualificationTF.text = data.qualification
        professionTF.text = data.profession
        dobTF.text = "\(data.age)"
        genderTF.text = data.gender
        interestArray = data.interest?.interest ?? []
        imageArray = data.image
        InterestCollectionView.reloadData()
        courseCollectionView.reloadData()
    }
    
}
extension EditConnectCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == InterestCollectionView {
            return interestArray.count
        } else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == InterestCollectionView {
            let cell: CourseNameCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseNameCell", for: indexPath) as! CourseNameCell
            
            cell.name.text = interestArray[indexPath.item].interest
            cell.backgroundColor = UIColor.white
            cell.setCornerRadiusWithBorderColor(radius: 17.5, color: UIColor.secondaryLabel, borderWidth: 0.5)
            return cell
        } else  {
        let cell: ImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
            if imageArray.count > 0 {
                cell.imageBtn.sd_currentImageURL
            }
    
        return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == InterestCollectionView {
            let size = (interestArray[indexPath.row].interest as NSString).size(withAttributes: nil)
            return CGSize(width: size.width + 40, height: 30)
        } else {
        let yourWidth = CGFloat(90)
        return CGSize(width: yourWidth, height: collectionView.bounds.height)
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2) //.zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 2
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
