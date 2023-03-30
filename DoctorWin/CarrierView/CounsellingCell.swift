//
//  CounsellingCell.swift
//  DoctorWin
//
//  Created by AHP on 22/03/2566 BE.
//

import UIKit
import iOSDropDown

class CounsellingCell: UITableViewCell {
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var numberTF: UITextField!
    @IBOutlet weak var rankTF: UITextField!
    @IBOutlet weak var casteTF: DropDown!
    @IBOutlet weak var stateTF: DropDown!
    @IBOutlet weak var bookBtn: UIButton!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        casteTF.optionArray = ["Economically weak", "General", "Other Backward Classes", "Scheduled caste", "Scheduled Tribe"]
        bgView.dropShadow()
        //bgView.setCornerRadius(radius: 10)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
