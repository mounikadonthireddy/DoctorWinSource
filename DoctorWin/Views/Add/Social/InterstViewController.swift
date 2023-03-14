//
//  InterstViewController.swift
//  DoctorWin
//
//  Created by AHP on 13/06/2565 BE.
//

import UIKit

class InterstViewController: ViewController {
    var interestArray: [InterestModel] = []
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var submit: UIButton!
    var selectedArray :[String] = []
    var interestVM = InterestViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interestVM.delegate = self
        collectionView.register(UINib.init(nibName: "CourseNameCell", bundle: nil), forCellWithReuseIdentifier: "CourseNameCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.white
        collectionView.allowsMultipleSelection = true
        
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        submit.setCornerRadius(radius: Float(submit.frame.height)/2)
        loadInterests()
        // Do any additional setup after loading the view.
    }
    func loadInterests() {
        self.showLoader()
        interestVM.loadAllInterest()
    }
    @IBAction func backClicked(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
   
    @IBAction func submitClicked(_ sender: UIButton) {
        showLoader()
        let data = selectedArray.joined(separator: ",")
        let res = InterestRequest(userid: User.shared.userID, interest: data)
        interestVM.submitInterest(request: res)
    }
}
extension InterstViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interestArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CourseNameCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseNameCell", for: indexPath) as! CourseNameCell
        
        cell.name.text = interestArray[indexPath.item].name ?? ""
        cell.name.backgroundColor = UIColor.clear
        cell.setCornerRadiusWithBorderColor(radius: 17.5, color: UIColor.secondaryLabel, borderWidth: 0.5)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = ((interestArray[indexPath.row].name ?? "") as NSString).size(withAttributes: nil)
        return CGSize(width: size.width + 20, height: 35)
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5) //.zero
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    let selectedCell:UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
  

        let selected = interestArray[indexPath.row].name ?? ""
        if selectedArray.contains(selected) {
            
            selectedArray.removeAll {$0 == selected }
            selectedCell.contentView.backgroundColor = UIColor(rgb: 0xFFFFFF)
            
        } else {
            selectedArray.append(selected)
            selectedCell.contentView.backgroundColor = UIColor(rgb: 0x4986cc)
        }
        print(selectedArray)
    }

    
}
extension InterstViewController: InterestViewModelDelegate {
    func submitInterestResponse(res: BoolResponseModel?, error: String?) {
        self.dismiss()
    }
    
    func didInterestData(response: InterestResponseModel?, error: String?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss()
            if error == nil {
                self.interestArray = response?.datingResponse ?? []
                self.collectionView.reloadData()
            }
        }
    }
    
    
}
