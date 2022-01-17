//
//  EditSkillCell.swift
//  DoctorWin
//
//  Created by N517325 on 15/11/21.
//

import UIKit

class EditSkillCell: UITableViewCell {
    @IBOutlet weak var detailsTF: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    var profileDelegate: ProfileUpdateDeleegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        detailsTF.setUnderLine()
        saveBtn.setCornerRadius(radius: Float(saveBtn.frame.height)/2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func saveClicked(_ sender: UIButton) {
        print(sender.tag)
        let resource = ProfileEditResource()
        if sender.tag == 0 {
            let editModel = EditAboutModel(tell_me_about_youself: detailsTF.text ?? "dfsad")
            resource.editProfileAboutMe(userID: User.shared.userID, profileReq: editModel) { res in
                DispatchQueue.main.async {
                if res?.status == true {
                    self.profileDelegate?.didProfileUpdated(status: true, error: nil)
                }
                }
            }
            
        } else if sender.tag == 1 {
            let editModel = EditSkillModel(skill: detailsTF.text ?? "sfzxfddgvf")
            resource.editProfileSkill(userID: User.shared.userID, profileReq: editModel){ res in
                DispatchQueue.main.async {
                if res?.status == true {
                    self.profileDelegate?.didProfileUpdated(status: true, error: nil)
                }
            }
            }
        }
    }
    func configureCellWithEdit(data: ProfileDataModel, section: Int) {
        if section == 0 {
            titleLabel.text = "About Me"
            detailsTF.text = data.aboutMe
            saveBtn.tag = 0
        } else {
            titleLabel.text = "Skills"
            detailsTF.text = data.skill
            saveBtn.tag = 1
        }
    }
}

struct EditAboutModel:Codable {
    let tell_me_about_youself: String
}
struct EditSkillModel: Codable {
    let skill: String
}
