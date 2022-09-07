//
//  QuestionsViewController.swift
//  DoctorWin
//
//  Created by AHP on 06/09/2565 BE.
//

import UIKit

class QuestionsViewController: ViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var shopCVLayout: UICollectionViewFlowLayout!
    var questionsArray: [PostedQuestionModel] = []
    var trendingQuestions:[AnswersModel] = []
    var questionVM = QuestionsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    tableView.register(UINib(nibName: "QACell", bundle: nil), forCellReuseIdentifier: "QACell")
        collectionView.register(UINib.init(nibName: "AnswersCell", bundle: nil), forCellWithReuseIdentifier: "AnswersCell")
        
        shopCVLayout.scrollDirection = .vertical
        shopCVLayout.minimumLineSpacing = 0
        shopCVLayout.minimumInteritemSpacing = 0
        shopCVLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        questionVM.delegate1 = self
        self.loadPostedQuestions()
        self.loadPopularQuestions()
        // Do any additional setup after loading the view.
    }
    func loadPopularQuestions() {
        self.showLoader()
        questionVM.getMostPopularQuestions(userID: User.shared.userID)
        
    }
    func loadPostedQuestions() {
        self.showLoader()
        questionVM.getMostUserPostedQuestions(userID: User.shared.userID)
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
extension QuestionsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingQuestions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AnswersCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswersCell", for: indexPath) as! AnswersCell
        cell.configureDataWith(homeModel: trendingQuestions[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let yourWidth = collectionView.bounds.width
        return CGSize(width: yourWidth, height: 140)
       
    }
    func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) //.zero
        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
          
            return 5
        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           
            return 5
        }
    
}

extension QuestionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: QACell
            = tableView.dequeueReusableCell(withIdentifier: "QACell") as! QACell
        cell.configureWith(data: questionsArray[indexPath.row])
        return cell
    }
    
    
    
}
extension QuestionsViewController: QAViewModelDelegate {
    func didReceiveTrendingQuestionData(response: [AnswersModel]?, error: String?) {
        self.dismiss()
        trendingQuestions = response ?? []
        collectionView.reloadData()
    }
    
    func didReceiveUserQuestionData(response: [PostedQuestionModel]?, error: String?) {
        self.dismiss()
        questionsArray = response ?? []
        tableView.reloadData()
    }
    
    
}
