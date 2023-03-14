//
//  CaseDetailsViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 20/04/22.
//

import UIKit

class CaseDetailsViewController: ViewController {
    
    @IBOutlet weak var HomeDetailsTableView: UITableView!
    var detailsModel : CaseDetailsModel?
    var viewModel = DetailsViewModel()
    var caseId = 0
    var displayStaus = 0
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
        self.loadComments()
        self.loadCaseDetails()
    }
    func loadCaseDetails() {
        self.showLoader()
        viewModel.getCaseDetails(displayStatus: displayStaus, caseId: caseId)
    }
    func loadComments() {
        self.showLoader()
        viewModel.getComments(displayStatus: displayStaus, caseId: caseId)
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
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return commentsArray.count
        } else if section == 0 {
            if detailsModel != nil {
                return 1
            } else {
                return 0
            }
        }

        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: CaseDetailsCell
            = tableView.dequeueReusableCell(withIdentifier: "CaseDetailsCell") as! CaseDetailsCell
            if let data = detailsModel {
                cell.configureCellWith(data: data)
            }
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
    func didReciveCommentsList(response: commentsReponseModel?, error: String?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss()
            self.commentsArray = response?.userDetails ?? []
            self.HomeDetailsTableView.reloadData()
        }
    }
    
    func didReciveCaseDetails(response: CaseReponseModel?, error: String?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss()
            if let data = response?.homeResponse {
                self.detailsModel = data
                self.HomeDetailsTableView.reloadData()
            }
        }
    }
    
}
