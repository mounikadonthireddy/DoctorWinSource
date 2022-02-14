//
//  ProfileEditCell.swift
//  DoctorWin
//
//  Created by N517325 on 03/11/21.
//

import UIKit
import iOSDropDown

protocol ProfileUpdateDeleegate {
    func didProfileUpdated(status: Bool, error: String?)
}


class ProfileEditCell: UITableViewCell {
    @IBOutlet weak var contactNumTF: UITextField!
    @IBOutlet weak var emailIDTF: UITextField!
    @IBOutlet weak var genderTF: DropDown!
    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
     var profileDelegate: ProfileUpdateDeleegate?
    var languageArray:[String] = []
    var genderArray:[String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contactNumTF.setUnderLine()
        emailIDTF.setUnderLine()
        genderTF.setUnderLine()
        //        genderTF.isSearchEnable = false
        //        languageTF.isSearchEnable = false
        dobTF.setUnderLine()
        saveBtn.setCornerRadius(radius: Float(saveBtn.frame.height)/2)
        dobTF.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
        
    }
    
    @objc func doneButtonPressed() {
        if let  datePicker = self.dobTF.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.dobTF.text = dateFormatter.string(from: datePicker.date)
        }
        self.dobTF.resignFirstResponder()
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configurePersonalEditCell(data: ProfileDataModel) {
        self.contactNumTF.text = data.phoneNumber
        self.emailIDTF.text = data.email
        self.genderTF.text = data.gender
        self.dobTF.text = data.dob
        genderTF.optionArray = genderArray
    }
    @IBAction func saveClicked(_ sender: Any){
        let name = UserDefaults.standard.value(forKey: "username") ?? ""

        let personalInfoRequest = PersonalInfoEditModel1(phone_number: contactNumTF.text ?? "", email: self.emailIDTF.text ?? "", gender: genderTF.text ?? "", dob: dobTF.text ?? "", location: "", language: "", profile_name: name as! String)
        let resource = ProfileEditResource()
        resource.editProfilePersonalInfoData(userID: User.shared.userID, profileReq: personalInfoRequest) { data in
            DispatchQueue.main.async {
            
            if data?.status == "true" {
                self.profileDelegate?.didProfileUpdated(status: true, error: nil)
            }
            }
        }
        
    }
    
    
}

struct PersonalInfoEditModel: Codable {
    let phone_number: String
    let email: String
    let gender: String
    let dob: String
    let location: String
    let language: String
    
}
struct ResponseModel: Codable {
    let status: String?
    let message: String?
}
struct BoolResponseModel: Codable {
    let status: Bool?
    let message: String?
}
struct ProfessionalResponseModel: Codable {
    let status: Bool?
    let message: String?
}
struct PersonalInfoEditModel1: Codable {
    let phone_number: String
    let email: String
    let gender: String
    let dob: String
    let location: String
    let language: String
    let profile_name: String
    
}
struct SaveResponse: Codable {
    let bookmark_status : String
}
struct JobApplyResponse: Codable {
    let apply_status : Bool
}

struct ComplaintLikeResponse: Codable {
    let like_status: String
}
struct PostReplyResponse: Codable {
    let message : String?
    let status : String?
    let discussion : Int?

}
struct ProfileUpdateResponseModel: Codable {
    let status: String?
    let message: String?
}
