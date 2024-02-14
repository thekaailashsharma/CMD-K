//
//  Message.swift
//  ChatApp
//
//  Created by Admin on 09/02/24.
//

import Foundation

struct Message: Identifiable, Equatable {
    var id = UUID().uuidString
    var message: String
    var isMessageMine: Bool 
}

struct SavedChats: Identifiable {
    var id: UUID = UUID()
    var name: String
    var lastMessage: String
    var messages: [MyChats]
}

let dummyMessages: [Message] = [
    Message(message: "Hello", isMessageMine: false),
    Message(message: "Hi there!", isMessageMine: true),
    Message(message: "How are you?", isMessageMine: true),
    Message(message: "I'm fine, thank you!", isMessageMine: false),
    Message(message: "What are you up to?", isMessageMine: false),
    Message(message: "Just working on some projects.", isMessageMine: true)
]

let dummyMessages2: [Message] = [
    Message(message: "Hey, did you catch the game last night?", isMessageMine: false),
    Message(message: "No, I missed it. Who won?", isMessageMine: true),
    Message(message: "The Sharks won 3-2 in overtime.", isMessageMine: false),
    Message(message: "That sounds like an exciting game!", isMessageMine: true),
    
    Message(message: "What's your favorite book?", isMessageMine: false),
    Message(message: "I love 'To Kill a Mockingbird'. What about you?", isMessageMine: true),
    Message(message: "I'm a fan of 'The Great Gatsby'.", isMessageMine: false),
    Message(message: "Classic choice!", isMessageMine: true),
    
    Message(message: "How's the weather today?", isMessageMine: false),
    Message(message: "It's sunny with a chance of rain later.", isMessageMine: true),
    Message(message: "I hope it doesn't rain, I have plans for a picnic.", isMessageMine: false),
    Message(message: "Fingers crossed for clear skies!", isMessageMine: true),
    
    Message(message: "What's your favorite programming language?", isMessageMine: false),
    Message(message: "I'm a big fan of Swift!", isMessageMine: true),
    Message(message: "Nice! I prefer Python myself.", isMessageMine: false),
    Message(message: "Both are great choices!", isMessageMine: true)
]
