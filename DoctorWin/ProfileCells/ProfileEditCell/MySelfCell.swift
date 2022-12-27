//
//  MySelfCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 10/02/22.
//

import UIKit
import iOSDropDown
class MySelfCell: UITableViewCell {
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var specilityTF: DropDown!
    @IBOutlet weak var save: UIButton!
    var profileDelegate: ProfileUpdateDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameTF.setUnderLine()
      
        specilityTF.setUnderLine()
     
        save.setCornerRadius(radius: Float(save.frame.height)/2)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func saveClicked(_ sender: Any){
        
        let personalInfoRequest = SelfDataEditModel(highest_qualification:  "", current_job_location:  "", speciality: specilityTF.text ?? "", profile_name: nameTF.text ?? "")
        
        let resource = ProfileEditResource()
        resource.editSelfdataPersonalInfoData(userID: User.shared.userID, profileReq: personalInfoRequest) { data in
            DispatchQueue.main.async {
                switch data {
                    
                case .success(let res):
                    if res?.status == true {
                        self.profileDelegate?.didProfileUpdated(status: true, error: nil)
                    }
                case .failure(_):
                    self.profileDelegate?.didProfileUpdated(status: false, error: nil)
                }
                
            }
        }
        
    }
    
    func configurePersonalEditCell(data: ProfileDataModel) {
        self.nameTF.text = data.name ?? ""
        self.specilityTF.text = data.speciality ?? ""
    }
    
}
