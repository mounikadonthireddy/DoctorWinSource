//
//  ProfileProfessionalEditCell.swift
//  DoctorWin
//
//  Created by N517325 on 03/11/21.
//

import UIKit
import iOSDropDown
class ProfileProfessionalEditCell: UITableViewCell {
    @IBOutlet weak var currentWorkingTF: DropDown!
    @IBOutlet weak var graduationTF: DropDown!
    @IBOutlet weak var postGraduationTF: DropDown!
    @IBOutlet weak var graduationInstititeTF: DropDown!
    @IBOutlet weak var postGraduationInstititeTF: DropDown!
    @IBOutlet weak var instititeTF: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    var profileDelegate: ProfileUpdateDeleegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        currentWorkingTF.setUnderLine()
        graduationTF.setUnderLine()
        postGraduationInstititeTF.setUnderLine()
        postGraduationTF.setUnderLine()
        instititeTF.setUnderLine()
        graduationInstititeTF.setUnderLine()
        saveBtn.setCornerRadius(radius: Float(saveBtn.frame.height)/2)

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func saveClicked(_ sender: Any) {
        let editModel = ProfessionalEditModel(current_department: currentWorkingTF.text ?? "", current_institute: instititeTF.text ?? "", ug: graduationTF.text ?? "", ug_institute_name: graduationInstititeTF.text ?? "", pg: postGraduationTF.text ?? "", pg_institute_name: postGraduationInstititeTF.text ?? "")
        
        let resource = ProfileEditResource()
        resource.editProfileProfessionalInfoData(userID: User.shared.userID, profileReq: editModel) { data in
            DispatchQueue.main.async {
            if data?.status == true {
                self.profileDelegate?.didProfileUpdated(status: true, error: nil)
            }
            }
        }
    }
    func configureCellWithProfessionData(data: ProfileDataModel) {
        self.graduationTF.text = data.underGraduation
        self.postGraduationTF.text = data.postGraduation
        self.postGraduationInstititeTF.text = data.postGraduationInstitute
        self.graduationInstititeTF.text = data.underGraduationInstitute
        self.instititeTF.text = data.currentInstitute ?? "XXXXX"
        self.currentWorkingTF.text = data.currentDepartment
        
    }
    func configureDataForDropDown(data: ProfessionalDropDownModel) {
        graduationTF.optionArray = data.ug_course
        currentWorkingTF.optionArray = data.department
        postGraduationTF.optionArray = data.pg_course
        postGraduationInstititeTF.optionArray = data.pg_institute
        graduationInstititeTF.optionArray = data.ug_institute
    }
}
extension ProfileProfessionalEditCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
struct ProfessionalEditModel: Codable {
    let current_department: String
    let current_institute: String
    let ug: String
    let ug_institute_name: String
    let pg: String
    let pg_institute_name: String
    
}
