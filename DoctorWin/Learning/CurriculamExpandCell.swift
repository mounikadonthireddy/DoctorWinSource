//
//  CurriculamExpandCell.swift
//  DoctorWin
//
//  Created by AHP on 13/10/2565 BE.
//

import UIKit

class CurriculamExpandCell: UITableViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var videoLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(data: SubChaperModel, index:Int) {
        nameLbl.text = data.sub_chapter_name ?? ""
        countLbl.text = "\(index)"
        videoLbl.text = data.duration ?? ""
    }
}
