//
//  NetworkCVHeaderView.swift
//  DoctorWin
//
//  Created by AHP on 03/09/2565 BE.
//

import UIKit

protocol NetworkGroupSelected: class {
    func selectedGroup(groupId:String)
}

class NetworkCVHeaderView: UICollectionReusableView {
    @IBOutlet weak var groupTableView: UITableView!
    @IBOutlet weak var groupTableHeight: NSLayoutConstraint!
    var delegate: NetworkGroupSelected?
    var groupArray: [AdminGroupModel]  = []
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
        groupTableView.register(NetworkTableHeader.nib, forHeaderFooterViewReuseIdentifier: NetworkTableHeader.identifier)
        
    }
    func loadGropsData(data:[AdminGroupModel]) {
        groupArray = data
        groupTableHeight.constant = CGFloat(groupArray.count * 50) + 55
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
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: NetworkTableHeader.identifier) as? NetworkTableHeader {
            headerView.backgroundColor = UIColor.red
            headerView.requestBtn.addTarget(self, action: #selector(requestClicked(button:)), for: .touchUpInside)
            return headerView
        }
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    @objc func requestClicked (button: UIButton) {
        delegate?.selectedGroup(groupId: "request")
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectedGroup(groupId: (groupArray[indexPath.row].group_id) ?? "")
    }
}
