//
//  MentorViewController.swift
//  DoctorWin
//
//  Created by AHP on 18/03/2566 BE.
//

import UIKit

class MentorViewController: ViewController {
    var sectionArray = ["","Daily Updates","","Services Available", "Testimonials", "People also ask", "About Mentor App"]
    @IBOutlet weak var collectionView: UICollectionView!
    var dailyUpdateArr: [DailyUpdatesModel] = []
    var testimonalArr: [TestimonialModel] = []
    var faqArr: [FAQModel] = []
    var planArr: [MentorPlanModel] = []
    var mentorVM = MentorViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib.init(nibName: "DailyUpdatesCell", bundle: nil), forCellWithReuseIdentifier: "DailyUpdatesCell")
        
        collectionView.register(UINib.init(nibName: "MentorCell", bundle: nil), forCellWithReuseIdentifier: "MentorCell")
        collectionView.register(UINib.init(nibName: "DoubtsCell", bundle: nil), forCellWithReuseIdentifier: "DoubtsCell")
        collectionView.register(UINib.init(nibName: "ServicesCell", bundle: nil), forCellWithReuseIdentifier: "ServicesCell")
        collectionView.register(UINib.init(nibName: "TestimonialCell", bundle: nil), forCellWithReuseIdentifier: "TestimonialCell")
       
        collectionView.register(UINib.init(nibName: "TestimonialCell", bundle: nil), forCellWithReuseIdentifier: "TestimonialCell")
        collectionView.register(UINib.init(nibName: "MentorImageCell", bundle: nil), forCellWithReuseIdentifier: "MentorImageCell")
        collectionView.register(UINib.init(nibName: "CourseNameCell", bundle: nil), forCellWithReuseIdentifier: "CourseNameCell")
        collectionView.register(UINib.init(nibName: "AboutAppCell", bundle: nil), forCellWithReuseIdentifier: "AboutAppCell")

        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: headerKind, withReuseIdentifier: Key.ReusableIdentifiers.sectionHeaderViewId)
        mentorVM.delegate = self
        loadDailyUpdatesData()
        configureCompositionalLayout()
        loadTestimonalsData()
        loadFAQData()
        loadServicesData()
       // loadAboutApp()
    }
    @objc func backClicked(button: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    func loadDailyUpdatesData() {
        self.showLoader()
        mentorVM.getDailyUpdatesDataFromAPI(pageNum: 0)
    }
    func loadTestimonalsData() {
        self.showLoader()
        mentorVM.getTestimonalsDataFromAPI(pageNum: 0)
    }
    func loadFAQData() {
        self.showLoader()
        mentorVM.getFAQDataFromAPI(pageNum: 0)
    }
    func loadServicesData() {
        self.showLoader()
        mentorVM.getServicesFromAPI(pageNum: 0)
    }
    func loadAboutApp() {
        self.showLoader()
        mentorVM.getAboutAppAPI(pageNum: 0)
    }
}
extension MentorViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return dailyUpdateArr.count
        case 2:
            return 1
        case 3:
            return planArr.count
        case 4:
            return testimonalArr.count
        case 5:
            return faqArr.count
        case 6:
            return planArr.count
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
            let cell: DailyUpdatesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyUpdatesCell", for: indexPath) as! DailyUpdatesCell
            cell.configureWith(data: dailyUpdateArr[indexPath.row])
            return cell
        }
        else if indexPath.section == 2 {
            let cell: MentorCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MentorCell", for: indexPath) as! MentorCell
            return cell
        } else if indexPath.section == 3 {
            let cell: ServicesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServicesCell", for: indexPath) as! ServicesCell
            cell.configureCell(data: planArr[indexPath.row])
            return cell
            
        } else if indexPath.section == 4 {
            let cell: TestimonialCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestimonialCell", for: indexPath) as! TestimonialCell
            cell.configureWith(data: testimonalArr[indexPath.row])
            return cell
        } else if indexPath.section == 5 {
            let cell: DoubtsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DoubtsCell", for: indexPath) as! DoubtsCell
            return cell
        } else if indexPath.section == 6 {
            let cell: AboutAppCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AboutAppCell", for: indexPath) as! AboutAppCell
            cell.configureCell(data: planArr[indexPath.row])
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
                return LayoutType.dailyUpdates.getLayout()
            } else if sectionNumber == 2 {
                return LayoutType.mentorApp.getLayout()
            } else if sectionNumber == 3 {
                return LayoutType.mentorServices.getLayout()
            } else if sectionNumber == 4 {
                return LayoutType.testimonals.getLayout()
            } else if sectionNumber == 5 {
                return LayoutType.doubts.getLayout()
            } else if sectionNumber == 6 {
                return LayoutType.aboutApp.getLayout()
            } else {
                return LayoutType.mentorImage.getLayout()
            }
        }
        
        layout.register(DaillyDecorationView.self, forDecorationViewOfKind: "DaillyDecorationView")
        layout.register(SectionDecorationView.self, forDecorationViewOfKind: sectionBackground)
        collectionView.setCollectionViewLayout(layout, animated: true )
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Key.ReusableIdentifiers.sectionHeaderViewId, for: indexPath) as! SectionHeaderView
        header.title.text = sectionArray[indexPath.section]
