//
//  DoubtsCell.swift
//  DoctorWin
//
//  Created by AHP on 18/03/2566 BE.
//

import UIKit

class DoubtsCell: UICollectionViewCell {
    @IBOutlet weak var answerLbl: UILabel!
    @IBOutlet weak var questionBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        //self.setCornerRadiusWithBorderColor(radius: 10, color: UIColor.lightGray, borderWidth: 0.7)
//        questionBtn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
//        questionBtn.titleLabel?.transform = CGAffineTransformMakeScale(-1.0, 1.0);
//        questionBtn.titleLabel?.textAlignment = .left
//        questionBtn.imageView?.transform = CGAffineTransformMakeScale(-1.0, 1.0);
       // questionBtn.semanticContentAttribute = .forceRightToLeft
    }
    func configureCell(data: FAQModel, willExpand: Bool) {
        if willExpand {
            answerLbl.text = data.description ?? ""
        } else {
            answerLbl.text = ""
        }
        if let title = data.title {
            questionBtn.setTitle("\(title)" , for: .normal)
        }
    }
}
