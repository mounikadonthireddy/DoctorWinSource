//
//  JobRequirementCell.swift
//  DoctorWin
//
//  Created by N517325 on 24/10/21.
//

import UIKit

class JobRequirementCell: UITableViewCell {
    @IBOutlet weak var qualification: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var experience: UILabel!
    @IBOutlet weak var salary: UILabel!
    @IBOutlet weak var vacancy: UILabel!
    @IBOutlet weak var skills: UILabel!
    @IBOutlet weak var accomdation: UILabel!
    @IBOutlet weak var jobType: UILabel!
    @IBOutlet weak var workingHours: UILabel!
    @IBOutlet weak var workingDays: UILabel!
    @IBOutlet weak var doctorRole: UILabel!
    @IBOutlet weak var jobDescription: UILabel!
    @IBOutlet weak var hospitalInfo: UILabel!
    @IBOutlet weak var icu: UILabel!
    @IBOutlet weak var avaialbleDepartments: UILabel!
    @IBOutlet weak var totalBeds: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var jobStatus: UILabel!
    @IBOutlet weak var jobPosted: UILabel!
    @IBOutlet weak var jobDetailImage: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
   

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with data: JobsDataModel) {
        self.title.text = data.title
        self.subTitle.text = "Consult at \(data.subTitle!)"
        self.location.text =  data.location
        self.jobPosted.text = data.date
        self.qualification.text =  data.qualification
        self.gender.text =  data.gender
        self.hospitalInfo.text = data.hospitalType
        if let workingHours = data.workingHours  {
            self.workingHours.text = "\(workingHours) /per day"
        }
    
        self.workingDays.text = "\(data.workingDays) /per week"
       
        if let exp = data.experince {
            self.experience.text =  "\(exp) yrs"

        }
        if let salary = data.salary {
            self.salary.text =  "\(salary)"
        }
        if let vacancy = data.vacancy {
            self.vacancy.text =  "\(vacancy)"
        }
       
        if let icu = data.icu {
            if let nicuc = data.nicuc {
                if let piuce = data.picu {
                    self.icu.text =  "ICU: \(icu)  NICUC:\(nicuc)  PICU:\(piuce)"

                }
             }
        }
        
        
        self.skills.text =  data.skills
        self.accomdation.text =  data.accommodation
        self.jobDescription.text =  data.jobDiscription
        self.jobType.text = data.jobType
        if let totalBed = data.totalBeds {
            self.totalBeds.text = "\(totalBed)"
        }

        if let urlString = data.image {
            let finalUrlString = "http://3.132.212.116:8000" + urlString
            
            self.jobDetailImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
        }
        }
    

}
