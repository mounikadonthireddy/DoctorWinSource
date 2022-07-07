//
//  MCQViewController.swift
//  DoctorWin
//
//  Created by AHP on 04/07/2565 BE.
//

import UIKit

class MCQViewController: ViewController {

    @IBOutlet weak var tableView: UITableView!
    var questionsArray:[ExamsModel] = []
    var viewModel = MCQViewModel()
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["All Mcqs","Attempted Mcqs","About"])
            interfaceSegmented.selectorViewColor = .black
            interfaceSegmented.selectorTextColor = .black
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "ExamCell", bundle: nil), forCellReuseIdentifier: "ExamCell")
        interfaceSegmented.delegate = self
        viewModel.delegate = self
        self.loadMCQdata()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadMCQdata() {
        self.showLoader()
        viewModel.getMCQData(userID: User.shared.userID, index: 0)
        
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
extension MCQViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ExamCell
        = tableView.dequeueReusableCell(withIdentifier: "ExamCell") as! ExamCell
        cell.configureData(homeModel: questionsArray[indexPath.row])
        cell.explainBtn.addTarget(self, action: #selector(explainClicked(button:)), for: .touchUpInside)
        
        cell.explainBtn.tag = indexPath.row
        return cell
    }
    @objc func explainClicked(button: UIButton) {
        let str = UIStoryboard(name: "Details", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "ExamDetailsViewController") as! ExamDetailsViewController
        nextVC.examData = questionsArray[button.tag]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
extension MCQViewController: MCQViewModelDelegate {
    func didReciveMCQData(response: [ExamsModel]?, error: String?) {
        self.dismiss()
       questionsArray = response ?? []
        self.tableView.reloadData()
    }
    
    
}
extension MCQViewController: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        self.showLoader()
        self.viewModel.getMCQData(userID: User.shared.userID, index: index)
    }
    
    
}

struct ExamsModel: Codable {
    let id: Int
    let exam: String
    let question: String
    let subject: String
    let option1: String
    let option2: String
    let option3: String
    let option4: String
    let correct_answer: String
    let detail: String
    let status: Bool
    let user: Int
    let username: String
    let  selected_option: String?
    let answer_status: Bool
    let profileName: String
    let follow: Bool
    let profileImage: String
}
