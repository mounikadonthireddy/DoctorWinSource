//
//  CollegeDetailsCell.swift
//  DoctorWin
//
//  Created by N517325 on 28/10/21.
//

import UIKit

class CollegeDetailsCell: UITableViewCell {
    @IBOutlet weak var collegeName: UILabel!
    @IBOutlet weak var universityName: UILabel!
    @IBOutlet weak var nationalRank: UILabel!
    @IBOutlet weak var stateRank: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var fee: UILabel!
    @IBOutlet weak var totalSeats: UILabel!
    @IBOutlet weak var totalStaff: UILabel!
    @IBOutlet weak var cutOff: UILabel!
    @IBOutlet weak var lastYear: UILabel!
    @IBOutlet weak var autonomous: UILabel!
    @IBOutlet weak var estdYear: UILabel!
    @IBOutlet weak var exams: UILabel!
    @IBOutlet weak var aboutUs: UILabel!
    @IBOutlet weak var courseCollectionView: UICollectionView!
    var courseArray : [CourseModel] = []
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!

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
    
    func configureCollegeCell(With dataModel: CollegeDataModel) {
        self.collegeName.text = dataModel.collegeName
        self.universityName.text = dataModel.universityName
        if let rank = dataModel.nationalRanking {
            self.nationalRank.text = "\(rank)"
        }
        if let nationalRank = dataModel.nationalRanking {
            self.nationalRank.text = "\(nationalRank)"
        }
        if let stateRank = dataModel.stateRank {
            self.stateRank.text = "\(stateRank)"
        }
        if let fee = dataModel.annualFree {
            self.fee.text = "\(fee) Annual Fee"
        }
        self.aboutUs.text = dataModel.aboutUs
        if let seats = dataModel.seats {
            self.totalSeats.text = "\(seats) Student per year"
        }
        if let staff = dataModel.totalStaff {
            self.totalStaff.text = "\(staff) Lectures"
        }
        if let lastYearRank = dataModel.lastYearRank {
            self.lastYear.text = "\(lastYearRank) cut of ranks"
        }
        if let cutoff = dataModel.cutoffMarks {
            self.cutOff.text = "\(cutoff) Lectures"
        }
        if let city = dataModel.city {
            if let district = dataModel.district {
                if let state = dataModel.state {
                    if let pincode = dataModel.pincode {
                        self.address.text = "\(city), \(district), \(state), \(pincode)"
                    }
                    }
                }
            }
        
        self.autonomous.text = dataModel.autonomus
        self.courseArray = dataModel.courseArray
        self.courseCollectionView.reloadData()
        var exams : String = ""
        for data in dataModel.examinationArray {
            if let name = data.name {
                exams = exams + name
                exams += "   "
            }
        }
        self.exams.text =  exams

    }
    
}
extension CollegeDetailsCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courseArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CourseNameCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseNameCell", for: indexPath) as! CourseNameCell

        cell.name.text = courseArray[indexPath.item].name
        cell.name.backgroundColor = UIColor.white
        cell.backgroundColor = UIColor.white
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
