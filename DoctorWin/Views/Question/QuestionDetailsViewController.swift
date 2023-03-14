//
//  QuestionDetailsViewController.swift
//  DoctorWin
//
//  Created by AHP on 10/10/2565 BE.
//

import UIKit

class QuestionDetailsViewController: ViewController,ExpandableLabelDelegate {
    @IBOutlet weak var tableView: UITableView!
    var states : Array<Bool>!
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
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
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
            return repleisData?.AnswersList?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: QuestionHeaderCell
            = tableView.dequeueReusableCell(withIdentifier: "QuestionHeaderCell") as! QuestionHeaderCell
            if let data = repleisData {
                cell.questionLbl.text = data.question ?? ""
            }
            cell.backBtn.addTarget(self, action: #selector(backClicked(button:)), for: .touchUpInside)
            cell.answer.addTarget(self, action: #selector(answerClicked(button:)), for: .touchUpInside)
            
            // cell.configure(data: trendingQuestions)
            return cell
        } else {
            let cell: ReplyCell
            = tableView.dequeueReusableCell(withIdentifier: "ReplyCell") as! ReplyCell
            if let data = repleisData?.AnswersList {
                cell.configureDataWith(homeModel: data[indexPath.row])
                cell.titleLable.delegate = self
                cell.titleLable.setLessLinkWith(lessLink: "Close", attributes: [.foregroundColor:UIColor.red], position: .left)
                cell.layoutIfNeeded()
                cell.titleLable.shouldCollapse = true
                cell.titleLable.textReplacementType = .character
                cell.titleLable.numberOfLines = 5
                cell.titleLable.collapsed = states[indexPath.row]
//                if !states[indexPath.row] {
//                    if let _ =  data[indexPath.row].image {
//                        cell.imageHeiht.constant = 300
//                    }
//                else {
//                    cell.imageHeiht.constant = 0
//                }
//            }
//                else {
//                    cell.imageHeiht.constant = 0
//                }
                cell.titleLable.text = data[indexPath.row].text_description ?? ""
            }
            return cell
        }
    }
    @objc   func willExpandLabel(_ label: ExpandableLabel) {
         tableView.beginUpdates()
    }
    
    @objc  func didExpandLabel(_ label: ExpandableLabel) {
        let point = label.convert(CGPoint.zero, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point) as IndexPath? {
            states[indexPath.row] = false
            DispatchQueue.main.async { [weak self] in
                self?.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
        tableView.endUpdates()
        tableView.reloadData()
    }
    
    @objc func willCollapseLabel(_ label: ExpandableLabel) {
        tableView.beginUpdates()
    }
    
    @objc  func didCollapseLabel(_ label: ExpandableLabel) {
        let point = label.convert(CGPoint.zero, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point) as IndexPath? {
            
            states[indexPath.row] = true
            DispatchQueue.main.async { [weak self] in
                self?.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
        tableView.endUpdates()
        tableView.reloadData()
    }
    
    @objc func backClicked(button: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func answerClicked(button: UIButton) {
        let str = UIStoryboard(name: "Add", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "AddAnswerViewController") as! AddAnswerViewController
        nextVC.askedQuestion = repleisData?.question ?? ""
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
extension QuestionDetailsViewController: RepliesViewModelDelegate {
    func didReceiveUserRepliesData(response: RepliesModel?, error: String?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss()
            if let data  = response {
                self.repleisData = data
                self.states = [Bool](repeating: true, count: response?.AnswersList?.count ?? 0)
                self.tableView.reloadData()
            }
        }
    }
    
}
