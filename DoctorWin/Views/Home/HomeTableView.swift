//
//  HomeTableView.swift
//  DoctorWin
//
//  Created by N517325 on 10/11/21.
//

import UIKit

class HomeTableView: UITableView {
    var homedataArry: [HomeDataModel] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.register(UINib(nibName: "HomeTableCell", bundle: nil), forCellReuseIdentifier: "HomeTableCell")
        self.register(UINib(nibName: "HomeTableViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "HomeTableViewHeader")
        
        self.delegate = self
        self.dataSource = self
        self.separatorInset = .zero
    }
    
}
extension HomeTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homedataArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeTableCell
            = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell") as! HomeTableCell
        cell.configureData(homeModel: homedataArry[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeTableViewHeader.identifier) as? HomeTableViewHeader {
            headerView.configureCollectionView()
            return headerView
        }
        
        return nil
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeDetailsViewController") as! HomeDetailsViewController
        //        nextVC.detailsModel = homedataArry[indexPath.row]
        //                self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
