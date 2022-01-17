////
////  RecommendedCollectionView.swift
////  DoctorWin
////
////  Created by N517325 on 12/11/21.
////
//
//import UIKit
//
//class RecommendedCollectionView: UICollectionView {
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
//extension RecommendedCollectionView : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//      
//            return topJobsArray.count
//       
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//            
//            let cell: JobsCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "JobsCollectionCell", for: indexPath) as! JobsCollectionCell
//            cell.configureCell(with: topJobsArray[indexPath.row])
//
//            return cell
//      
//
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            return  CGSize(width: itemWidth, height: self.frame.height)
//       
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
//                return 10
//           
//        }
//
//        func collectionView(_ collectionView: UICollectionView,
//                            layout collectionViewLayout: UICollectionViewLayout,
//                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//                return 10
//           
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
//        let pageWidth = Float(self.frame.width )
//        let targetXContentOffset = Float(targetContentOffset.pointee.x)
//        let contentWidth = Float(self.contentSize.width  )
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
