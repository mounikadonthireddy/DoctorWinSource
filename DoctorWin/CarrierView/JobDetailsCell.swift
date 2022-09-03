//
//  JobDetailsCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 21/04/22.
//

import UIKit

class JobDetailsCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var expLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var jobTypeLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var accomdationLabel: UILabel!
    @IBOutlet weak var speacilityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCellWith(data: CarrierModel) {
        self.titleLabel.text = (data.designation ?? "") + " " + (data.Speciality ?? "") + " at "  + (data.name_of_company ?? "")
        if data.eligibility.count > 0 {
            self.speacilityLabel.text = data.eligibility.reduce("", { ($0.isEmpty ? "" : $0 + ", ") + $1.name })
        }
        self.salaryLabel.text = "\(data.min_salary ?? "") -" + "\(data.max_salary ?? "") /" + (data.monthly_or_anual ?? "")
        self.expLabel.text = (data.experince ?? "" ) + " yrs of experience"
        self.locationLabel.text = data.location_of_job ?? ""
        if data.accommodation ?? false {
            self.accomdationLabel.text = "Accommodation Provided : Yes"
        } else {
            self.accomdationLabel.text = "Accommodation Provided : No"
        }
        self.jobTypeLabel.text = "Job Type : " + (data.job_type ?? "")
        self.genderLabel.text = "Gender Preference : " + (data.gender ?? "")
        self.descriptionLabel.text = data.description ?? ""
        
    }
    func usersNames(data:[EligibilityModel]) -> String {
        var usersNames = data[0].name
        if data.count > 1 {
            for index in 1..<data.count {
                let separator = index < data.count-1 ? ", " : " & "
                usersNames += separator + data[index].name
            }
        }
        return usersNames
    }
}
