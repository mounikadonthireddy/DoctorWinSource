//
//  PostQuestionViewController.swift
//  DoctorWin
//
//  Created by N517325 on 10/11/21.
//

import UIKit

class PostQuestionViewController: ViewController {
    var questiondataArry: [QuestionModel] = []
    var questionVM = QuestionsViewModel()
    var questionArray: [QuestionModel] = []
    @IBOutlet weak var replyTableView: UITableView!
    @IBOutlet weak var postTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.replyTableView.register(UINib(nibName: "PostReplyCell", bundle: nil), forCellReuseIdentifier: "PostReplyCell")
        self.replyTableView.register(UINib(nibName: "PostQuestionHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "PostQuestionHeader")
        questionVM.delegate = self
        parse()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    func parse() {
        self.showLoader()
        let userID =  User.shared.userID
        self.questionVM.getQuestionResponseData(userID: "\(userID)")
        
    }

    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func submitClicked(_ sender: Any) {
        postTF.resignFirstResponder()
        if postTF.text?.count != 0 {
            let model = QuestionRequest(question: postTF.text ?? "", user_id: User.shared.userID)
            self.questionVM.postQuestion(question: model, userID: User.shared.userID)
        }
    }
}
extension PostQuestionViewController: QuestionsViewModelDelegate {
    func didPostedQuestion(status: Bool, error: String?) {
        if status == true {
            self.parse()
            postTF.text = ""
        }
    }
    
    func didReceiveQuestionData(response: [QuestionModel]?, error: String?) {
        self.dismiss()
        questionArray = response ?? []
        replyTableView.reloadData()
    }
    
    
}
extension PostQuestionViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return questionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionArray[section].answer?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostReplyCell = tableView.dequeueReusableCell(withIdentifier: "PostReplyCell") as! PostReplyCell
        if let answers = questionArray[indexPath.section].answer {
            cell.configureCell(with: answers[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: PostQuestionHeader.identifier) as? PostQuestionHeader {
            headerView.configureCell(with: questionArray[section])
            //
            return headerView
        }
        
        return nil
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 180
    }
}

extension PostQuestionViewController : UITableViewDelegate {
    
}


struct QuestionModel: Codable {
    let question: String
    let create : String
    let like: Bool
    let question_likes: Int
    let id: Int
    let answer : [Answers]?
    let profile: Profile
}
struct Answers: Codable {
    let id: Int
    let comment: String
    let create: String
    let profile: Profile
    let like: [Int]?
}
struct Profile: Codable {
    let id: Int
    let profile_name : String
    let profileImage: String?
}
struct QuestionRequest: Codable {
    let question: String
    let  user_id: String
}