//        header.title.frame = CGRectMake(10, 10, self.view.frame.width - 20, 45)
        header.title.textAlignment = .center
            return header
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            let str = UIStoryboard(name: "Network", bundle: nil)
            let nextVC = str.instantiateViewController(withIdentifier: "MentorSelectionViewController") as! MentorSelectionViewController
            nextVC.navTitle = planArr[indexPath.row].title ?? ""
            if indexPath.row == 0 || indexPath.row == 1 {
                nextVC.type = true
            }
            nextVC.descTitle = planArr[indexPath.row].description ?? ""
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}
extension MentorViewController: MentorViewModelDelegate {
    func didMentorPlanData(response: MentorPlanResponseModel?, error: String?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss()
            self.planArr = response?.description ?? []
            self.collectionView.reloadData()
        }
    }
    
    func didReciveFAQData(response: FAQResponseModel?, error: String?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss()
            self.faqArr = response?.description ?? []
            self.collectionView.reloadData()
        }
    }
    
    func didReciveTestimonalsData(response: TestimonialResponseModel?, error: String?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss()
            self.testimonalArr = response?.description ?? []
            self.collectionView.reloadData()
        }
    }
    func didReciveDailyUpdatesData(response: DailyUpdatesResponseModel?, error: String?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss()
            self.dailyUpdateArr = response?.description ?? []
            self.collectionView.reloadData()
        }
    }
    
    func getPlanModelArray() -> [PlanModel] {
        let array = [PlanModel(name: "NEET PG Counselling", description: "NEET PG Couselling is the process of seat allocation for admission into postgraduate medical course in India.The Nati...More"),
        PlanModel(name: "NEET UG Counselling", description: "NEET UG Counselling is the process that takes place after the declaration of NEET UG results. NEET UG is the National Eligi...More"),
        PlanModel(name: "NEET MDS Counselling", description: "NEET MDS (National Eligibility cum Entrance Test - Master of Dental Surgery) is an entrance examination conducted by the...More"),
        PlanModel(name: "Abroad Study Counselling", description: "Abroad Study Counselling is a valuable service that provides students with guidance and support as they navigate the comp...More"),
        PlanModel(name: "New Hospital Establishment", description: "A new hospital is being established in the heart of the city with state-of-the-art facilities and advanced medical equip....More"),
        PlanModel(name: "Grow Your Hospital", description: "Grow Your hospital is a comprehesive and innovative platforn designed to help hospital administration and healthcare pr...More")]
        return array
    }
    
}
struct PlanModel: Codable {
    let name: String
    let description: String
}
