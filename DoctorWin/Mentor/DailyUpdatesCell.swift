//
//  DailyUpdatesCell.swift
//  DoctorWin
//
//  Created by AHP on 21/03/2566 BE.
//

import UIKit

class DailyUpdatesCell: UICollectionViewCell {
    @IBOutlet weak var messageLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureWith(data: DailyUpdatesModel) {
        messageLbl.text = data.description ?? ""
    }
}
