//
//  ImageSectionTVCell.swift
//  DoctorWin
//
//  Created by AHP on 26/02/2566 BE.
//

import UIKit

class ImageSectionTVCell: UITableViewCell {
    @IBOutlet weak var answerBtn: UIButton!
    @IBOutlet weak var askBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        answerBtn.setCornerRadius(radius: 10)
        askBtn.setCornerRadius(radius: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func answerClicked(_ sender: UIButton) {
        askBtn.backgroundColor = UIColor.white
        askBtn.titleLabel?.textColor = #colorLiteral(red: 0, green: 0.381624639, blue: 0.6041520834, alpha: 1)
        answerBtn.backgroundColor = #colorLiteral(red: 0, green: 0.381624639, blue: 0.6041520834, alpha: 1)
        answerBtn.titleLabel?.textColor = UIColor.white
        
    }
    @IBAction func askClicked(_ sender: UIButton) {
        answerBtn.backgroundColor = UIColor.white
        answerBtn.titleLabel?.textColor = #colorLiteral(red: 0, green: 0.381624639, blue: 0.6041520834, alpha: 1)
        askBtn.backgroundColor = #colorLiteral(red: 0, green: 0.381624639, blue: 0.6041520834, alpha: 1)
        askBtn.titleLabel?.textColor = UIColor.white
    }
}
