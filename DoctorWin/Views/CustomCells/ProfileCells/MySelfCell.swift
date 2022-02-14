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
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var qualificationTF: DropDown!
    @IBOutlet weak var specilityTF: DropDown!
    @IBOutlet weak var save: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameTF.setUnderLine()
        locationTF.setUnderLine()
        specilityTF.setUnderLine()
        qualificationTF.setUnderLine()
        save.setCornerRadius(radius: Float(save.frame.height)/2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func saveClicked(_ sender: UIButton) {
        
    }
    func configurePersonalEditCell(data: ProfileDataModel) {
        self.nameTF.text = data.profileName
        self.locationTF.text = data.currentLocation
        self.specilityTF.text = data.speciality
        self.qualificationTF.text = data.qualification
    }
}
