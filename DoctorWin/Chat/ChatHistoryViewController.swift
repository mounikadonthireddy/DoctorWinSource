//
//  ChatHistoryViewController.swift
//  DoctorWin
//
//  Created by AHP on 07/04/2566 BE.
//

import UIKit
import SwiftWebSocket

class ChatHistoryViewController: UIViewController {
   
    @IBOutlet weak var chatTableVieW: UITableView!
    var chatVM = ChatListViewModel()
    var chatArray: [ChatModel] = []
    var socket = WebSocket()
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableVieW.register(UINib(nibName: "ChatHistoryCell", bundle: nil), forCellReuseIdentifier: "ChatHistoryCell")
    
//        chatVM.delegate = self
     loadProfilesList()
    }
    func loadProfilesList() {
        let url = "ws://35.170.72.137:8000/ws/beta/DWG_10002_6/"
        socket = WebSocket(url)
        socket.delegate = self
        self.socket.event.open = {
            print("WebSocket connection opened")
        }
        
        self.socket.event.close = { code, reason, clean in
            print("WebSocket connection closed with code: \(code), reason: \(reason), clean: \(clean)")
        }
        
        self.socket.event.error = { error in
            print("WebSocket error: \(error)")
        }
        
        self.socket.event.message = { message in
            if let text = message as? String {
                print("Received message: \(text)")
                if let jsonData = text.data(using: .utf8) {
                    do {
                        let decoder = JSONDecoder()
                        let person = try decoder.decode(ChatHistoryModel.self, from: jsonData)
                        self.chatArray = person.data ?? []
                        print(person)
                        self.chatTableVieW.reloadData()
                    } catch {
                        print("Error decoding JSON string: \(error.localizedDescription)")
                    }
                }
            }
        }
        
        // Connect to the WebSocket server
        self.socket.open()
    }

}
extension ChatHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "ChatHistoryCell") as! ChatHistoryCell
       cell.cellConfigureWithFollowData(data: chatArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = "ws://35.170.72.137:8000/ws/beta/DWG_10002_6/"
        let soket = WebSocketClient(url: url)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 50
//    }
    
}
//extension ChatListViewController: ChatListViewModelDelegate {
//    func didReciveVideosData(response: [ChatListModel]?, error: String?) {
//        chatArray = response ?? []
//        chatTableVieW.reloadData()
//    }
//
//
//}
extension ChatHistoryViewController: WebSocketDelegate {
    func webSocketOpen() {
        
    }
    
    func webSocketClose(_ code: Int, reason: String, wasClean: Bool) {
        
    }
    
    func webSocketError(_ error: NSError) {
        
    }
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("Received message: \(text)")
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("Received data: \(data.count) bytes")
    }
    func websocketDidConnect(socket: WebSocketClient) {
        print("WebSocket connected")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("WebSocket disconnected")
    }
    
    
}
