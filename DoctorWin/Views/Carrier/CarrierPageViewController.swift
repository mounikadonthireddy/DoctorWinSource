//
//  CarrierPageViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 10/01/22.
//

import UIKit

class CarrierPageViewController: ViewController {
    @IBOutlet weak var tableView: UITableView!
    var allJobsArray :[JobsDataModel] = []
    var categoryJobsViewModel = JobCategoryViewModel()
    var jobsVM = JobsViewModel()
    var jobsCategoryArray:[JobCategoryDataModel] = []
    var titleArray:[String] = ["", "Most Recent Search", "Quick Job Search", "Recommended Jobs", "", "View All Jobs"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CarrierHeaderCell", bundle: nil), forCellReuseIdentifier: "CarrierHeaderCell")
        tableView.contentInsetAdjustmentBehavior = .never

        
        tableView.register(UINib(nibName: "CarrierHighlightCell", bundle: nil), forCellReuseIdentifier: "CarrierHighlightCell")
        
        tableView.register(UINib.init(nibName: "CarrierSubCell", bundle: nil), forCellReuseIdentifier: "CarrierSubCell")
        tableView.register(UINib.init(nibName: "CollectionTableCell", bundle: nil), forCellReuseIdentifier: "CollectionTableCell")
        tableView.register(UINib.init(nibName: "QuickJobTVCell", bundle: nil), forCellReuseIdentifier: "QuickJobTVCell")
        tableView.register(UINib.init(nibName: "RecentSearchCell", bundle: nil), forCellReuseIdentifier: "RecentSearchCell")

        tableView.register(TitleView.nib, forHeaderFooterViewReuseIdentifier: TitleView.identifier)

        jobsVM.delegate = self
        categoryJobsViewModel.delegate = self
        parse()
        parse1()
    }
    
    func parse1() {
        
        jobsVM.getAllJobData(userID: User.shared.userID)
        
    }
    func parse() {
        self.showLoader()
        categoryJobsViewModel.getTopRecommendedJobs(userID: User.shared.userID)
    }

}
extension CarrierPageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 5 {
           return allJobsArray.count
        }
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0  {
            let cell: CarrierHeaderCell
            = tableView.dequeueReusableCell(withIdentifier: "CarrierHeaderCell") as! CarrierHeaderCell
           // cell.bgView.backgroundColor = UIColor.white
//          cell.configureCell(with: jobsCategoryArray)
            
            return cell
        } else if indexPath.section == 1 {
            let cell: RecentSearchCell
            = tableView.dequeueReusableCell(withIdentifier: "RecentSearchCell") as! RecentSearchCell
           // cell.bgView.backgroundColor = UIColor.white
//          cell.configureCell(with: jobsCategoryArray)
            
            return cell
            
            return cell
        }
        else if indexPath.section == 2 {
            let cell: QuickJobTVCell
            = tableView.dequeueReusableCell(withIdentifier: "QuickJobTVCell") as! QuickJobTVCell
           // cell.bgView.backgroundColor = UIColor.white
          cell.configureCell(with: jobsCategoryArray)
            
            return cell
        }
        if indexPath.section == 4 {
            let cell: CarrierHighlightCell
            = tableView.dequeueReusableCell(withIdentifier: "CarrierHighlightCell") as! CarrierHighlightCell
            
            return cell
        } else if indexPath.section == 5 {
            let cell: CarrierSubCell
            = tableView.dequeueReusableCell(withIdentifier: "CarrierSubCell") as! CarrierSubCell
            cell.bgView.backgroundColor = UIColor.white
            cell.configureCell(with: allJobsArray[indexPath.row])
            
            return cell
        }
        else if indexPath.section == 3 {
            let cell: CollectionTableCell
            = tableView.dequeueReusableCell(withIdentifier: "CollectionTableCell") as! CollectionTableCell
            cell.configureCell(with: allJobsArray)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if titleArray[section] == "" {
            return CGFloat.leastNormalMagnitude
        }
        return 30
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TitleView.identifier) as? TitleView {
            headerView.backgroundColor = UIColor.red
            headerView.titleLabel.text = titleArray[section]
            return headerView
        }
        
        return nil
        
    }
}
extension CarrierPageViewController: JobsViewModelDelegate {
    func didReceiveJobsResponse(response: [JobsDataModel]?, error: String?) {
        if error == nil {
            allJobsArray = response ?? []
            tableView.reloadData()
        }
    }
    
    
}
extension CarrierPageViewController: JobCategoryViewModelDelegate {
    func didReceiveTopJobs(response: [JobCategoryDataModel]?, error: String?) {
        self.dismiss()
        jobsCategoryArray = response ?? []
        tableView.reloadData()
    }
    
    
}
