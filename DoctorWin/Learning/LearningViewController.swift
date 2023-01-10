//
//  LearningViewController.swift
//  DoctorWin
//
//  Created by AHP on 12/10/2565 BE.
//

import UIKit

class LearningViewController: ViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBtn: UIButton!
    
    var learningVM = LearningViewModel()
    var bannerArray: [ElearningBannerModel] = []
    var trendingCourseArray: [LearningModel] = []
    var coursesArray: [CoursesModel] = []
    var categoriesArray: [CoursesCategoryModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "LearningImageBannerCell", bundle: nil), forCellReuseIdentifier: "LearningImageBannerCell")
        tableView.register(UINib(nibName: "LearningCategoryCell", bundle: nil), forCellReuseIdentifier: "LearningCategoryCell")
        tableView.register(UINib(nibName: "CourseCategoryCell", bundle: nil), forCellReuseIdentifier: "CourseCategoryCell")
        
        learningVM.delegate = self
        searchBtn.setCornerRadius(radius: 10)
        // Do any additional setup after loading the view.
        self.loadBannerImages()
        self.loadTrendingCourses()
       // self.loadCourses()
        self.loadCoursesCategories()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    func loadBannerImages() {
        self.showLoader()
        learningVM.getElearningBanner(userID: User.shared.userID)
    }
    func loadTrendingCourses() {
        self.showLoader()
        learningVM.getTrendingCourses(userID: User.shared.userID)
    }
//    func loadCourses() {
//        self.showLoader()
//        learningVM.getCourses(userID: User.shared.userID)
//    }
    func loadCoursesCategories() {
        self.showLoader()
        learningVM.getCoursesCategeries(userID: User.shared.userID)
    }
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
   
}
extension LearningViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            if bannerArray.count > 0 {
                return 1
            } else {
                return 0
            }
           
        } else if section == 0 {
            return 1
        } else if section == 2 {
            return trendingCourseArray.count
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            
            let cell: LearningImageBannerCell
            = tableView.dequeueReusableCell(withIdentifier: "LearningImageBannerCell") as! LearningImageBannerCell
            cell.setBannerImage(data: bannerArray)
            return cell
        }
       else if indexPath.section == 0 {
            
            let cell: CourseCategoryCell
            = tableView.dequeueReusableCell(withIdentifier: "CourseCategoryCell") as! CourseCategoryCell
           cell.configureCell(data: categoriesArray)
           cell.delegate = self
            return cell
        }
        else {
            let cell: LearningCategoryCell
            = tableView.dequeueReusableCell(withIdentifier: "LearningCategoryCell") as! LearningCategoryCell
            cell.delegate = self
            cell.getCourseArray(data: trendingCourseArray[indexPath.row].subjects ?? [], title: trendingCourseArray[indexPath.row].suggest ?? "")
            return cell
        }
    }
    
    
}
extension LearningViewController: LearningViewModelDelegate {
    func didReciveTrendingCourses(response: [LearningModel]?, error: String?) {
        self.dismiss()
        trendingCourseArray = response ?? []
        tableView.reloadData()
    }
    
    func didReciveCategories(response: [CoursesCategoryModel]?, error: String?) {
        self.dismiss()
        categoriesArray = response ?? []
        tableView.reloadData()
    }
    
    func didReciveCourses(response: [CoursesModel]?, error: String?) {
        self.dismiss()
        coursesArray = response ?? []
        tableView.reloadData()
    }
    
    func didReciveBannerImage(response: [ElearningBannerModel]?, error: String?) {
        self.dismiss()
        bannerArray = response ?? []
        tableView.reloadData()
    }
    
    func didReciveTrendingCourses(response: [CoursesCategoryModel]?, error: String?) {
        self.dismiss()
       // trendingCourseArray = response ?? []
        tableView.reloadData()
    }
}
extension LearningViewController: ElearingCellSelected {
    func selectedCellWith(data: CourseModel) {
        let str = UIStoryboard(name: "Learning", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "LearningDetailsViewController") as! LearningDetailsViewController
        nextVC.subject = "\(data.id)"
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}
extension LearningViewController: CategeryCellSelectedDelegate {
    func selectedWith(data: CoursesCategoryModel) {
        let str = UIStoryboard(name: "Learning", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "LearningCategoryViewController") as! LearningCategoryViewController
        nextVC.subjectId = "\(data.id)"
        nextVC.subject = data.name_of_course ?? ""
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}
