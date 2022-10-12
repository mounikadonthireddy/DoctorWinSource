//
//  LearningViewController.swift
//  DoctorWin
//
//  Created by AHP on 12/10/2565 BE.
//

import UIKit

class LearningViewController: ViewController {
    @IBOutlet weak var tableView: UITableView!
    var learningVM = LearningViewModel()
    var bannerArray: [ElearningBannerModel] = []
    var trendingCourseArray: [CourseModel] = []
    var coursesArray: [CoursesModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "LearningImageBannerCell", bundle: nil), forCellReuseIdentifier: "LearningImageBannerCell")
        tableView.register(UINib(nibName: "LearningCategoryCell", bundle: nil), forCellReuseIdentifier: "LearningCategoryCell")
        learningVM.delegate = self
        // Do any additional setup after loading the view.
        self.loadBannerImages()
        self.loadTrendingCourses()
        self.loadCourses()
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
    func loadCourses() {
        self.showLoader()
        learningVM.getCourses(userID: User.shared.userID)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension LearningViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bannerArray.count
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return coursesArray.count
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            let cell: LearningImageBannerCell
            = tableView.dequeueReusableCell(withIdentifier: "LearningImageBannerCell") as! LearningImageBannerCell
            cell.setBannerImage(data: bannerArray[0])
            return cell
        } else {
            
            let cell: LearningCategoryCell
            = tableView.dequeueReusableCell(withIdentifier: "LearningCategoryCell") as! LearningCategoryCell
            if indexPath.section == 1 {
                cell.getCourseArray(data: trendingCourseArray, title: "Trending Courses")
            } else if indexPath.section == 2 {
                cell.getCourseArray(data: coursesArray[indexPath.row].course ?? [], title: coursesArray[indexPath.row].name ?? "")
            }
            return cell
        }
    }
    
    
}
extension LearningViewController: LearningViewModelDelegate {
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
    
    func didReciveTrendingCourses(response: [CourseModel]?, error: String?) {
        self.dismiss()
        trendingCourseArray = response ?? []
        tableView.reloadData()
    }
    
   
    
    
}
