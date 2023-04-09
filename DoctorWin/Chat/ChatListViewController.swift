//
//  ChatListViewController.swift
//  DoctorWin
//
//  Created by AHP on 05/04/2566 BE.
//

import UIKit

class ChatListViewController: ViewController {
    @IBOutlet weak var chatTableVieW: UITableView!
    var chatVM = ChatListViewModel()
    var chatArray: [ChatListModel] = []
    var recentChatArray: [RecentChatModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableVieW.setCornerRadius(radius: 20)
        chatTableVieW.register(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "ChatCell")
        chatVM.delegate = self
        loadProfilesList()
        loadChatProfilesList()
    }
    func loadProfilesList() {
        chatVM.getChatListDataFromAPI(pageNum: 0)
    }
    func loadChatProfilesList() {
        chatVM.getRecentChatListDataFromAPI(pageNum: 0)
    }

}
extension ChatListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return recentChatArray.count
        } else if section == 1 {
            return chatArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChatCell
        = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatCell
        if indexPath.section == 0 {
            cell.cellConfigureWithFollowData(data: recentChatArray[indexPath.row])
        } else if indexPath.section == 1 {
            cell.cellConfigureWithFollowData(data: chatArray[indexPath.row])
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let str = UIStoryboard(name: "Connect", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "ChatHistoryViewController") as! ChatHistoryViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    func tableView( _ tableView : UITableView,  titleForHeaderInSection section: Int)->String? {
       switch(section) {
         case 0: return "Recent Chats"
       case 1: return "Suggested Channels"
         default :return ""
       }
    }
    
    
}
extension ChatListViewController: ChatListViewModelDelegate {
    func didReciveChatListData(response: [ChatListModel]?, error: String?) {
        self.dismiss()
        chatArray = response ?? []
        chatTableVieW.reloadData()
    }
    
    func didReciveRecentChatsData(response: [RecentChatModel]?, error: String?) {
        self.dismiss()
        recentChatArray = response ?? []
        chatTableVieW.reloadData()
    }
    
}
