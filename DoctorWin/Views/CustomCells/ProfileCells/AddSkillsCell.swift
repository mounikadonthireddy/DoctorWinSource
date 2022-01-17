//
//  AddSkillsCell.swift
//  DoctorWin
//
//  Created by N517325 on 03/11/21.
//

import UIKit

class AddSkillsCell: UITableViewCell {

    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var descriptionName: UILabel!
    @IBOutlet weak var buttonName: UIButton!
    @IBOutlet weak var butonHeight: NSLayoutConstraint!
    @IBOutlet weak var labelHeight: NSLayoutConstraint!
    @IBOutlet weak var edit : UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func cellConfigureWith(section: Int, data:ProfileDataModel) {
        if section == 1 {
            titleName.text = "About Me"
        
            descriptionName.text = data.aboutMe ??  "Write something about you"
            butonHeight.constant = 0
            buttonName.isHidden = true
            
        } else if section == 4 {
            titleName.text = "Experience"
            descriptionName.text = ""
            butonHeight.constant = 40
            labelHeight.constant = 0
            buttonName.isHidden = false
            buttonName.setTitle("+ Add Experience", for: .normal)
            
        } else if section == 6 {
            titleName.text = "Skills"
            descriptionName.text = data.skill ?? "Write something Skills"
            butonHeight.constant = 40
            buttonName.isHidden = false
            buttonName.setTitle("+ Add Skills", for: .normal)

        }
    }
    
}
