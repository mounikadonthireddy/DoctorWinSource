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
    @IBOutlet weak var topView: UIView!
    var carrierJobArray :[JobModel] = []
    var categoryJobsViewModel = JobCategoryViewModel()
    var jobsVM = JobsViewModel()
    var quickSearchArray:[JobCategoryModel] = []
    var sectionArray = ["Explore Jobs","Post Jobs", "Saved Jobs", "Applied Jobs"]
    override func viewDidLoad() {
        super.viewDidLoad()
       
        categoryJobsViewModel.delegate = self
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.white
        configureCompositionalLayout()
       
        collectionView.register(UINib.init(nibName: "CarrierCategoryCell", bundle: nil), forCellWithReuseIdentifier: "CarrierCategoryCell")
        collectionView.register(UINib.init(nibName: "JobCVCell", bundle: nil), forCellWithReuseIdentifier: "JobCVCell")
        collectionView.register(UINib.init(nibName: "ImageSectionCell", bundle: nil), forCellWithReuseIdentifier: "ImageSectionCell")
        collectionView.register(UINib.init(nibName: "CourseNameCell", bundle: nil), forCellWithReuseIdentifier: "CourseNameCell")
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: headerKind, withReuseIdentifier: Key.ReusableIdentifiers.sectionHeaderViewId)
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
        jobsVM.getAllJobData(pageNum: 1)
    }
    func parse() {
        self.showLoader()
        categoryJobsViewModel.getTopRecommendedJobs(userID: User.shared.userID)
    }
    @IBAction func searchClicked(_ sender: UIButton) {
        let str = UIStoryboard(name: "Job", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "SearchJobsViewController") as! SearchJobsViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }

}

extension CarrierTabViewController: JobCategoryViewModelDelegate {
    func didReceiveTopJobs(response: JobCategoryResponseModel?, error: String?) {
        self.dismiss()
        quickSearchArray = response?.jobResponse ?? []
        collectionView.reloadData()
    }
    
    
}
extension CarrierTabViewController: JobsViewModelDelegate {
    func didReceiveCarrierResponse(response: JobResponseModel?, error: String?) {
        self.dismiss()
        if error == nil {
            carrierJobArray = response?.jobResponse ?? []
            collectionView.reloadData()
        }
    }
    
    func didReceiveJobsResponse(response: JobResponseModel?, error: String?) {
        self.dismiss()
    }
}

extension CarrierTabViewController: QuickJobCellSelectionDelegate {
    func quickCellSelecte(jobType: String, categoryID: Int) {
        let str = UIStoryboard(name: "Job", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "JobsViewController") as! JobsViewController
        nextVC.jobType = jobType
        nextVC.categoryID = categoryID
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
extension CarrierTabViewController: RecommendedJobSelectionDelegate {
    func recommendedJobSelection(data: JobsDataModel) {
        let str = UIStoryboard(name: "Details", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "JobDetailsViewController") as! JobDetailsViewController
        nextVC.detailsModel = data
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
}



extension CarrierTabViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func configureCompositionalLayout() {
        
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, env) in
            if sectionNumber == 0  {
                return LayoutType.headerImageSectionLayout.getLayout()
            } else if sectionNumber == 1 {
                return LayoutType.namesLayout.getLayout()
            } else if sectionNumber == 2 && self.quickSearchArray.count > 0 {
                return LayoutType.categoryLayout.getLayout()
            } else if sectionNumber == 3 {
                return LayoutType.fullViewLayout.getLayout(withHeader: true,height: 270)
            }  else {
                return LayoutType.emptyView.getLayout()
            }
        }
        
        layout.register(SectionDecorationView.self, forDecorationViewOfKind: sectionBackground)
        collectionView.setCollectionViewLayout(layout, animated: true )
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return sectionArray.count
        }else if section == 2 {
            return quickSearchArray.count
        } else if section == 3 {
            return carrierJobArray.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell: ImageSectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageSectionCell", for: indexPath) as! ImageSectionCell
            return cell
        } else if indexPath.section == 1 {
            let cell: CourseNameCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseNameCell", for: indexPath) as! CourseNameCell
            cell.name.text = sectionArray[indexPath.row]
            if cell.isSelected {
                cell.name.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                cell.name.textColor = #colorLiteral(red: 0, green: 0.381624639, blue: 0.6041520834, alpha: 1)
            }
            cell.setCornerRadiusWithBorderColor(radius: 10, color: #colorLiteral(red: 0, green: 0.381624639, blue: 0.6041520834, alpha: 1), borderWidth: 0.8)
            return cell
            
        } else if indexPath.section == 2 {
            let cell: CarrierCategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarrierCategoryCell", for: indexPath) as! CarrierCategoryCell
            cell.configureCell(with: quickSearchArray[indexPath.row])
            return cell
        } else {
            let cell: JobCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "JobCVCell", for: indexPath) as! JobCVCell
            cell.configureCell(with: carrierJobArray[indexPath.row])
            return cell
        }
       
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Key.ReusableIdentifiers.sectionHeaderViewId, for: indexPath) as! SectionHeaderView
            
            return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            let str = UIStoryboard(name: "Details", bundle: nil)
            let nextVC = str.instantiateViewController(withIdentifier: "CarrierJobDetailsViewController") as! CarrierJobDetailsViewController
            nextVC.jobId = carrierJobArray[indexPath.row].id
            self.navigationController?.pushViewController(nextVC, animated: true)
        } else if indexPath.section == 2 {
            let str = UIStoryboard(name: "Job", bundle: nil)
            let nextVC = str.instantiateViewController(withIdentifier: "JobsViewController") as! JobsViewController
            nextVC.jobType = quickSearchArray[indexPath.row].category ?? ""
            nextVC.categoryID = quickSearchArray[indexPath.row].id ?? 0
            
            self.navigationController?.pushViewController(nextVC, animated: true)
        } else if indexPath.section == 1 {
            self.navigateViewBasedOnSection(index: indexPath.row)
        }
        
    }
    func navigateViewBasedOnSection(index: Int) {
        if index == 0 {
            
        } else if index == 2 {
            let str = UIStoryboard(name: "Job", bundle: nil)
            let nextVC = str.instantiateViewController(withIdentifier: "SavedJobViewController") as! SavedJobViewController
            
            self.navigationController?.pushViewController(nextVC, animated: true)
        } else if index == 3 {
            let str = UIStoryboard(name: "Job", bundle: nil)
            let nextVC = str.instantiateViewController(withIdentifier: "AppliedJobViewController") as! AppliedJobViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
        } else if index == 3 {
  
        }
    }
}
