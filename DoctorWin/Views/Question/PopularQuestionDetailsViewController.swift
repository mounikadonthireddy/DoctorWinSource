//
//  PopularQuestionDetailsViewController.swift
//  DoctorWin
//
//  Created by AHP on 12/10/2565 BE.
//

import UIKit

class PopularQuestionDetailsViewController: ViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var repleisData: RepliesModel?
    var questionVM = QuestionsViewModel()
    var pageNumber = 1
    var loadingData = true
    var answerData: AnswersModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "PopularCell", bundle: nil), forCellReuseIdentifier: "PopularCell")
        
        tableView.register(TrendingQuestionHeaderView.nib, forHeaderFooterViewReuseIdentifier: TrendingQuestionHeaderView.identifier)
        questionVM.delegate2 = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
    }
}
extension PopularQuestionDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = answerData {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PopularCell
        = tableView.dequeueReusableCell(withIdentifier: "PopularCell") as! PopularCell
        if let data = answerData {
            cell.configureDataWith(homeModel: data)
        }
        cell.backBtn.addTarget(self, action: #selector(backClicked(button:)), for: .touchUpInside)
        cell.nextBtn.addTarget(self, action: #selector(nextClicked(button:)), for: .touchUpInside)
        
        // cell.configure(data: trendingQuestions)
        return cell
    }
    
    
    @objc func backClicked(button: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func nextClicked(button: UIButton) {
        let str = UIStoryboard(name: "Details", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "QuestionDetailsViewController") as! QuestionDetailsViewController
        nextVC.questionId = answerData?.id ?? 0
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
extension PopularQuestionDetailsViewController: RepliesViewModelDelegate {
    func didReceiveUserRepliesData(response: RepliesModel?, error: String?) {
        self.dismiss()
        if let data  = response {
            repleisData = data
            tableView.reloadData()
        }
    }
    
    
}
