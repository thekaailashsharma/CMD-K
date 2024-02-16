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
                        .submitLabel(.send)
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
        
        let modifiedSearchText = searchText.lowercased()
        
        chatsManager.filteredChats = chatsManager.allChats.filter({ chats in
            let messageContainsSearch = chats.message?.contains(modifiedSearchText) ?? false
            let nameContainsSearch = chats.name?.contains(modifiedSearchText) ?? false
            
            return messageContainsSearch || nameContainsSearch
        })
        
        print("Filterrrr is \(chatsManager.filteredChats)")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
