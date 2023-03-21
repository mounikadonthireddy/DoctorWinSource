//
//  MentorViewController.swift
//  DoctorWin
//
//  Created by AHP on 18/03/2566 BE.
//

import UIKit

class MentorViewController: UIViewController {
    var sectionArray = ["","Why Mentor App?","Services Available", "Testimonials", "People also ask"]
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib.init(nibName: "MentorCell", bundle: nil), forCellWithReuseIdentifier: "MentorCell")
        collectionView.register(UINib.init(nibName: "DoubtsCell", bundle: nil), forCellWithReuseIdentifier: "DoubtsCell")
        collectionView.register(UINib.init(nibName: "ServicesCell", bundle: nil), forCellWithReuseIdentifier: "ServicesCell")
        collectionView.register(UINib.init(nibName: "TestimonialCell", bundle: nil), forCellWithReuseIdentifier: "TestimonialCell")
       
        collectionView.register(UINib.init(nibName: "TestimonialCell", bundle: nil), forCellWithReuseIdentifier: "TestimonialCell")
        collectionView.register(UINib.init(nibName: "MentorImageCell", bundle: nil), forCellWithReuseIdentifier: "MentorImageCell")
        collectionView.register(UINib.init(nibName: "CourseNameCell", bundle: nil), forCellWithReuseIdentifier: "CourseNameCell")
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: headerKind, withReuseIdentifier: Key.ReusableIdentifiers.sectionHeaderViewId)

        configureCompositionalLayout()
    }
    @objc func backClicked(button: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
extension MentorViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0,1:
            return 1
        case 2:
            return 5
        case 3:
            return 3
        case 4:
            return 4
        default:
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell: MentorImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MentorImageCell", for: indexPath) as! MentorImageCell
            cell.backBtn.addTarget(self, action: #selector(backClicked(button:)), for: .touchUpInside)
            return cell
        } else if indexPath.section == 1 {
            let cell: MentorCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MentorCell", for: indexPath) as! MentorCell
            return cell
        } else if indexPath.section == 2 {
            let cell: ServicesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServicesCell", for: indexPath) as! ServicesCell
            return cell
            
        } else if indexPath.section == 3 {
            let cell: TestimonialCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestimonialCell", for: indexPath) as! TestimonialCell
            return cell
        } else if indexPath.section == 4 {
            let cell: DoubtsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DoubtsCell", for: indexPath) as! DoubtsCell
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    func configureCompositionalLayout() {
        
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, env) in
            if sectionNumber == 0  {
                return LayoutType.mentorImage.getLayout()
            } else if sectionNumber == 1 {
                return LayoutType.mentorApp.getLayout()
            } else if sectionNumber == 2 {
                return LayoutType.mentorServices.getLayout()
            } else if sectionNumber == 3 {
                return LayoutType.testimonals.getLayout()
            } else if sectionNumber == 4 {
                return LayoutType.doubts.getLayout()
            } else {
                return LayoutType.mentorImage.getLayout()
            }
        }
        
        layout.register(SectionDecorationView.self, forDecorationViewOfKind: sectionBackground)
        collectionView.setCollectionViewLayout(layout, animated: true )
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Key.ReusableIdentifiers.sectionHeaderViewId, for: indexPath) as! SectionHeaderView
        header.title.text = sectionArray[indexPath.section]
            return header
    }
    
}
