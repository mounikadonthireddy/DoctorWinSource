//
//  CarrierCell.swift
//  DoctorWin
//
//  Created by N517325 on 22/10/21.
//

import UIKit

class CarrierCell: UITableViewCell {
    @IBOutlet weak var collegeName: UILabel!
    @IBOutlet weak var universityName: UILabel!
    @IBOutlet weak var annualFee: UILabel!
    @IBOutlet weak var totalSeats: UILabel!
    @IBOutlet weak var exams: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var universityImage: UIImageView!
    @IBOutlet weak var nationalRank: UILabel!
    @IBOutlet weak var courseCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    var courseArray: [CourseModel] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        courseCollectionView.register(UINib.init(nibName: "CourseNameCell", bundle: nil), forCellWithReuseIdentifier: "CourseNameCell")
        self.courseCollectionView.delegate = self
        self.courseCollectionView.dataSource = self
        self.courseCollectionView.backgroundColor = UIColor.systemGroupedBackground
        
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        universityImage.setCornerRadiusWithBorderColor(radius: 5, color: UIColor.lightGray, borderWidth: 0.4)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(with data: CollegeDataModel) {
        self.courseCollectionView.delegate = self
        self.courseCollectionView.dataSource = self
        if let fee = data.annualFree {
            let rupeeSymbol = "\u{20B9}"
        self.annualFee.text = "\(rupeeSymbol) \(fee)"
        }
        self.courseArray = data.courseArray
        self.courseCollectionView.reloadData()
        self.universityName.text = data.universityName
        self.collegeName.text = data.collegeName
        if let seats =  data.seats {
            self.totalSeats.text = "\(seats) Students per year"
        }
        
        if let rank = data.nationalRanking {
            self.nationalRank.text = "\(rank)"
        }
        if let urlString = data.image {
            let finalUrlString = ApiEndpoints.baseUrl + urlString
            self.universityImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))

        }
        if let city = data.city {
            if let district = data.district {
                if let state = data.state {
                    if let pincode = data.pincode {
                        self.location.text = "\(city), \(district), \(state), \(pincode)"
                    }
                    }
                }
            }
        }
       
    
}

extension CarrierCell : UICollectionViewDelegate, UICollectionViewDataSource {
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
