//
//  CurriculamCell.swift
//  DoctorWin
//
//  Created by AHP on 13/10/2565 BE.
//

import UIKit

class CurriculamCell: UITableViewCell {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    var curriculamArray: [CurriculamModel] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableView.register(UINib(nibName: "CurriculamHeaderCell", bundle: nil), forCellReuseIdentifier: "CurriculamHeaderCell")
        tableView.register(UINib(nibName: "CurriculamExpandCell", bundle: nil), forCellReuseIdentifier: "CurriculamExpandCell")
        tableView.register(CurriculamCourseHeaderCell.nib, forHeaderFooterViewReuseIdentifier: CurriculamCourseHeaderCell.identifier)
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func loadCellData(array: [CurriculamModel]) {
        curriculamArray = array
        var height = 40
        height = height + curriculamArray.count * 40
        tableView.invalidateIntrinsicContentSize()
        tableView.reloadData()
        print(curriculamArray)
    }
    
}
extension CurriculamCell: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return curriculamArray.count + 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            print("count\(curriculamArray[section - 1].sub_chapter?.count ?? 0)")
            return curriculamArray[section - 1].sub_chapter?.count ?? 0
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: CurriculamHeaderCell
            = tableView.dequeueReusableCell(withIdentifier: "CurriculamHeaderCell") as! CurriculamHeaderCell
            
            return cell
        } else {
            
            let cell: CurriculamExpandCell
            = tableView.dequeueReusableCell(withIdentifier: "CurriculamExpandCell") as! CurriculamExpandCell
            cell.configureCell(data: curriculamArray[indexPath.section - 1].sub_chapter![indexPath.row], index: indexPath.row + 1)
            
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 0 {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CurriculamCourseHeaderCell") as? CurriculamCourseHeaderCell {
          
            headerView.headerName.text = curriculamArray[section - 1].chapter_name
        
            headerView.expand.addTarget(self, action: #selector(expandClicked(button:)), for: .touchUpInside)
            headerView.expand.tag = section - 1
            
            return headerView
        }
        }
        return nil
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 50
    }
    @objc func expandClicked(button: UIButton) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


