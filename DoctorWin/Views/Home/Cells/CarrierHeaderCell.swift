//
//  CarrierHeaderCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 11/01/22.
//

import UIKit
import iOSDropDown

protocol SearchJobDelegate: class {
    func SearchJobDelegate(query: String, jobType: String)
}

class CarrierHeaderCell: UITableViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var specialityTF: DropDown!
    @IBOutlet weak var designationTF: DropDown!
    @IBOutlet weak var locationTF: DropDown!
    @IBOutlet weak var search: UIButton!
    var location = "location="
    var designation = "designation="
    var department = "department="
    weak var deleagte:SearchJobDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.setCornerRadiusWithBorderColor(radius: 10, color: UIColor(rgb: 0xE6E6E6), borderWidth: 0.5)
        specialityTF.didSelect { selectedText, index, id in
            self.department += selectedText
        }
        designationTF.didSelect { selectedText, index, id in
            self.designation += selectedText
        }
        locationTF.didSelect { selectedText, index, id in
            self.location += selectedText
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func searchClicked(_ sender: UIButton) {
        let finalString = location + "&" + department + "&" + designation
        deleagte?.SearchJobDelegate(query: finalString, jobType: department + location)
    }
    
}
