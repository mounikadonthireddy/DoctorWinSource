//
//  CarrierTabViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 22/04/22.
//

import UIKit

class CarrierTabViewController: ViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var tableView: UITableView!
    var carrierJobArray :[CarrierModel] = []
    var categoryJobsViewModel = JobCategoryViewModel()
    var jobsVM = JobsViewModel()
    var quickSearchArray:[JobCategoryDataModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInsetAdjustmentBehavior = .never
        categoryJobsViewModel.delegate = self
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.white
        
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        tableView.register(UINib.init(nibName: "CarrierJobCell", bundle: nil), forCellReuseIdentifier: "CarrierJobCell")
        
        collectionView.register(UINib.init(nibName: "CarrierCategoryCell", bundle: nil), forCellWithReuseIdentifier: "CarrierCategoryCell")

        tableView.register(TitleView.nib, forHeaderFooterViewReuseIdentifier: TitleView.identifier)
        
        jobsVM.delegate = self
        parse()
        parse1()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = false
        
    }
    
    func parse1() {
        self.showLoader()
        jobsVM.getAllJobData(userID: User.shared.userID)
    }
    func parse() {
        self.showLoader()
        categoryJobsViewModel.getTopRecommendedJobs(userID: User.shared.userID)
    }
    
}
extension CarrierTabViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carrierJobArray.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CarrierJobCell
        = tableView.dequeueReusableCell(withIdentifier: "CarrierJobCell") as! CarrierJobCell
        cell.configureCell(with: carrierJobArray[indexPath.row])
        return cell
        
        
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
       //     nextVC.detailsModel = allJobsArray[indexPath.row]
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    
}
extension CarrierTabViewController: JobCategoryViewModelDelegate {
    func didReceiveTopJobs(response: [JobCategoryDataModel]?, error: String?) {
        self.dismiss()
        quickSearchArray = response ?? []
        collectionView.reloadData()
    }
    
    
}
extension CarrierTabViewController: JobsViewModelDelegate {
    func didReceiveCarrierResponse(response: [CarrierModel]?, error: String?) {
        self.dismiss()
        if error == nil {
            carrierJobArray = response ?? []
            tableView.reloadData()
        }
    }
    
    func didReceiveJobsResponse(response: [JobsDataModel]?, error: String?) {
        self.dismiss()
    }
    
    
}

extension CarrierTabViewController: QuickJobCellSelectionDelegate {
    func quickCellSelecte(jobType: String, categoryID: Int) {
        let str = UIStoryboard(name: "Home", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "JobsViewController") as! JobsViewController
        nextVC.jobType = jobType
        nextVC.categoryID = categoryID
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
extension CarrierTabViewController: RecommendedJobSelectionDelegate {
    func recommendedJobSelection(data: JobsDataModel) {
        let str = UIStoryboard(name: "Home", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "JobDetailsViewController") as! JobDetailsViewController
        nextVC.detailsModel = data
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
}



extension CarrierTabViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quickSearchArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CarrierCategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarrierCategoryCell", for: indexPath) as! CarrierCategoryCell
        cell.configureCell(with: quickSearchArray[indexPath.row])
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let yourWidth = 160
        return CGSize(width: yourWidth, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //.zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
}
