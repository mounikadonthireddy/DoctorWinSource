//
//  CarrierJobCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 20/04/22.
//

import UIKit


class CarrierJobCell: UITableViewCell {
    
    var display = 0
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
//        let request = JobApplyRequest(display_status: display, id: sender.tag, preference: Preference.bookmark.rawValue)
//        let resource = JobsResource()
//        resource.saveJob(request: request) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success( let data):
//                    if data.status {
//                        self.bookMarkImage.image = UIImage(named: "fmark")
//                    }
//                    else {
//                        self.bookMarkImage.image = UIImage(named: "mark")
//                    }
//                case .failure: break
//                   //debug
//                }
//               
//            }
//            
//        }
        
    }
    func configureCell(with data: JobModel) {
       self.hospitalName.text =  (data.category ?? "") + " in " + (data.Speciality ?? "") 
        self.specialityName.text = data.name_of_company ?? ""
        
        self.location.text = (data.city ?? "") + "," + (data.state ?? "")
        self.experience.text = (data.min_experince ?? "" ) + "-" + (data.max_experince ?? "") + " yrs of Exp."
        
        save.tag = data.id
        display = data.display_status
        self.salary.text = "\(data.min_salary ?? "") -" + "\(data.max_salary ?? "") /" + (data.monthly_or_anual ?? "")

        self.courseArray = data.eligibility ?? []
        self.courseCollectionView.reloadData()
        if data.bookmark_status == true {
            self.bookMarkImage.image = UIImage(named: "fmark")
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
extension CarrierJobCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courseArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CourseNameCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseNameCell", for: indexPath) as! CourseNameCell

        cell.name.text = courseArray[indexPath.item].name
        cell.name.backgroundColor = UIColor.white
        cell.setCornerRadiusWithBorderColor(radius: 3, color: UIColor.secondaryLabel, borderWidth: 0.5)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (courseArray[indexPath.row].name as NSString).size(withAttributes: nil)
        return CGSize(width: size.width + 40, height: collectionView.bounds.height)
     
    }
    func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //.zero
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
