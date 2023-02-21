//
//  FellowshipViewController.swift
//  DoctorWin
//
//  Created by AHP on 11/01/2566 BE.
//

import UIKit

class FellowshipViewController: ViewController {
    @IBOutlet weak var fellowshipTableview: UITableView!
    var fellowshipArray: [FellowshipModel] = []
    var courseArray: [LearningCategoryModel] = []
    var fellowshipVM = FellowshipViewModel()
    var selectedText: String = "All"
    override func viewDidLoad() {
        super.viewDidLoad()
        fellowshipTableview.register(UINib(nibName: "FellowshipTVell", bundle: nil), forCellReuseIdentifier: "FellowshipTVell")
        fellowshipTableview.register(UINib(nibName: "CourseCategoryCell", bundle: nil), forCellReuseIdentifier: "CourseCategoryCell")
        fellowshipVM.delegate = self
        loadData()
    }
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func loadData() {
        // self.showLoader()
        fellowshipVM.getFellowshipData(categoryName: "All")
    }
    
}

extension FellowshipViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: FellowshipTVell
        = tableView.dequeueReusableCell(withIdentifier: "FellowshipTVell") as! FellowshipTVell
        cell.loadData(array: fellowshipArray, array1: courseArray, selected: selectedText)
        return cell
        
    }
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        if indexPath.section == 0 {
    //            return 35
    //        } else {
    //            return UITableView.automaticDimension
    //        }
    //    }
}


extension FellowshipViewController: FellowshipViewModelDelegate {
    func didReciveFellowshipCourses(response: LearningCategoryResponseModel?, error: String?) {
        self.dismiss()
        courseArray = response?.learnResponse ?? []
        print(courseArray)
        fellowshipTableview.reloadData()
    }
    
    
}
