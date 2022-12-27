//
//  LearningOverViewCell.swift
//  DoctorWin
//
//  Created by AHP on 13/10/2565 BE.
//

import UIKit

class LearningOverViewCell: UITableViewCell {
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var heightlightsLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureCell(data: OverViewModel) {
        descriptionLbl.text = data.description ?? ""
        heightlightsLbl.text = data.heightlight ?? ""
    }
}
