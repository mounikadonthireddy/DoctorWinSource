//
//  InfoCell.swift
//  DoctorWin
//
//  Created by N517325 on 22/10/21.
//

import UIKit

class InfoCell: UITableViewCell {
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var contactNumber: UILabel!
    @IBOutlet weak var emailID: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var workingCompany: UILabel!
    @IBOutlet weak var currentInstitution: UILabel!
    @IBOutlet weak var graduation: UILabel!
    @IBOutlet weak var postGraduation: UILabel!
    @IBOutlet weak var postGraduationInstitute: UILabel!
    @IBOutlet weak var graduationInstitute: UILabel!
    @IBOutlet weak var personalEdit: UIButton!
    @IBOutlet weak var professionalEdit: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func cellConfigureWith(data: ProfileDataModel, section: Int) {
        self.graduation.text = data.ug ?? ""
        self.postGraduation.text = data.pg ?? ""
        self.postGraduationInstitute.text = data.pg_institute_name ?? ""
        self.graduationInstitute.text = data.ug_institute_name ?? ""
        self.workingCompany.text = data.current_department ?? ""
        self.currentInstitution.text = data.current_institute ?? ""
        
        self.contactNumber.text = data.phone_number ?? ""
        self.emailID.text = data.email ?? ""
        self.gender.text = data.gender ?? ""
        self.dob.text = data.dob ?? ""
        self.location.text = data.current_job_location ?? ""
        self.language.text = data.language
        
        
    }
    
}
