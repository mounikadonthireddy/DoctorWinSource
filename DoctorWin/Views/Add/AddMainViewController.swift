//
//  AddMainViewController.swift
//  DoctorWin
//
//  Created by N517325 on 11/11/21.
//

import UIKit

class AddMainViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    var views : [UIView]!
    let titleArray = ["Post","Cases", "News", "Sale", "Article"]
    
    /// Instantiate ViewControllers Here With Lazy Keyword
    ///  // MARK: AddCasesViewController
    lazy var vc: AddCasesViewController = {
        
        let str = UIStoryboard(name: "Add", bundle: nil)
        var viewController = str.instantiateViewController(withIdentifier: "AddCasesViewController") as! AddCasesViewController
        
        return viewController
    }()
    
    // MARK: AddCasesViewController
    lazy var vc1: AddCasesViewController = {
        
        let str = UIStoryboard(name: "Add", bundle: nil)
        var viewController = str.instantiateViewController(withIdentifier: "AddCasesViewController") as! AddCasesViewController
        
        return viewController
    }()
    
    // MARK: AddNewsViewController
    
   
    
    // MARK: AddPollViewController
    
    lazy var vc3: SaleViewController = {
        let str = UIStoryboard(name: "Add", bundle: nil)
        var viewController = str.instantiateViewController(withIdentifier: "SaleViewController") as! SaleViewController
        return viewController
    }()
    // MARK: AddArticalViewController
    
   
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        views = [UIView]()
        views.append(vc.view)
        views.append(vc1.view)
      
        views.append(vc3.view)
      
        
        for v in views {
            v.frame = containerView.bounds
            containerView.addSubview(v)
        }
        containerView.bringSubviewToFront(views[0])
        self.navigationController?.isNavigationBarHidden = true
        
        collectionView.register(UINib.init(nibName: "CourseNameCell", bundle: nil), forCellWithReuseIdentifier: "CourseNameCell")
      
        self.collectionView.backgroundColor = UIColor.white
        
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

    }
    @IBAction func closeClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func segmentClicked(_ sender: UISegmentedControl) {
        containerView.bringSubviewToFront(views[sender.selectedSegmentIndex])
    }
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension AddMainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CourseNameCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseNameCell", for: indexPath) as! CourseNameCell

        cell.name.text = titleArray[indexPath.item]
        cell.name.backgroundColor = UIColor.white
//        cell.backgroundColor = UIColor.white
        cell.setCornerRadiusWithBorderColor(radius: 1, color: UIColor.secondaryLabel, borderWidth: 0.5)
        cell.name.font = UIFont(name: "Roboto-Regular", size: 15)
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = titleArray[indexPath.row].size(withAttributes: nil)
        return CGSize(width: size.width + 40, height: collectionView.bounds.height)
     
    }
    func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //.zero
        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
          
            return 10
        }

        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           
            return 15
        }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        containerView.bringSubviewToFront(views[indexPath.row])
    }
}
