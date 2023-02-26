//
//  CourseNameCell.swift
//  DoctorWin
//
//  Created by N517325 on 07/11/21.
//

import UIKit

class CourseNameCell: UICollectionViewCell {
//    override var isSelected: Bool {
//        willSet {
//            self.backgroundColor = UIColor.clear
//            self.name.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        }
//            didSet {
//                self.backgroundColor = isSelected ? #colorLiteral(red: 0, green: 0.381624639, blue: 0.6041520834, alpha: 1) : UIColor.clear
//                self.name.textColor = isSelected ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) :  #colorLiteral(red: 0, green: 0.381624639, blue: 0.6041520834, alpha: 1)
//            }
//        }
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nameLblHeight: NSLayoutConstraint!
    @IBOutlet weak var bgView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.setCornerRadius(radius: 10)
      
    }

}
