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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureWith(data: PostedQuestionModel) {
        questionLbl.text = data.asked_question ?? ""
        answerCountLbl.text = "\(data.number_of_answer ?? 0) Answers"
    }
}
