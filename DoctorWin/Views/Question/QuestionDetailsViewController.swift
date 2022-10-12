//
//  QuestionDetailsViewController.swift
//  DoctorWin
//
//  Created by AHP on 10/10/2565 BE.
//

import UIKit

class QuestionDetailsViewController: ViewController {
    @IBOutlet weak var tableView: UITableView!

    var repleisData: RepliesModel?
    var questionVM = QuestionsViewModel()
    var pageNumber = 1
    var loadingData = true
    var questionId: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.register(UINib(nibName: "ReplyCell", bundle: nil), forCellReuseIdentifier: "ReplyCell")
        tableView.register(UINib(nibName: "QuestionHeaderCell", bundle: nil), forCellReuseIdentifier: "QuestionHeaderCell")
        
        tableView.register(TrendingQuestionHeaderView.nib, forHeaderFooterViewReuseIdentifier: TrendingQuestionHeaderView.identifier)
        questionVM.delegate2 = self
     loadPostedReplies(pageNum: 1)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func loadPostedReplies(pageNum: Int) {
        self.showLoader()
        questionVM.getRepliesPostedQuestions(userID: User.shared.userID,page: pageNum, questionId: "\(questionId ?? 0)")
    }
}
extension QuestionDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return repleisData?.reply_by?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: QuestionHeaderCell
            = tableView.dequeueReusableCell(withIdentifier: "QuestionHeaderCell") as! QuestionHeaderCell
            if let data = repleisData {
                cell.questionLbl.text = data.asked_question ?? ""
            }
            cell.backBtn.addTarget(self, action: #selector(backClicked(button:)), for: .touchUpInside)
            
           // cell.configure(data: trendingQuestions)
            return cell
        } else {
        let cell: ReplyCell
        = tableView.dequeueReusableCell(withIdentifier: "ReplyCell") as! ReplyCell
            if let data = repleisData?.reply_by {
                cell.configureDataWith(homeModel: data[indexPath.row])
            }
        return cell
        }
    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TrendingQuestionHeaderView.identifier) as? TrendingQuestionHeaderView {
//            if section == 0 {
//                headerView.nameLbl.text  = "Trending QnA"
//            } else {
//                headerView.nameLbl.text  = "Questions for you"
//            }
//          
//            return headerView
//        }
//        return nil
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
//    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let lastElement = questionsArray.count - 1
//        if !loadingData && indexPath.row == lastElement {
//            self.showLoader()
//            loadingData = true
//            pageNumber += 1
//            self.loadPostedQuestions(pageNum: pageNumber)
//        }
//    }
    
    @objc func backClicked(button: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension QuestionDetailsViewController: RepliesViewModelDelegate {
    func didReceiveUserRepliesData(response: RepliesModel?, error: String?) {
        self.dismiss()
        if let data  = response {
            repleisData = data
            tableView.reloadData()
        }
    }
    
    
}
