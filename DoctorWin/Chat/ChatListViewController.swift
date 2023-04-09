//
//  ChatListViewController.swift
//  DoctorWin
//
//  Created by AHP on 05/04/2566 BE.
//

import UIKit

class ChatListViewController: UIViewController {
    @IBOutlet weak var chatTableVieW: UITableView!
    var chatVM = ChatListViewModel()
    var chatArray: [ChatListModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        chatTableVieW.register(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "ChatCell")
        chatVM.delegate = self
        loadProfilesList()
    }
    func loadProfilesList() {
        chatVM.getChatListDataFromAPI(pageNum: 0)
    }

}
extension ChatListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChatCell
        = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatCell
        cell.cellConfigureWithFollowData(data: chatArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let str = UIStoryboard(name: "Connect", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "ChatHistoryViewController") as! ChatHistoryViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}
extension ChatListViewController: ChatListViewModelDelegate {
    func didReciveVideosData(response: [ChatListModel]?, error: String?) {
        chatArray = response ?? []
        chatTableVieW.reloadData()
    }
    
    
}
