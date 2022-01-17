//
//  CaseEditCell.swift
//  DoctorWin
//
//  Created by N517325 on 08/11/21.
//

import UIKit

class CaseEditCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTF: UITextField!

    let section2Array = ["Present Illness", "Past Illness", "Drugs", "Personal", "Family"]
    let section3Array = ["Physical Examination", "System Examination", "Local Examination"]
    let section4Array = ["Vitus", "Lab Finding", "Imaging"]

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func adddata(section: Int, indexRow: Int) {
        
        if section == 2 {
            nameLabel.text = section2Array[indexRow]
            nameTF.placeholder = section2Array[indexRow]
        }
        
        if section == 3 {
            nameLabel.text = section3Array[indexRow]
            nameTF.placeholder = section3Array[indexRow]

        }
        if section == 4 {
            nameLabel.text = section4Array[indexRow]
            nameTF.placeholder = section4Array[indexRow]

        }
    }
    
    
   
}
