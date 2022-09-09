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
    @IBOutlet weak var pageControl: UIPageControl!
    var questionsArray: [PostedQuestionModel] = []
    var trendingQuestions:[AnswersModel] = []
    var questionVM = QuestionsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "QACell", bundle: nil), forCellReuseIdentifier: "QACell")
        collectionView.register(UINib.init(nibName: "AnswersCell", bundle: nil), forCellWithReuseIdentifier: "AnswersCell")
        collectionView.isScrollEnabled = true
        shopCVLayout.scrollDirection = .horizontal
        //        shopCVLayout.minimumLineSpacing = 0
        //        shopCVLayout.minimumInteritemSpacing = 0
        //        shopCVLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
extension QuestionsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingQuestions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AnswersCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswersCell", for: indexPath) as! AnswersCell
        cell.configureDataWith(homeModel: trendingQuestions[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let yourWidth = self.view.frame.width - 10
        return CGSize(width: yourWidth, height: self.collectionView.frame.height - 10)
        
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
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.collectionView.scrollToNearestVisibleCollectionViewCell()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.collectionView.scrollToNearestVisibleCollectionViewCell()
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: self.collectionView.contentOffset, size: self.collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = self.collectionView.indexPathForItem(at: visiblePoint) {
            self.pageControl.currentPage = visibleIndexPath.row
        }
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
        pageControl.numberOfPages = trendingQuestions.count
        collectionView.reloadData()
    }
    
    func didReceiveUserQuestionData(response: [PostedQuestionModel]?, error: String?) {
        self.dismiss()
        questionsArray = response ?? []
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
