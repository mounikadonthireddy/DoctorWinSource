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
    @IBOutlet weak var heightTF: DropDown!
    @IBOutlet weak var lookingTF: UITextField!
    @IBOutlet weak var schoolTF: UITextField!
    @IBOutlet weak var incomeTF: UITextField!
    @IBOutlet weak var personalityTF: DropDown!
    @IBOutlet weak var occupationTF: DropDown!
    @IBOutlet weak var zodiacTF: DropDown!
    @IBOutlet weak var petsTF: DropDown!
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
        dobTF.text = "\(data.age) yrs"
        genderTF.text = data.gender
        heightTF.text = data.height ?? ""
        bioTF.text = data.intro
        lookingTF.text = data.looking_for ?? ""
        livingTF.text = data.living_in ?? ""
        schoolTF.text = data.institute ?? ""
        personalityTF.text = data.orientation ?? ""
        qualificationTF.text = data.qualification
        professionTF.text = data.profession
        incomeTF.text = data.income
        zodiacTF.text = data.zodiacs
        petsTF.text = data.pets
      
        interestArray = data.interest ?? []
        imageArray = data.genderimage ?? []
        zodiacTF.optionArray = ["Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo", "Libra", "Scorpio","Sagittarius", "Capucorn", "Aquarius", "Pisces"]
        petsTF.optionArray = ["Cat" ,"Dog", "Reptile", "Amphibian" , "Dont have, but love", "Pet free", "App the pets"]
        personalityTF.optionArray = ["Introvert", "Extrovert", "Ambvert"]
        heightTF.optionArray = ["5'0","5'1","5'2","5'3","5'4","5'5","5'6","5'7","5'8","5'9","6'0","6'1","6'2","6'3"]
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
            cell.backgroundColor = UIColor.blue
            cell.setCornerRadiusWithBorderColor(radius: 17.5, color: UIColor.secondaryLabel, borderWidth: 0.5)
         
            return cell
        } else  {
        let cell: ImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
            if imageArray.count > 0 {
               // cell.imageBtn.sd_currentImageURL
            }
    
        return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == InterestCollectionView {
            let size = (interestArray[indexPath.row].interest as NSString).size(withAttributes: nil)
            return CGSize(width: size.width + 60, height: 30)
        } else {
        let yourWidth = CGFloat(90)
        return CGSize(width: yourWidth, height: collectionView.bounds.height)
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4) //.zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
}
