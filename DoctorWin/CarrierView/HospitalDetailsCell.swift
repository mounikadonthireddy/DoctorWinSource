//
//  HospitalDetailsCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 05/05/22.
//

import UIKit

class HospitalDetailsCell: UITableViewCell {
    @IBOutlet weak var hospitalLocation: UILabel!
    @IBOutlet weak var hospitalName: UILabel!
    @IBOutlet weak var hospitalDescription: UILabel!
    @IBOutlet weak var hospitalWebsite: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureCellWith(data: CarrierModel) {
        self.hospitalLocation.text = "Company Address : " + (data.location_of_job ?? "")
        self.hospitalWebsite.text = "Company Website : " + (data.website ?? "")
        self.hospitalName.text = "Name of Consultancy/Hospital : " + (data.name_of_company ?? "")
        self.hospitalDescription.text = "Company Description: " + (data.about_company ?? "")
    }
}

