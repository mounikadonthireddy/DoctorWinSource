//
//  AnswersCell.swift
//  DoctorWin
//
//  Created by AHP on 04/09/2565 BE.
//

import UIKit

class AnswersCell: UICollectionViewCell {
    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personDesignation: UILabel!
    @IBOutlet weak var questionDes: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
