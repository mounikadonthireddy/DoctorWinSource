//
//  Socket.swift
//  DoctorWin
//
//  Created by AHP on 05/04/2566 BE.
//

import Foundation
import SwiftWebSocket

class WebSocketClient {
    
    
    
    let socket: WebSocket
    
    init(url:String) {
        // Create a WebSocket object with the URL of the WebSocket server
        
        self.socket = WebSocket(url)
        socket.delegate = self
        // Set up event handlers for the WebSocket connection
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
            }
        }
        
        // Connect to the WebSocket server
        self.socket.open()
        
        
    }
    
    deinit {
        // Disconnect from the WebSocket server when the object is deallocated
        self.socket.close()
    }
}
extension WebSocketClient: WebSocketDelegate {
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
