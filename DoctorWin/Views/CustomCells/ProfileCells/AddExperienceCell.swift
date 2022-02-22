//
//  AddExperienceCell.swift
//  DoctorWin
//
//  Created by N517325 on 03/11/21.
//

import UIKit

class AddExperienceCell: UITableViewCell {
    @IBOutlet weak var saveBtn : UIButton!
    @IBOutlet weak var hospitalNameTF: UITextField!
    @IBOutlet weak var designationTF: UITextField!
    @IBOutlet weak var departmentTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var fromDate: UITextField!
    @IBOutlet weak var toDate: UITextField!
    @IBOutlet weak var currentlyWorking: UISwitch!
    var profileDelegate: ProfileUpdateDeleegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        saveBtn.setCornerRadius(radius: Float(saveBtn.frame.height)/2)
        hospitalNameTF.setUnderLine()
        hospitalNameTF.delegate = self
        designationTF.delegate = self
        departmentTF.delegate = self
        cityTF.delegate = self
        
        designationTF.setUnderLine()
        departmentTF.setUnderLine()
        cityTF.setUnderLine()
        fromDate.setUnderLine()
        toDate.setUnderLine()
        fromDate.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
        toDate.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed1))
        
    }
    
    @objc func doneButtonPressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let  datePicker = self.fromDate.inputView as? UIDatePicker {
            self.fromDate.text = dateFormatter.string(from: datePicker.date)
        }
        self.fromDate.resignFirstResponder()
        
    }
    @objc func doneButtonPressed1() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let  datePicker = self.toDate.inputView as? UIDatePicker {
            self.toDate.text = dateFormatter.string(from: datePicker.date)
        }
        
        self.toDate.resignFirstResponder()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func yesClicked(_ sender: UISwitch) {
        if sender.isOn {
            toDate.isEnabled = false
            toDate.text = "Present"
        } else {
            toDate.isEnabled = true
            toDate.text = ""
        }
        
    }
    @IBAction func saveClicked(_ sender: Any) {
        var todate = ""
        if toDate.text == "Present" {
            todate = getCurrentShortDate()
        } else {
            todate = toDate.text ?? ""
        }
        
        let addModel = AddExperienceModel(hospital_name: hospitalNameTF.text ?? "avc", designation: designationTF.text ?? "aa", department: departmentTF.text ?? "aa", city: cityTF.text ?? "aa", start_date: fromDate.text ?? "2021-10-12", end_date: todate)
        
        let editResource = ProfileEditResource()
        editResource.addExperience(userID: User.shared.userID, profileReq: addModel) { response in
            
            DispatchQueue.main.async {
                if response.status == "true" {
                    self.profileDelegate?.didProfileUpdated(status: true, error: nil)
                }
                
                
            }
        }
    }
    func getCurrentShortDate() -> String {
        let todaysDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-DD"
        let DateInFormat = dateFormatter.string(from: todaysDate as Date)
        
        return DateInFormat
    }
    
}
extension AddExperienceCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
struct AddExperienceModel: Codable {
    let hospital_name: String
    let designation: String
    let department: String
    let city: String
    let start_date: String
    let end_date: String
}

