//
//  SearchViewController.swift
//  DoctorWin
//
//  Created by AHP on 30/03/2566 BE.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet {
            interfaceSegmented.setButtonTitles(buttonTitles: ["Questions","Poeple",  "Groups", "Post"])
            interfaceSegmented.selectorViewColor = .black
            interfaceSegmented.selectorTextColor = .black

        }
    }
    var shouldShowSearchResults = false
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CaseCell", bundle: nil), forCellReuseIdentifier: "CaseCell")
        tableView.register(UINib(nibName: "HomeTableCell", bundle: nil), forCellReuseIdentifier: "HomeTableCell")
        tableView.register(UINib(nibName: "QACell", bundle: nil), forCellReuseIdentifier: "QACell")
        tableView.register(UINib(nibName: "UserAnswerCell", bundle: nil), forCellReuseIdentifier: "UserAnswerCell")
        tableView.register(UINib(nibName: "RequestCell", bundle: nil), forCellReuseIdentifier: "RequestCell")
        configureSearchController()
        // Do any additional setup after loading the view.
    }
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tabBarController?.tabBar.isHidden = false
    }
    func configureSearchController() {
            searchController = UISearchController(searchResultsController: nil)
            searchController.dimsBackgroundDuringPresentation = false
            searchController.searchBar.placeholder = "Search here..."
            searchController.searchBar.delegate = self
            searchController.searchResultsUpdater = self
            searchController.searchBar.sizeToFit()

            self.tableView.tableHeaderView = searchController.searchBar
        }

}
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
extension SearchViewController: UISearchResultsUpdating , UISearchBarDelegate {
    //MARK:- search update delegate
        //MARK:-

        public func updateSearchResults(for searchController: UISearchController){
            let searchString = searchController.searchBar.text

            // Filter the data array and get only those countries that match the search text.
//
//            filteredArray = dataArray.filter({ (country) -> Bool in
//                        let countryText: NSString = country as NSString
//                        return (countryText.range(of: searchString!, options: .caseInsensitive).location) != NSNotFound
//                    })
            tableView.reloadData()
        }

        //MARK:- search bar delegate
        //MARK:-

        public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            shouldShowSearchResults = true
            tableView.reloadData()
        }


        public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            shouldShowSearchResults = false
            tableView.reloadData()
        }

 
}
