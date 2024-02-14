//
//  ChatsViewModel.swift
//  ChatApp
//
//  Created by Admin on 12/02/24.
//

import Foundation
import CoreData
import Combine


actor ChatManager: ObservableObject {
    
    let container: NSPersistentContainer
    @MainActor @Published var allChats: [MyChats] = []
    @MainActor @Published var savedChats: [SavedChats] = []
    @MainActor @Published var name: String? = nil
    @MainActor @Published var isMessageSent: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Gemini")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        Task {
            await self.refreshUI(chatName: "nil")
        }
        
    }
    
    func saveMessage(message: String, isUserMessage: Bool, chatName: String = "New Chat", isFirst: Bool = false) async {
        await self.updateMessageSent()
        let newChat = MyChats(context: container.viewContext)
        newChat.id = UUID()
        newChat.message = message
        newChat.isUser = isUserMessage
        newChat.date = Date()
        newChat.name = chatName
        
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving chat message: \(error)")
        }
        
        Task {
            await refreshUI(chatName: chatName)
        }
        
        if isFirst {
            Task {
                await getMessageName(userMessage: message, currentName: "New Chatss")
            }
        } else {
            Task {
                await sendToServer(userMessage: message, chatName: chatName)
            }
        }
        
       
    }
    
    func createNewMessage() {
        let newChat = MyChats(context: container.viewContext)
        newChat.id = UUID()
        newChat.message = "Hi How Can I help you today?"
        newChat.isUser = false
        newChat.date = Date()
        newChat.name = "New Chatss"
        
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving chat message: \(error)")
        }
        
        Task {
            await refreshUI()
        }
    }
    
    private func sendToServer(userMessage: String, chatName: String) async {
        guard let apiKey = ProcessInfo.processInfo.environment["API_KEY"] else {
            fatalError("Add API KEY")
        }
        if apiKey == "" {
            fatalError("Add API KEY")
        }
        let url = URL(string: "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=\(apiKey)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let body: [String: Any] = [
            "contents": [
                "parts": [
                    "text": userMessage
                ]
            ]
        ]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {
            print("Error creating HTTP body")
            return
        }
        
        
        
        request.httpBody = httpBody
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: GeminiResponse.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching content: \(error.localizedDescription)")
                    
                }
            } receiveValue: { response in
                if let candidate = response.candidates?.first,
                   let text = candidate.content?.parts?.first?.text {
                    print("Success: \(text)")
                    let newChat = MyChats(context: self.container.viewContext)
                    newChat.id = UUID()
                    newChat.message = text
                    newChat.isUser = false
                    newChat.date = Date()
                    newChat.name = chatName
                    do {
                        try self.container.viewContext.save()
                    } catch {
                        print("Error saving chat message: \(error)")
                    }
                    
                    Task {
                        await self.updateMessageSent()
                        await self.refreshUI(chatName: chatName)
                    }
                    
                } else {
                    print("No content returned")
                }
            }
            .store(in: &cancellables)
        
    }
    
    func getMessageName(userMessage: String, currentName: String) async {
        
        guard let apiKey = ProcessInfo.processInfo.environment["API_KEY"] else {
            fatalError("Add API KEY")
        }
        if apiKey == "" {
            fatalError("Add API KEY")
        }
        let url = URL(string: "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=\(apiKey)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let body: [String: Any] = [
            "contents": [
                "parts": [
                    "text": "This message marks the beginning of chat conversation. I want to name it in 5 words. Give me a name strictly in 5 words.Here's the message \(userMessage). Not more than 5 words. 5 or less than 5 words"
                ]
            ]
        ]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {
            print("Error creating HTTP body")
            Task {
                await self.updateName(savedName: nil)
            }
            return
        }
        
        
        
        request.httpBody = httpBody
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: GeminiResponse.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching content: \(error.localizedDescription)")
                    
                }
            } receiveValue: { response in
                if let candidate = response.candidates?.first,
                   let text = candidate.content?.parts?.first?.text {
                    print("Success: \(text)")
                    let request = NSFetchRequest<MyChats>(entityName: "MyChats")
                    request.predicate = NSPredicate(format: "name == %@", currentName)
                    do {
                        let chatsToUpdate = try self.container.viewContext.fetch(request)
                        for chat in chatsToUpdate {
                            chat.name = text
                        }
                        try self.container.viewContext.save()
                        
                        Task {
                            await self.updateMessageSent()
                            await self.refreshUI(chatName: text)
                            await self.sendToServer(userMessage: userMessage, chatName: text)
                            await self.updateMessageSent()
                            await self.refreshUI(chatName: text)
                        }
                        
                    } catch {
                        print("Error renaming chat: \(error)")
                    }
                } else {
                    print("No content returned")
                    Task {
                        await self.updateName(savedName: nil)
                    }
                    
                }
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    private func updateMessageSent() {
        self.isMessageSent.toggle()
    }
    
    @MainActor
    private func updateName(savedName: String?) {
        self.name = savedName
    }
    
    
    @MainActor
    private func refreshUI(chatName: String = "New Chat") {
        // Fetch updated messages from Core Data
        DispatchQueue.main.async {
            let request = NSFetchRequest<MyChats>(entityName: "MyChats")
            
            let request2 = NSFetchRequest<MyChats>(entityName: "MyChats")
            let predicates = NSPredicate(format: "name == %@", chatName)
            request2.predicate = predicates
            do {
                self.allChats = try self.container.viewContext.fetch(request)
                self.savedChats = self.allChats.reduce(into: [String: [MyChats]]()) { result, chat in
                    result[chat.name ?? "New Chat", default: []].append(chat)
                }.map { name, messages in
                    SavedChats(name: name, lastMessage: messages.last(where: { me in
                        me.isUser
                    })?.message ?? "",messages: messages)
                }
            } catch let error {
                print("Fetching Erooor \(error)")
            }
        }
    }
    
    
}



