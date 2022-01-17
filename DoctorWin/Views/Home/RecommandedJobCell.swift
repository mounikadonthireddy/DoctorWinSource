//
//  RecommandedJobCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 11/01/22.
//

import UIKit

class RecommandedJobCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var postedDate: UILabel!
   
    @IBOutlet weak var salary: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var specialityName: UILabel!
    @IBOutlet weak var hospitalName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.clipsToBounds = true
    
        bgView.setCornerRadiusWithBorderColor(radius: 10, color: UIColor(rgb: 0xE6E6E6), borderWidth: 0.5)

    }
   
    func configureCell(with data: JobsDataModel) {
        self.hospitalName.text =  data.designation! + " in " + data.companyName!
        self.hospitalName.numberOfLines = 2
        self.hospitalName.lineBreakMode = .byWordWrapping
        self.specialityName.text = data.course
        self.location.text = data.location
        
        
        
        if let salary = data.salary {
            self.salary.text = "\(salary) /" + data.salaryType!
        }
        if data.bookmarkStatus ?? false {
            //self.save.setImage(UIImage(named: "fstar"), for: .normal)
        } else {
            //self.save.setImage(UIImage(named: "star"), for: .normal)

        }

            
            if let date = data.date {
           let days = calculateDaysfrom(date: date)
                self.postedDate.text = "\(days)d ago"
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

