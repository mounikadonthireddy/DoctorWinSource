//
//  NetworkCVHeaderView.swift
//  DoctorWin
//
//  Created by AHP on 03/09/2565 BE.
//

import UIKit

class NetworkCVHeaderView: UICollectionReusableView {
    @IBOutlet weak var groupTableView: UITableView!
    @IBOutlet weak var groupTableHeight: NSLayoutConstraint!
    var groupArray: [GroupModel]  = []
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["Groups", "People"])
            interfaceSegmented.selectorViewColor = .black
            interfaceSegmented.selectorTextColor = .black
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        groupTableView.delegate = self
        groupTableView.dataSource = self
        groupTableView.register(UINib(nibName: "NetworkCVHeaderTVCell", bundle: nil), forCellReuseIdentifier: "NetworkCVHeaderTVCell")
    }
    func loadGropsData(data:[GroupModel]) {
        groupArray = data
        groupTableHeight.constant = CGFloat(groupArray.count * 50)
        
        groupTableView.reloadData()
        
    }
}
extension NetworkCVHeaderView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:NetworkCVHeaderTVCell = tableView.dequeueReusableCell(withIdentifier: "NetworkCVHeaderTVCell") as! NetworkCVHeaderTVCell
        cell.configureWithConnectionData(data: groupArray[indexPath.row])
        
        
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
