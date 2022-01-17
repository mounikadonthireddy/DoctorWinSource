////
////  JobCategoryCollectionView.swift
////  DoctorWin
////
////  Created by N517325 on 12/11/21.
////
//
//import UIKit
//
//class JobCategoryCollectionView: UICollectionView {
//
//    /*
//    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//    }
//    */
//
//}
//extension JobCategoryCollectionView : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == topJobsCollectionView {
//            return topJobsArray.count
//        }
//        return jobsCategoryArray.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if collectionView == topJobsCollectionView {
//
//            let cell: JobsCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "JobsCollectionCell", for: indexPath) as! JobsCollectionCell
//            cell.configureCell(with: topJobsArray[indexPath.row])
//
//            return cell
//
//        } else {
//        let cell: JobsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "JobsCell", for: indexPath) as! JobsCell
//        cell.configureCell(with: jobsCategoryArray[indexPath.row])
//        return cell
//        }
//
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView == topJobsCollectionView {
//            return  CGSize(width: itemWidth, height: self.topJobsCollectionView.frame.height)
//        } else {
//
//        let yourWidth = collectionView.bounds.width/3.0
//        return CGSize(width: yourWidth, height: 120)
//        }
//    }
//    func collectionView(_ collectionView: UICollectionView,
//                            layout collectionViewLayout: UICollectionViewLayout,
//                            insetForSectionAt section: Int) -> UIEdgeInsets {
//            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //.zero
//        }
//
//        func collectionView(_ collectionView: UICollectionView,
//                            layout collectionViewLayout: UICollectionViewLayout,
//                            minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//            if collectionView == topJobsCollectionView {
//                return 10
//            }
//            return 0
//        }
//
//        func collectionView(_ collectionView: UICollectionView,
//                            layout collectionViewLayout: UICollectionViewLayout,
//                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//            if collectionView == topJobsCollectionView {
//                return 10
//            }
//            return 0
//        }
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//
//
//    // MARK: - UIScrollViewDelegate protocol
//
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//
//        let pageWidth = Float(self.topJobsCollectionView.frame.width )
//        let targetXContentOffset = Float(targetContentOffset.pointee.x)
//        let contentWidth = Float(topJobsCollectionView!.contentSize.width  )
//        var newPage = Float(self.pageControll.currentPage)
//
//        if velocity.x == 0 {
//            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
//        } else {
//            newPage = Float(velocity.x > 0 ? self.pageControll.currentPage + 1 : self.pageControll.currentPage - 1)
//            if newPage < 0 {
//                newPage = 0
//            }
//            if (newPage > contentWidth / pageWidth) {
//                newPage = ceil(contentWidth / pageWidth) - 1.0
//            }
//        }
//
//        self.pageControll.currentPage = Int(newPage)
//        let point = CGPoint (x: CGFloat(newPage * pageWidth - 10 * newPage), y: targetContentOffset.pointee.y)
//        targetContentOffset.pointee = point
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let str = UIStoryboard(name: "Home", bundle: nil)
//
//        let nextVC = str.instantiateViewController(withIdentifier: "JobDetailsViewController") as! JobDetailsViewController
//
////        nextVC.modalPresentationStyle = .fullScreen
////        nextVC.modalTransitionStyle = .crossDissolve
//
////               present(nextVC, animated: true, completion: nil)
//        self.navigationController?.present(nextVC, animated: true)
//
//}
//}
