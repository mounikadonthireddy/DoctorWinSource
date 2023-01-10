//
//  LearningCategoryViewController.swift
//  DoctorWin
//
//  Created by AHP on 13/10/2565 BE.
//

import UIKit

class LearningCategoryViewController: ViewController {
    var subject: String = ""
    var subjectId: String = ""
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var vidoes: UIButton!
    @IBOutlet weak var qBank: UIButton!
    var array: [LearningCategoryModel] = []
    var categoryVm = LearningCategoryViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.dropShadow()
        tableView.register(UINib(nibName: "CategoryTVCell", bundle: nil), forCellReuseIdentifier: "CategoryTVCell")
        categoryVm.delegate = self
        titleLbl.text = "    " + subject
        loadCourses()
        vidoes.setCornerRadiusWithBorderColor(radius: Float(vidoes.frame.height)/2, color: UIColor(rgb: 0x90FF1A), borderWidth: 0.5)
        qBank.setCornerRadiusWithBorderColor(radius: Float(qBank.frame.height)/2, color: UIColor(rgb: 0x90FF1A), borderWidth: 0.5)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func loadCourses() {
     self.showLoader()
        categoryVm.getCourses(userID: User.shared.userID, subId: subjectId)
    }

    @IBAction func videosClicked(_ sender: UIButton) {
        vidoes.backgroundColor = UIColor(rgb: 0xDAFFB3)
        qBank.backgroundColor = .white
    }
    @IBAction func qBankClicked(_ sender: UIButton) {
        qBank.backgroundColor = UIColor(rgb: 0xDAFFB3)
        vidoes.backgroundColor = .white
    }
}
extension LearningCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CategoryTVCell
        = tableView.dequeueReusableCell(withIdentifier: "CategoryTVCell") as! CategoryTVCell
        cell.configureCell(data: array[indexPath.row])
       // cell.setBannerImage(data: bannerArray[0])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = UIStoryboard(name: "Learning", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "LearningDetailsViewController") as! LearningDetailsViewController
       // nextVC.subject = "\(array[indexPath.row].id)"
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
extension LearningCategoryViewController: LearningCategoryViewModelDelegate {
    func didReciveCategoyBasedCourses(response: [LearningCategoryModel]?, error: String?) {
        self.dismiss()
        array = response ?? []
        tableView.reloadData()
    }

}
extension UINavigationBar {
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 0)
    }
}
