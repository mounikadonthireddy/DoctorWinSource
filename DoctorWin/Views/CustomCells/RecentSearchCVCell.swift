//
//  RecentSearchCVCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 11/01/22.
//

import UIKit

class RecentSearchCVCell: UICollectionViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var postedDate: UILabel!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var disignation: UILabel!
    @IBOutlet weak var location: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.setCornerRadiusWithBorderColor(radius: 10, color: UIColor(rgb: 0xE6E6E6), borderWidth: 0.5)
        nameLable.setCornerRadius(radius: Float(self.nameLable.frame.height)/2)

        // Initialization code
    }
    func cellConfigureWith(data: RecentSearchModel) {
        self.nameLable.text = data.search.department
        self.disignation.text = data.search.disignation
        self.location.text = data.search.location
        if let date = data.created {
       let days = calculateDaysfrom(date: date)
            self.postedDate.text = "\(days)d ago"
        }

    }
    func calculateDaysfrom(date: String) -> Int {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS"
            let formatedStartDate = dateFormatter.date(from: date)
            let currentDate = Date()
            _ = Set<Calendar.Component>([ .day])
            let differenceOfDate =  Calendar.current.dateComponents([.day], from: formatedStartDate!, to: currentDate).day!
            return differenceOfDate
        }


}
