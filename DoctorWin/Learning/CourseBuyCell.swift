//
//  CourseBuyCell.swift
//  DoctorWin
//
//  Created by AHP on 20/12/2565 BE.
//

import UIKit

class CourseBuyCell: UITableViewCell {
    @IBOutlet weak var detailsLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func cellloadData(data: BuyModel) {
        nameLbl.text = data.name ?? ""
        detailsLbl.text = data.description ?? ""
        priceLbl.text = "\u{20B9}\(data.price ?? 0)"
    }
}
