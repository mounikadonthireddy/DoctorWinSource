//
//  CarrierViewController.swift
//  DoctorWin
//
//  Created by N517325 on 22/10/21.
//

import UIKit

class CarrierViewController: ViewController {
    var jobsCategoryArray:[JobCategoryDataModel] = []
    var topJobsArray:[JobsDataModel] = []
    weak var jobScreenSelectionDelegate: JobScreenSelectionDelegate?
    @IBOutlet weak var jobCategeoryCollectionView: UICollectionView!

    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var topJobsCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    let collectionMargin = CGFloat(10)
    let itemSpacing = CGFloat(10)
    let itemHeight = CGFloat(265)
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!

    
    var itemWidth = CGFloat(0)
    var currentItem = 0
    var topJobsViewModel = TopJobsViewModel()
    var categoryJobsViewModel = JobCategoryViewModel()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        jobCategeoryCollectionView.dataSource = self
        jobCategeoryCollectionView.delegate = self
        topJobsCollectionView.dataSource = self
        topJobsCollectionView.delegate = self
        self.view.isUserInteractionEnabled = true
        self.jobCategeoryCollectionView.isUserInteractionEnabled = true
        
        jobCategeoryCollectionView.register(UINib.init(nibName: "JobsCell", bundle: nil), forCellWithReuseIdentifier: "JobsCell")
        
        topJobsCollectionView.register(UINib.init(nibName: "JobsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "JobsCollectionCell")

        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        itemWidth =  UIScreen.main.bounds.width - collectionMargin * 2.0
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: itemWidth, height: topJobsCollectionView.frame.height)
        layout.headerReferenceSize = CGSize(width: collectionMargin, height: 0)
        layout.footerReferenceSize = CGSize(width: collectionMargin, height: 0)
        
        layout.minimumLineSpacing = itemSpacing
        layout.scrollDirection = .horizontal
        topJobsCollectionView!.collectionViewLayout = layout
        topJobsCollectionView?.decelerationRate = UIScrollView.DecelerationRate.fast
        topJobsViewModel.delegate = self
        categoryJobsViewModel.delegate = self
        parse()
        loadTopJobs()
        
        // Do any additional setup after loading the view.
    }
    func parse() {
        self.showLoader()
        categoryJobsViewModel.getTopRecommendedJobs(userID: User.shared.userID)
    }
    
    func loadTopJobs() {
        self.showLoader()
        topJobsViewModel.getTopRecommendedJobs(userID: User.shared.userID)
    }
    
    
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()

        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)

      }
    
    @IBAction func customJobClicked(_ sender: Any) {
        jobScreenSelectionDelegate?.didSelectScreen(selectedType: JobScreenSelection.customJob)

    }

    @IBAction func appliedJobClicked(_ sender: Any) {
        jobScreenSelectionDelegate?.didSelectScreen(selectedType: JobScreenSelection.appliedJob)

    }
    @IBAction func savedJobClicked(_ sender: Any) {
        jobScreenSelectionDelegate?.didSelectScreen(selectedType: JobScreenSelection.savedJob)

    }

}
extension CarrierViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topJobsCollectionView {
            return topJobsArray.count
        }
        return jobsCategoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topJobsCollectionView {
            
            let cell: JobsCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "JobsCollectionCell", for: indexPath) as! JobsCollectionCell
            cell.configureCell(with: topJobsArray[indexPath.row])

            return cell
            
        } else {
        let cell: JobsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "JobsCell", for: indexPath) as! JobsCell
        cell.configureCell(with: jobsCategoryArray[indexPath.row])
        return cell
        }

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == topJobsCollectionView {
            return  CGSize(width: itemWidth, height: self.topJobsCollectionView.frame.height)
        } else {
        
        let yourWidth = collectionView.bounds.width/3.0
        return CGSize(width: yourWidth, height: 120)
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //.zero
        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            if collectionView == topJobsCollectionView {
                return 10
            }
            return 0
        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            if collectionView == topJobsCollectionView {
                return 10
            }
            return 0
        }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    

    
    // MARK: - UIScrollViewDelegate protocol
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageWidth = Float(self.topJobsCollectionView.frame.width )
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(topJobsCollectionView!.contentSize.width  )
        var newPage = Float(self.pageControll.currentPage)
        
        if velocity.x == 0 {
            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        } else {
            newPage = Float(velocity.x > 0 ? self.pageControll.currentPage + 1 : self.pageControll.currentPage - 1)
            if newPage < 0 {
                newPage = 0
            }
            if (newPage > contentWidth / pageWidth) {
                newPage = ceil(contentWidth / pageWidth) - 1.0
            }
        }
        
        self.pageControll.currentPage = Int(newPage)
        let point = CGPoint (x: CGFloat(newPage * pageWidth - 10 * newPage), y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == topJobsCollectionView {
            jobScreenSelectionDelegate?.didSelectScreen(selectedType: JobScreenSelection.recommandedJob(withModel: topJobsArray[indexPath.row]))

        } else {
            let value = jobsCategoryArray[indexPath.item].title ?? "none"
            let id = jobsCategoryArray[indexPath.item].id ?? 0

            jobScreenSelectionDelegate?.didSelectScreen(selectedType: JobScreenSelection.jobWithType(withtype: JobType.init(rawValue: value)!, categoryID: id))
       
        }
}
}
extension CarrierViewController: TopJobsViewModelDelegate {
    func didReceiveTopJobs(response: [JobsDataModel]?, error: String?) {
        self.dismiss()
        topJobsArray = response ?? []
        topJobsCollectionView.reloadData()
        pageControll.numberOfPages = topJobsArray.count
    }
    
    
}
extension CarrierViewController: JobCategoryViewModelDelegate {
    func didReceiveTopJobs(response: [JobCategoryDataModel]?, error: String?) {
        self.dismiss()
        jobsCategoryArray = response ?? []
        collectionViewHeight.constant = CGFloat(jobsCategoryArray.count * 45)
        jobCategeoryCollectionView.reloadData()
    }
    
    
}
