//
//  SearchJobCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 28/12/21.
//

import UIKit

class SearchJobCell: UITableViewCell {
    @IBOutlet weak var postedDate: UILabel!
    @IBOutlet weak var hospitalImage: UIImageView!
    @IBOutlet weak var experience: UILabel!
    @IBOutlet weak var salary: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var specialityName: UILabel!
    @IBOutlet weak var hospitalName: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var save: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.clipsToBounds = true
        bgView.layer.cornerRadius = 10
        bgView.layer.borderWidth = 0.5
        bgView.layer.borderColor = UIColor.lightGray.cgColor
        hospitalImage.setCornerRadius(radius: 15)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func chatClicked(_ sender: Any) {
    }
    
    @IBAction func callClicked(_ sender: Any) {
    }
    @IBAction func saveClicked(_ sender: UIButton) {
        let request = JobApplyRequest(user_id: User.shared.userID, job_id: "\(sender.tag)")
        let resource = JobsResource()
        resource.saveJob(request: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success( let data):
                    if data.status {
                        self.save.setImage( UIImage(named: "fmark"), for: .normal)
                    }
                    else {
                        self.save.setImage( UIImage(named: "mark"), for: .normal)
                    }
                case .failure: break
                   //debug
                }
            }
           
        }
        
    }
    func configureCell(with data: JobsDataModel) {
        self.hospitalName.text =  data.designation!
        self.specialityName.text = data.course
        self.location.text = data.location
        if let exp = data.experince {
            self.experience.text = "\(exp)" + " yrs Experience"

        }
        save.tag = data.id ?? 0
        if let salary = data.salary {
            self.salary.text = "\(salary) /" + data.salaryType!
        }

        if let urlString = data.image {
            let finalUrlString = ApiEndpoints.baseImageURL + urlString
            
            self.hospitalImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
        }
        if let date = data.date {
       let days = convertDateFormater(date)
            self.postedDate.text = "Posted on \(days)"
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
    
    func convertDateFormater(_ date: String) -> String
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS"
            let date = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return  dateFormatter.string(from: date!)

        }
}
extension Date {

    func offsetFrom(dateStr: String) -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS"
        guard let conDate = dateFormatter.date (from: dateStr) else { return "" }
    
        let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: conDate, to: self)

        let seconds = "\(difference.second ?? 0)s"
        let minutes = "\(difference.minute ?? 0)m"
        let hours = "\(difference.hour ?? 0)h"
        let days = "\(difference.day ?? 0)d"

        if let day = difference.day, day          > 0 { return days }
        if let hour = difference.hour, hour       > 0 { return hours }
        if let minute = difference.minute, minute > 0 { return minutes }
        if let second = difference.second, second > 0 { return seconds }
        return ""
    }

}
