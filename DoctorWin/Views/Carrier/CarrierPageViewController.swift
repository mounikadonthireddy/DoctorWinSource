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
    var quickSearchArray:[JobCategoryDataModel] = []
    var titleArray:[String] = ["", "Most Recent Search", "Quick Job Search", "Recommended Jobs", "", "View All Jobs"]
    var locationArray : [LocationModel] = []
    var speacilityArray:[SpeciltyModel] = []
    var designationArray : [DesignationModel] = []
    var recentSearchArray : [RecentSearchModel] = []
    var recommendJobsArray: [JobsDataModel] = []
    var topJobsViewModel  = TopJobsViewModel()
    var jobsCount: JobsCountModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CarrierHeaderCell", bundle: nil), forCellReuseIdentifier: "CarrierHeaderCell")
        tableView.contentInsetAdjustmentBehavior = .never
        
        topJobsViewModel.delegate = self
        
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
        getLocationsData()
        getDesignationData()
        downloadSpeacilityResource()
        getRecentSearchData()
        loadRecommendedJobs()
        getCustomJobsCount()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = false

    }
    func parse1() {
        jobsVM.getAllJobData(userID: User.shared.userID)
    }
    func parse() {
        self.showLoader()
        categoryJobsViewModel.getTopRecommendedJobs(userID: User.shared.userID)
    }
    func getLocationsData() {
        self.showLoader()
        DropDownResource().getLocationData { result in
            DispatchQueue.main.async {
                self.dismiss()
                self.locationArray = result
                self.tableView.reloadData()
            }
            
        }
    }
    func loadRecommendedJobs() {
        self.showLoader()
        topJobsViewModel.getTopRecommendedJobs(userID: User.shared.userID)
    }
    func getDesignationData() {
        self.showLoader()
        DropDownResource().getDesignationData { result in
            DispatchQueue.main.async {
                self.dismiss()
                self.designationArray = result
                self.tableView.reloadData()
            }
            
        }
    }
    func downloadSpeacilityResource() {
        self.showLoader()
        let resouce = DropDownResource()
        resouce.getSpecilityData { result in
            DispatchQueue.main.async {
                self.dismiss()
                self.speacilityArray = result
                self.tableView.reloadData()
            }
            
        }
    }
    func getRecentSearchData() {
        self.showLoader()
        let resouce = DropDownResource()
        resouce.getRecentSearchData { result in
            DispatchQueue.main.async {
                self.dismiss()
                self.recentSearchArray = result
                self.tableView.reloadData()
            }
            
        }
    }
    func getCustomJobsCount() {
        self.showLoader()
        let resouce = DropDownResource()
        resouce.getJobsCount { result in
            DispatchQueue.main.async {
                self.dismiss()
                self.jobsCount = result
                self.tableView.reloadData()
            }
            
        }
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
            cell.locationTF.optionArray = locationArray.map{ data in
                return data.location
            }
            cell.specialityTF.optionArray = speacilityArray.map{ data in
                return data.department
            }
            cell.designationTF.optionArray = designationArray.map{ data in
                return data.position
            }
            cell.search.addTarget(self, action: #selector(searchClicked(button:)), for: .touchUpInside)
            cell.deleagte = self
            
            
            return cell
        } else if indexPath.section == 1 {
            let cell: RecentSearchCell
            = tableView.dequeueReusableCell(withIdentifier: "RecentSearchCell") as! RecentSearchCell
            cell.configureCell(with: recentSearchArray)
            cell.deleagte = self
            return cell
        }
        else if indexPath.section == 2 {
            let cell: QuickJobTVCell
            = tableView.dequeueReusableCell(withIdentifier: "QuickJobTVCell") as! QuickJobTVCell
            cell.selectionDelegate = self
            cell.configureCell(with: quickSearchArray)
            
            return cell
        }
        if indexPath.section == 4 {
            let cell: CarrierHighlightCell
            = tableView.dequeueReusableCell(withIdentifier: "CarrierHighlightCell") as! CarrierHighlightCell
            cell.savedBtn.addTarget(self, action: #selector(saveClicked(button:)), for: .touchUpInside)
            cell.appliedBtn.addTarget(self, action: #selector(appliedClicked(button:)), for: .touchUpInside)
            cell.uploadBtn.addTarget(self, action: #selector(uploadClicked(button:)), for: .touchUpInside)
            if let data = jobsCount {
                cell.configureCell(with: data)
            }
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
            cell.configureCell(with: recommendJobsArray)
            cell.selectionDelegate = self
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if recommendJobsArray.count == 0 && indexPath.section == 3 {
            return 0
        }
        if recentSearchArray.count == 0 && indexPath.section == 1 {
            return 0
        }
        if quickSearchArray.count == 0 && indexPath.section == 2 {
            return 0
        }
        return UITableView.automaticDimension
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = UIStoryboard(name: "Home", bundle: nil)
        if indexPath.section == 2 {
            let nextVC = str.instantiateViewController(withIdentifier: "JobsViewController") as! JobsViewController
            // nextVC.detailsModel = allJobsArray[indexPath.row]
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        if indexPath.section == 5 {
            let nextVC = str.instantiateViewController(withIdentifier: "JobDetailsViewController") as! JobDetailsViewController
            nextVC.detailsModel = allJobsArray[indexPath.row]
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    @objc func searchClicked(button: UIButton) {
        
    }
    @objc func saveClicked(button: UIButton) {
        let str = UIStoryboard(name: "Home", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "SavedJobViewController") as! SavedJobViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func appliedClicked(button: UIButton) {
        let str = UIStoryboard(name: "Home", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "AppliedJobViewController") as! AppliedJobViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func uploadClicked(button: UIButton) {
        
    }
}
extension CarrierPageViewController: JobsViewModelDelegate {
    func didReceiveJobsResponse(response: [JobsDataModel]?, error: String?) {
        self.dismiss()
        if error == nil {
            allJobsArray = response ?? []
            tableView.reloadData()
        }
    }
    
    
}
extension CarrierPageViewController: JobCategoryViewModelDelegate {
    func didReceiveTopJobs(response: [JobCategoryDataModel]?, error: String?) {
        self.dismiss()
        quickSearchArray = response ?? []
        tableView.reloadData()
    }
    
    
}
extension CarrierPageViewController: QuickJobCellSelectionDelegate {
    func quickCellSelecte(jobType: String, categoryID: Int) {
        let str = UIStoryboard(name: "Home", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "JobsViewController") as! JobsViewController
        nextVC.jobType = jobType
        nextVC.categoryID = categoryID
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
extension CarrierPageViewController: RecommendedJobSelectionDelegate {
    func recommendedJobSelection(data: JobsDataModel) {
        let str = UIStoryboard(name: "Home", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "JobDetailsViewController") as! JobDetailsViewController
        nextVC.detailsModel = data
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
}
extension CarrierPageViewController: TopJobsViewModelDelegate {
    func didReceiveTopJobs(response: [JobsDataModel]?, error: String?) {
        self.dismiss()
        recommendJobsArray = response ?? []
        tableView.reloadData()
    }
    
    
}

extension CarrierPageViewController: SearchJobDelegate {
    func textFeildSelection(type: String) {
        let str = UIStoryboard(name: "Home", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "DataViewController") as! DataViewController
        nextVC.inputArray =  speacilityArray.map{ data in
            return data.department
        }
      
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func SearchJobDelegate(query: String, jobType: String) {
        let str = UIStoryboard(name: "Home", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "JobsViewController") as! JobsViewController
        nextVC.jobType = jobType
        nextVC.query = true
        nextVC.queryString = query
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
