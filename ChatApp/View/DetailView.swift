//
//  DetailView.swift
//  ChatApp
//
//  Created by Admin on 11/02/24.
//

import SwiftUI
import Combine

struct DetailView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var chatsManager: ChatManager
    var focusState: FocusState<Bool?>.Binding
    
    var body: some View {
        
        HStack {
            VStack {
                MessageView(isSearching: homeViewModel.searchText.isEmpty, recentMessage: homeViewModel.searchText.isEmpty ? chatsManager.allChats : chatsManager.filteredChats)
                    .onChange(of: homeViewModel.searchText) { newValue in
                        self.addSubscribers()
                    }
                
                Spacer()
                
                HStack(spacing: 15) {
                    TextField("Send a message", text: $homeViewModel.message)
                        .textFieldStyle(.plain)
                        .padding(.vertical, 8)
                        .padding(.horizontal)
                        .clipShape(Capsule())
                        .background(Capsule().strokeBorder(Color.white))
                        .focused(focusState, equals: true)
                        .submitLabel(.done)
                        .onSubmit {
                            Task {
                                await chatsManager.saveMessage(message: homeViewModel.message, isUserMessage: true)
                            }
                        }
                    Button {
                        Task {
                            await chatsManager.saveMessage(message: homeViewModel.message, isUserMessage: true)
                        }
                    } label: {
                        Image(systemName: "paperplane")
                            .font(.title2)
                    }
                    .buttonStyle(.plain)

                }
                .padding([.horizontal, .bottom])
                
            }
            .padding()
            
//            ExpandedView(user: user)
//                .frame(width: 200)
//                .background(BlurView())
        
        }
        .ignoresSafeArea(.all, edges: .all)
        
    }
    
    private func addSubscribers() {

        homeViewModel.$searchText
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { searchText in
                self.filterChats(searchText: searchText)
            }
            .store(in: &chatsManager.cancellables2)
    }
    
    @MainActor
    private func filterChats(searchText: String) {
        guard !searchText.isEmpty else {
            chatsManager.filteredChats = []
            return
        }
        
        let searchTokens = searchText.lowercased().split(separator: " ")
        chatsManager.filteredChats = chatsManager.allChats.filter { chat in
            // Check for partial matches in message content
            let messageMatches = searchTokens.contains { token in
                guard let message = chat.message?.lowercased() else { return false }
                return message.contains(token)
            }
            
            // Check for partial matches in sender name
            let nameMatches = searchTokens.contains { token in
                guard let name = chat.name?.lowercased() else { return false }
                return name.contains(token)
            }
            
            return messageMatches || nameMatches
        }
        
        print("Filtered chats: \(chatsManager.filteredChats)")
    }

}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
