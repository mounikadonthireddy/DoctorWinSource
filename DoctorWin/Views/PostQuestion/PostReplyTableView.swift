//
//  PostReplyTableView.swift
//  DoctorWin
//
//  Created by N517325 on 10/11/21.
//

import UIKit

class PostReplyTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func awakeFromNib() {
           super.awakeFromNib()
           self.register(UINib(nibName: "PostReplyCell", bundle: nil), forCellReuseIdentifier: "PostReplyCell")
        self.register(UINib(nibName: "PostQuestionHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "PostQuestionHeader")

           self.delegate = self
           self.dataSource = self
        self.separatorInset = .zero
   }


}

extension PostReplyTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostReplyCell = tableView.dequeueReusableCell(withIdentifier: "PostReplyCell") as! PostReplyCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: PostQuestionHeader.identifier) as? PostQuestionHeader {
            
            //
            return headerView
        }
        
        return nil
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 230
    }
}

extension PostReplyTableView : UITableViewDelegate {
    
}
