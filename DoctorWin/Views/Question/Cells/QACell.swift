//
//  QACell.swift
//  DoctorWin
//
//  Created by AHP on 04/09/2565 BE.
//

import UIKit

class QACell: UITableViewCell {

    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var posteddateLbl: UILabel!
    @IBOutlet weak var answerCountLbl: UILabel!
    @IBOutlet weak var answerBtn: UIButton!
    @IBOutlet weak var requestBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        answerBtn.setCornerRadiusWithBorderColor(radius: Float(answerBtn.frame.height)/2, color: UIColor.lightGray, borderWidth: 0.5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureWith(data: HomeDataModel) {
        questionLbl.text = data.title ?? ""
        answerCountLbl.text = "\(data.comment_count ?? 0) Answers"
    }
}
