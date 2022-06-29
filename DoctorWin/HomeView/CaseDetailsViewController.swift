//
//  CaseDetailsViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 20/04/22.
//

import UIKit

class CaseDetailsViewController: ViewController {

    @IBOutlet weak var HomeDetailsTableView: UITableView!
    var detailsModel : HomeDataModel!
    var viewModel = DetailsViewModel()
    var caseId = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
        HomeDetailsTableView.register(UINib(nibName: "CaseDetailsCell", bundle: nil), forCellReuseIdentifier: "CaseDetailsCell")
        HomeDetailsTableView.register(UINib(nibName: "CommentsCell", bundle: nil), forCellReuseIdentifier: "CommentsCell")

        tabBarController?.tabBar.isHidden = true
        self.HomeDetailsTableView.delegate = self
        self.HomeDetailsTableView.dataSource = self
        // Do any additional setup after loading the view.
        self.loadCaseDetails()
    }
    func loadCaseDetails() {
        self.showLoader()
        viewModel.getCaseDetails(userID: User.shared.userID, caseId: "\(caseId)")
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    @IBAction func backClikced(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
extension CaseDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
//            return detailsModel.commentsArray?.count ?? 0
            return 0
        }
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
        let cell: CaseDetailsCell
            = tableView.dequeueReusableCell(withIdentifier: "CaseDetailsCell") as! CaseDetailsCell
      //  cell.configureCellWith(data: detailsModel)
        return cell
        } else {
            let cell: CommentsCell
                = tableView.dequeueReusableCell(withIdentifier: "CommentsCell") as! CommentsCell
//            cell.configureCellWith(data: detailsModel.commentsArray![indexPath.row])
            return cell
        }
    }
   
    
    
}
extension CaseDetailsViewController: CaseDetailsDelegate {
    func didReciveCaseDetails(response: CaseDetails?, error: String?) {
        self.dismiss()
    }
    
}
