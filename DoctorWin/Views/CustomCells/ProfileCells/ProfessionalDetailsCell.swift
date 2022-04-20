//
//  ProfessionalDetailsCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 11/01/22.
//

import UIKit

class ProfessionalDetailsCell: UITableViewCell {
    @IBOutlet weak var cellTitle: UILabel!
   
    @IBOutlet weak var workingCompany: UILabel!
    @IBOutlet weak var currentInstitution: UILabel!
    @IBOutlet weak var graduation: UILabel!
    @IBOutlet weak var postGraduation: UILabel!
    @IBOutlet weak var postGraduationInstitute: UILabel!
    @IBOutlet weak var graduationInstitute: UILabel!
    @IBOutlet weak var professionalEdit: UIButton!
    @IBOutlet weak var basicView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        basicView.setCornerRadiusWithBorderColor(radius: 10, color: UIColor(rgb: 0xE6E6E6), borderWidth: 0.5)
        professionalEdit.setCornerRadius(radius: 15)

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func cellConfigureWith(data: ProfileDataModel) {
        self.graduation.text = data.underGraduation ?? "XXXXXXX"
        self.postGraduation.text = data.postGraduation ?? "XXXXXXX"
        self.postGraduationInstitute.text = data.postGraduationInstitute ?? "XXXXXXX"
        self.graduationInstitute.text = data.underGraduationInstitute ?? "XXXXXXX"
        self.workingCompany.text = data.currentDepartment ?? "XXXXXXX"
        self.currentInstitution.text = data.currentInstitute ?? "XXXXXXX"
    }
    
}

