//
//  CarrierJobCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 20/04/22.
//

import UIKit

class CarrierJobCell: UITableViewCell {
    
    
    @IBOutlet weak var hospitalImage: UIImageView!
    @IBOutlet weak var experience: UILabel!
    @IBOutlet weak var salary: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var specialityName: UILabel!
    @IBOutlet weak var hospitalName: UILabel!
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var bookMarkImage: UIImageView!
    @IBOutlet weak var courseCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    var courseArray: [EligibilityModel] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        hospitalImage.setCornerRadius(radius: 8)
        courseCollectionView.register(UINib.init(nibName: "CourseNameCell", bundle: nil), forCellWithReuseIdentifier: "CourseNameCell")
        self.courseCollectionView.delegate = self
        self.courseCollectionView.dataSource = self
        self.courseCollectionView.backgroundColor = UIColor.white
        
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func chatClicked(_ sender: Any) {
    }
    
    
    @IBAction func saveClicked(_ sender: UIButton) {
        let request = JobApplyRequest(user_id: User.shared.userID, job_id: "\(sender.tag)")
        let resource = JobsResource()
        resource.saveJob(request: request) { result in
            DispatchQueue.main.async {
                if result.status  {
                    self.bookMarkImage.image = UIImage(named: "fstar")
                } else {
                    self.bookMarkImage.image = UIImage(named: "star")
                }
            }
            
        }
        
    }
    func configureCell(with data: CarrierModel) {
        self.hospitalName.text =  data.designation + " in " + data.Speciality
        
        self.specialityName.text = data.name
        
        self.location.text = data.location
        self.experience.text = "\(data.experince)" + " yrs Experience"
        
        
        save.tag = data.id
        self.salary.text = "\(data.salary) /" + data.monthly_or_anual
        
        
        if let urlString = data.hospital_image {
            
            self.hospitalImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "loginBg"))
        }
        self.courseArray = data.eligibility
        self.courseCollectionView.reloadData()
        if data.bookmark ?? false {
            self.bookMarkImage.image = UIImage(named: "fstar")
        }
    }
    
    func calculateDaysfrom(date: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS"
        let formatedStartDate = dateFormatter.date(from: date)
        let currentDate = Date()
        _ = Set<Calendar.Component>([ .day])
        let differenceOfDate =  Calendar.current.dateComponents([.day], from: formatedStartDate!, to: currentDate).day!
        return differenceOfDate
    }
}
extension CarrierJobCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courseArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CourseNameCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseNameCell", for: indexPath) as! CourseNameCell

        cell.name.text = courseArray[indexPath.item].name
        cell.name.backgroundColor = UIColor.white
//        cell.backgroundColor = UIColor.white
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let yourWidth = CGFloat(40)
        return CGSize(width: yourWidth, height: collectionView.bounds.height)

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
    
    
}
