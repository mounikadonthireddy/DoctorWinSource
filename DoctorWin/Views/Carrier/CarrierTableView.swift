//
//  CarrierTableView.swift
//  DoctorWin
//
//  Created by N517325 on 12/11/21.
//

import UIKit

class CarrierTableView: UITableView {
    var collegeDataArray: [CollegeDataModel] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.register(UINib(nibName: "CarrierCell", bundle: nil), forCellReuseIdentifier: "CarrierCell")
        
        self.delegate = self
        self.dataSource = self
        self.separatorInset = .zero
    }
    
}
extension CarrierTableView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collegeDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CarrierCell
            = tableView.dequeueReusableCell(withIdentifier: "CarrierCell", for: indexPath) as! CarrierCell
        cell.configureCell(with: collegeDataArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
}
