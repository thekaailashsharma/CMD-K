//
//  RecentMessage.swift
//  ChatApp
//
//  Created by Admin on 09/02/24.
//

import Foundation

struct RecentMessage: Identifiable {
    var id =  UUID().uuidString
    var lastMsg: String
    var lastMsgTime: String
    var pendingMsg: String
    var userName: String
    var userImage: String
    var allMessage: [Message]
}

let dummyRecentMessages: [RecentMessage] = [
    RecentMessage(lastMsg: "Just working on some projects.", lastMsgTime: "10:30 AM", pendingMsg: "1", userName: "John Doe", userImage: "https://firebasestorage.googleapis.com/v0/b/ai-travel-manager.appspot.com/o/10f9df6a-df96-4130-b485-753a50d01452%201.png?alt=media&token=2611424d-9d1f-404c-b87b-5d2c08a4c443", allMessage: dummyMessages),
    RecentMessage(lastMsg: "That sounds like an exciting game!", lastMsgTime: "10:30 AM", pendingMsg: "1", userName: "Tom", userImage: "https://firebasestorage.googleapis.com/v0/b/ai-travel-manager.appspot.com/o/Rectangle%2011.png?alt=media&token=79758dc1-e808-425a-bb8a-0d3e0861661e", allMessage: dummyMessages2),
        RecentMessage(lastMsg: "Classic choice!", lastMsgTime: "Yesterday", pendingMsg: "4", userName: "Gina", userImage: "https://firebasestorage.googleapis.com/v0/b/ai-travel-manager.appspot.com/o/Rectangle%2031.png?alt=media&token=9ae7c7d7-0ed5-4ec0-87b3-130d0c4d13a9", allMessage: dummyMessages)
]
