//
//  EditPersonalInfoCell.swift
//  DoctorWin
//
//  Created by AHP on 01/09/2565 BE.
//

import UIKit
import iOSDropDown

protocol ProfileUpdateDelegate {
    func didProfileUpdated(status: Bool, error: String?)
}


class EditPersonalInfoCell: UITableViewCell {
    @IBOutlet weak var contactNumTF: UITextField!
    @IBOutlet weak var emailIDTF: UITextField!
    @IBOutlet weak var genderTF: DropDown!
    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    var profileDelegate: ProfileUpdateDelegate?
    var languageArray:[String] = []
    var genderArray:[String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contactNumTF.setUnderLine()
        emailIDTF.setUnderLine()
        genderTF.setUnderLine()
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
                switch data {
                    
                case .success(let res):
                    if res?.status == "true" {
                        self.profileDelegate?.didProfileUpdated(status: true, error: nil)
                        
                    }
                case .failure(_):
                    self.profileDelegate?.didProfileUpdated(status: false, error: nil)
                }
                
            }
        }
        
    }
    
    
}
