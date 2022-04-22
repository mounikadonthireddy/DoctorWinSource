//
//  HomeDetailsTableView.swift
//  DoctorWin
//
//  Created by N517325 on 10/11/21.
//

import UIKit

class HomeDetailsTableView: UITableView {
    var detailsModel : HomeDataModel!

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.register(UINib(nibName: "HomeDetailsCell", bundle: nil), forCellReuseIdentifier: "HomeDetailsCell")
        self.register(UINib(nibName: "CommentsCell", bundle: nil), forCellReuseIdentifier: "CommentsCell")


        
        self.delegate = self
        self.dataSource = self
        self.separatorInset = .zero
    }
    
    

}
extension HomeDetailsTableView : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
           // return detailsModel.commentsArray?.count ?? 0
            return 0
        }
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
        let cell: HomeDetailsCell
            = tableView.dequeueReusableCell(withIdentifier: "HomeDetailsCell") as! HomeDetailsCell
        cell.configureCellWith(data: detailsModel)
        return cell
        } else {
            let cell: CommentsCell
                = tableView.dequeueReusableCell(withIdentifier: "CommentsCell") as! CommentsCell
//            cell.configureCellWith(data: detailsModel.commentsArray![indexPath.row])
            return cell
        }
    }
   
    
    
}
