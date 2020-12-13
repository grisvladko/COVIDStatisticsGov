//
//  SocketIOManager.swift
//  ChessFirebase
//
//  Created by hyperactive on 07/10/2020.
//  Copyright © 2020 hyperactive. All rights reserved.
//

import UIKit
import SocketIO
import JavaScriptCore

class SocketIOManager: NSObject {
    
    static let sharedInstance = SocketIOManager()
    let manager: SocketManager
    let socket: SocketIOClient
    
    override init() {
        self.manager = SocketManager(socketURL: URL(string: "http://10.0.0.6:3000")!)
        self.socket = manager.defaultSocket
    }
    
    func connect(_ completion: @escaping (_ data: Any) -> Void) {
        socket.connect()
        
        socket.on("data") { (data, ack) in
            let array = NSArray(object: data[0])
            print(array)
            completion(array)
        }
    }
    
    func disconnect() {
        socket.disconnect()
    }
    
    func join(_ room: String, _ username: String ,_ completion: @escaping (_ userList: [[String : Any]]) -> Void) {
        
        socket.emit("join", username, room)
        
        socket.on("userList") { (dataArray, ack) in
            completion(dataArray[0] as! [[String : Any]])
        }
        
    }

    func leave(_ room: String) {
        socket.emit("leave", room)
    }
    
    func listen(_ room: String) {
        socket.emit("listen", room)
    }
    
    func invitation(_ initiator: String, _ reciever: String,_ gameId: String, _ completion: @escaping (_ isAccepted: Bool, _ room: String) -> Void) {
        socket.emit("invitation", initiator, reciever, gameId)
        
        socket.on("inviteAccepted") { (data, ack) in
            let room = data[0] as! String
            completion(true, room)
        }
        socket.on("inviteDeclined") { (data, ack) in
            completion(false, "")
        }
    }
    
    
}
