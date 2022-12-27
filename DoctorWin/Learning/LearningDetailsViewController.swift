//
//  LearningDetailsViewController.swift
//  DoctorWin
//
//  Created by AHP on 13/10/2565 BE.
//

import UIKit

class LearningDetailsViewController: ViewController {
    @IBOutlet weak var tableView: UITableView!
    var detailsVM = LearningDetailsVieModel()
    var courseDetails : CourseDetailsModel?
    var curriculamArray : [CurriculamModel] = []
    var subject: String = "2"
    var selectedIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "LearningDetailsHeaderCell", bundle: nil), forCellReuseIdentifier: "LearningDetailsHeaderCell")
        tableView.register(UINib(nibName: "LearningOverViewCell", bundle: nil), forCellReuseIdentifier: "LearningOverViewCell")
        tableView.register(UINib(nibName: "CurriculamCell", bundle: nil), forCellReuseIdentifier: "CurriculamCell")
        tableView.register(UINib(nibName: "CourseBuyCell", bundle: nil), forCellReuseIdentifier: "CourseBuyCell")

        detailsVM.delegate = self
        loadCourseDetails()
        loadCurriculamDetails()
        // Do any additional setup after loading the view.
    }
    func loadCourseDetails() {
       // self.showLoader()
        detailsVM.getElearningCourseDetails(userID: User.shared.userID, subjectId: subject)
    }
    func loadCurriculamDetails() {
       // self.showLoader()
        detailsVM.getCurriculamDetails(userID: User.shared.userID, subjectId: subject)
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
extension LearningDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 360
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 && selectedIndex == 2 {
            return courseDetails?.buy?.count ?? 0
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: LearningDetailsHeaderCell
            = tableView.dequeueReusableCell(withIdentifier: "LearningDetailsHeaderCell") as! LearningDetailsHeaderCell
            if let data = courseDetails {
                cell.configureCell(data: data)
            }
            cell.backBtn.addTarget(self, action: #selector(backClicked(button:)), for: .touchUpInside)
            cell.interfaceSegmented.delegate = self
            return cell
        } else {
            if selectedIndex == 0 {
                let cell: LearningOverViewCell
                = tableView.dequeueReusableCell(withIdentifier: "LearningOverViewCell") as! LearningOverViewCell
                if let data = courseDetails?.overView {
                    cell.configureCell(data: data)
                }
                return cell
            } else if selectedIndex == 1 {
                let cell: CurriculamCell
                = tableView.dequeueReusableCell(withIdentifier: "CurriculamCell") as! CurriculamCell
                if let data = courseDetails?.Curriculum {
                cell.loadCellData(array: data)
                }
                return cell
            } else if selectedIndex == 2 {
                let cell: CourseBuyCell
                = tableView.dequeueReusableCell(withIdentifier: "CourseBuyCell") as! CourseBuyCell
                if let data = courseDetails?.buy {
                    cell.cellloadData(data: data[indexPath.row])
                }
                return cell
            }
            
            else {
                return UITableViewCell()
            }
            
            
        }
    }
    
    @objc func backClicked(button: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension LearningDetailsViewController: LearningDetailsVieModelDelegate {
    func didReciveCurriculamDetails(response: [CurriculamModel]?, error: String?) {
        self.dismiss()
        curriculamArray = response ?? []
        tableView.reloadData()
    }
    
    func didReciveCourseDetails(response: CourseDetailsModel?, error: String?) {
        self.dismiss()
        if let data = response {
            courseDetails = data
            tableView.reloadData()
        }
    }
    
    
}
extension LearningDetailsViewController: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        selectedIndex = index
        tableView.reloadData()
    }
    
    
}
