//
//  QuestionsViewController.swift
//  DoctorWin
//
//  Created by AHP on 06/09/2565 BE.
//

import UIKit

class QuestionsViewController: ViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    var questionsArray: [PostedQuestionModel] = []
    var trendingQuestions:[AnswersModel] = []
    var questionVM = QuestionsViewModel()
    var pageNumber = 1
    var loadingData = true
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.dropShadow()
        tableView.register(UINib(nibName: "QACell", bundle: nil), forCellReuseIdentifier: "QACell")
        tableView.register(UINib(nibName: "TrendingTableCell", bundle: nil), forCellReuseIdentifier: "TrendingTableCell")
        
        tableView.register(TrendingQuestionHeaderView.nib, forHeaderFooterViewReuseIdentifier: TrendingQuestionHeaderView.identifier)
        questionVM.delegate1 = self
        self.loadPostedQuestions(pageNum: pageNumber)
        self.loadPopularQuestions()
        // Do any additional setup after loading the view.
    }
    func loadPopularQuestions() {
        self.showLoader()
        questionVM.getMostPopularQuestions(userID: User.shared.userID)
        
    }
    func loadPostedQuestions(pageNum: Int) {
        self.showLoader()
        questionVM.getMostUserPostedQuestions(userID: User.shared.userID,page: pageNum)
    }
    override func viewWillAppear(_ animated: Bool) {
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
}
extension QuestionsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
        return questionsArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: TrendingTableCell
            = tableView.dequeueReusableCell(withIdentifier: "TrendingTableCell") as! TrendingTableCell
            cell.configure(data: trendingQuestions)
            return cell
        } else {
        let cell: QACell
        = tableView.dequeueReusableCell(withIdentifier: "QACell") as! QACell
        cell.configureWith(data: questionsArray[indexPath.row])
        return cell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TrendingQuestionHeaderView.identifier) as? TrendingQuestionHeaderView {
            if section == 0 {
                headerView.nameLbl.text  = "Trending QnA"
            } else {
                headerView.nameLbl.text  = "Questions for you"
            }
          
            return headerView
        }
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let lastElement = questionsArray.count - 1
//        if !loadingData && indexPath.row == lastElement {
//            self.showLoader()
//            loadingData = true
//            pageNumber += 1
//            self.loadPostedQuestions(pageNum: pageNumber)
//        }
//    }
    
    
}
extension QuestionsViewController: QAViewModelDelegate {
    func didReceiveTrendingQuestionData(response: [AnswersModel]?, error: String?) {
        self.dismiss()
        trendingQuestions = response ?? []
        tableView.reloadData()
    }
    
    func didReceiveUserQuestionData(response: [PostedQuestionModel]?, error: String?) {
        self.dismiss()
        loadingData = false
        questionsArray = questionsArray + (response ?? [])
        tableView.reloadData()
    }
    
    
}
extension UICollectionView {
    func scrollToNearestVisibleCollectionViewCell() {
        self.decelerationRate = UIScrollView.DecelerationRate.fast
        let visibleCenterPositionOfScrollView = Float(self.contentOffset.x + (self.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<self.visibleCells.count {
            let cell = self.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)
            
            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = self.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            self.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}
