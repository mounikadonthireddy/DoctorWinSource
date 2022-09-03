//
//  FilterViewController.swift
//  DoctorWin
//
//  Created by N517325 on 03/12/21.
//

import UIKit

class FilterViewController: UIViewController {
//    @IBOutlet weak var departmentBtn: UIButton!
//    @IBOutlet weak var JobPositionBtn: UIButton!
//    @IBOutlet weak var LocationBtn: UIButton!
//    @IBOutlet weak var submitBtn: UIButton!
//    @IBOutlet weak var collectionView: UICollectionView!
//   
//    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout! {
//        didSet {
////            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//}
//    }
//    let collectionMargin = CGFloat(10)
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        departmentBtn.setCornerRadiusWithBorderColor(radius: 20, color: UIColor.gray, borderWidth: 0.5)
//        JobPositionBtn.setCornerRadiusWithBorderColor(radius: 20, color: UIColor.gray, borderWidth: 0.5)
//        
//        LocationBtn.setCornerRadiusWithBorderColor(radius: 20, color: UIColor.gray, borderWidth: 0.5)
//        submitBtn.setCornerRadius(radius: Float(submitBtn.frame.height)/2)
//        collectionView.register(UINib.init(nibName: "CourseNameCell", bundle: nil), forCellWithReuseIdentifier: "CourseNameCell")
//        collectionView.backgroundColor = UIColor.systemGroupedBackground
//
////        collectionViewLayout.itemSize = CGSize(width: 160, height: 50)
////        collectionViewLayout.headerReferenceSize = CGSize(width: collectionMargin, height: 0)
////        collectionViewLayout.footerReferenceSize = CGSize(width: collectionMargin, height: 0)
////
////        collectionViewLayout.scrollDirection = .horizontal
////        collectionViewLayout.minimumLineSpacing = 10
////        collectionViewLayout.minimumInteritemSpacing = 10
////        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
////        collectionView!.collectionViewLayout = collectionViewLayout
////        collectionView?.decelerationRate = UIScrollView.DecelerationRate.fast
//        // Do any additional setup after loading the view.
//        parse1()
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        tabBarController?.tabBar.isHidden = true
//    }
//    func parse1() {
//        if let path = Bundle.main.path(forResource: "Filter", ofType: "json") {
//            
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                
//                let decoder = JSONDecoder()
//                
//                if let jsonPetitions = try? decoder.decode([CourseModel].self, from: data) {
//                    courseArray = jsonPetitions
//                    collectionView.reloadData()
//                }
//            } catch {
//                
//            }
//        }
//    }
//    
//    /*
//     // MARK: - Navigation
//     
//     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     // Get the new view controller using segue.destination.
//     // Pass the selected object to the new view controller.
//     }
//     */
//    @IBAction func filterClicked(_ sender: UIButton) {
//        if sender.tag == 1 {
//            
//        } else if sender.tag == 2 {
//            
//        } else if sender.tag == 3 {
//            
//        }
//    }
//    @IBAction func submitClicked(_ sender: Any) {
//        
//    }
//    @IBAction func backClicked(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
//    }
//}
//extension FilterViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return courseArray.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell: CourseNameCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseNameCell", for: indexPath) as! CourseNameCell
//        
//        cell.name.text = "\(courseArray[indexPath.item].name!)"
//        cell.name.backgroundColor = UIColor.systemGroupedBackground
//        cell.backgroundColor = UIColor.systemGroupedBackground
//
//        cell.name.textColor = UIColor.black
//        cell.name.font = UIFont(name:"Roboto-Regular",size:15)
//        cell.bgView.setCornerRadiusWithBorderColor(radius: Float(cell.bgView.frame.height)/2, color: UIColor.secondaryLabel, borderWidth: 1)
//        cell.name.setCornerRadiusWithBorderColor(radius: 0, color: UIColor.clear, borderWidth: 0)
//        cell.name.setCornerRadius(radius: 0)
//        cell.nameLblHeight.constant = 50
//
//        return cell
//        
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let string = "   \(courseArray[indexPath.item].name!)   "
//        let font =  UIFont(name:"Roboto-Regular",size: 15)
//        var starWidth = string.widthOfString(usingFont: font ?? UIFont.systemFont(ofSize: 16)) + 15
//        if starWidth < 100 {
//            starWidth += 20
//        }
//        return CGSize(width: starWidth, height: 50)
//
//
//    }
//    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //.zero
//    }
//    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        
//        return 5
//    }
//    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        
//        return 0
//    }
//    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    
//}
//extension String {
//
//    func widthOfString(usingFont font: UIFont) -> CGFloat {
//        let fontAttributes = [NSAttributedString.Key.font: font]
//        let size = self.size(withAttributes: fontAttributes)
//        return size.width
//    }
//
//    func heightOfString(usingFont font: UIFont) -> CGFloat {
//        let fontAttributes = [NSAttributedString.Key.font: font]
//        let size = self.size(withAttributes: fontAttributes)
//        return size.height
//    }
//
//    func sizeOfString(usingFont font: UIFont) -> CGSize {
//        let fontAttributes = [NSAttributedString.Key.font: font]
//        return self.size(withAttributes: fontAttributes)
//    }
}
