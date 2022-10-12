//
//  QuestionHeaderCell.swift
//  DoctorWin
//
//  Created by AHP on 10/10/2565 BE.
//

import UIKit

class QuestionHeaderCell: UITableViewCell {
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var answer: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var personImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        stackView.setCornerRadius(radius: Float(stackView.frame.height)/2)
        personImage.setCornerRadius(radius: Float(personImage.frame.height)/2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
