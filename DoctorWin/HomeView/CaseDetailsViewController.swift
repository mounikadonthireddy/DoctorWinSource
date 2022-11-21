//
//  CaseDetailsViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 20/04/22.
//

import UIKit

class CaseDetailsViewController: ViewController {
    
    @IBOutlet weak var HomeDetailsTableView: UITableView!
    var detailsModel : HomeDataModel?
    var viewModel = DetailsViewModel()
    var caseId = 0
    var commentsArray: [CommentModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        HomeDetailsTableView.register(UINib(nibName: "HomeDetailsHeaderCell", bundle: nil), forCellReuseIdentifier: "HomeDetailsHeaderCell")
        HomeDetailsTableView.register(UINib(nibName: "HomeDetailsImageCell", bundle: nil), forCellReuseIdentifier: "HomeDetailsImageCell")
        
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
        viewModel.getComments(userID: User.shared.userID, caseId: "\(caseId)")
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    @IBAction func backClikced(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
 
}
extension CaseDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = detailsModel {
            if section == 3 {
                return commentsArray.count
            } else if section == 1 {
                return 0
            } else {
                //            return detailsModel.commentsArray?.count ?? 0
                return 1
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: HomeDetailsHeaderCell
            = tableView.dequeueReusableCell(withIdentifier: "HomeDetailsHeaderCell") as! HomeDetailsHeaderCell
            cell.configureData(homeModel: detailsModel!)
            return cell
        } else  if indexPath.section == 1 {
            let cell: CaseDetailsCell
            = tableView.dequeueReusableCell(withIdentifier: "CaseDetailsCell") as! CaseDetailsCell
            
            return cell
        } else if indexPath.section == 2 {
            let cell: HomeDetailsImageCell
            = tableView.dequeueReusableCell(withIdentifier: "HomeDetailsImageCell") as! HomeDetailsImageCell
            cell.configureData(homeModel: detailsModel!)
            return cell
        } else {
            let cell: CommentsCell
            = tableView.dequeueReusableCell(withIdentifier: "CommentsCell") as! CommentsCell
                    cell.configureCellWith(data: commentsArray[indexPath.row])
            return cell
        }
    }
    
    
    
}
extension CaseDetailsViewController: CaseDetailsDelegate {
    func didReciveCommentsList(response: [CommentModel]?, error: String?) {
        self.dismiss()
        commentsArray = response ?? []
        self.HomeDetailsTableView.reloadData()
    }
    
    func didReciveCaseDetails(response: CaseDetails?, error: String?) {
        self.dismiss()
    }
    
}
