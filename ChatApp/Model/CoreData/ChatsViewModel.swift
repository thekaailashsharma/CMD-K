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
    @MainActor @Published var isMessageSent: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Chats")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        Task {
            await self.refreshUI()
        }

    }
    
    func saveMessage(message: String, isUserMessage: Bool) async {
        await self.updateMessageSent()
        let newChat = MyChats(context: container.viewContext)
        newChat.id = UUID()
        newChat.message = message
        newChat.isUser = isUserMessage
        newChat.date = Date()
        
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving chat message: \(error)")
        }
        
        Task {
            await refreshUI()
        }
        
        Task {
            await sendToServer(userMessage: message)
        }
    }
    
    private func sendToServer(userMessage: String) async {
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
                    do {
                        try self.container.viewContext.save()
                    } catch {
                        print("Error saving chat message: \(error)")
                    }
                    
                    Task {
                        await self.updateMessageSent()
                        await self.refreshUI()
                    }
                    
                } else {
                    print("No content returned")
                }
            }
            .store(in: &cancellables)
        
    }
    
    @MainActor
    private func updateMessageSent() {
        self.isMessageSent.toggle()
    }
    
    
    @MainActor
    private func refreshUI() {
        // Fetch updated messages from Core Data
        DispatchQueue.main.async {
            let request = NSFetchRequest<MyChats>(entityName: "MyChats")
            do {
                self.allChats = try self.container.viewContext.fetch(request)
                
            } catch let error {
                print("Fetching Erooor \(error)")
            }
        }
    }
    
    
}



