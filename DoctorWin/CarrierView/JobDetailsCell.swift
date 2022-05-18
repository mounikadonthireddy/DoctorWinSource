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
    
    func configureCellWith(data: CarrierJobDetailsModel) {
        self.descriptionLabel.text = data.discription ?? ""
        self.speacilityLabel.text = data.Speciality ?? ""
        self.accomdationLabel.text = "Accommodation Provided :" + (data.accommodation ?? "")
        self.genderLabel.text = "Gender Preference :" + (data.gender ?? "")
        self.jobTypeLabel.text = "Job Type :" + (data.job_type ?? "")
        self.expLabel.text = (data.experince ?? "" ) + " yrs of experience"
        self.salaryLabel.text = (data.salary ?? "" ) + " per " + (data.monthly_or_anual ?? "")

        self.locationLabel.text = data.location ?? ""
        self.titleLabel.text = (data.designation ?? "") + (data.Speciality ?? "") + " at "  + (data.name ?? "")

    }
}
