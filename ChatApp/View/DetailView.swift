//
//  DetailView.swift
//  ChatApp
//
//  Created by Admin on 11/02/24.
//

import SwiftUI

struct DetailView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var chatsManager: ChatManager
    var savedMessage: SavedChats
    
    var body: some View {
        
        HStack {
            VStack {
                HStack {
                    Text("John Doe")
                        .font(.title2)
                        .foregroundColor(.white)
                    
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                    }.buttonStyle(.plain)
                    
                    Button {
                        homeViewModel.isExpanded.toggle()
                    } label: {
                        Image(systemName: "sidebar.right")
                            .font(.title2)
                            .foregroundColor(homeViewModel.isExpanded ? .primary : .blue)
                    }.buttonStyle(.plain)
                    
                }
                .padding()
                
                MessageView(recentMessage: savedMessage.messages, isChanged: $chatsManager.isMessageSent)
                
                Spacer()
                
                HStack(spacing: 15) {
                    TextField("Send a message", text: $homeViewModel.message)
                        .textFieldStyle(.plain)
                        .padding(.vertical, 8)
                        .padding(.horizontal)
                        .clipShape(Capsule())
                        .background(Capsule().strokeBorder(Color.white))
                    Button {
                        Task {
                            await chatsManager.saveMessage(message: homeViewModel.message, isUserMessage: true, chatName: savedMessage.name)
                            if (savedMessage.messages.count == 1) {
                                print("Insideee")
                                await chatsManager.getMessageName(userMessage: homeViewModel.message, currentName: "New Chat")
                            }
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
            
            //            if homeViewModel.isSaveOpen {
            //                SaveAlert(isShown: $homeViewModel.isSaveOpen)
            //            }
            
            //            ExpandedView(user: user)
            //                .frame(width: 200)
            //                .background(BlurView())
            
        }.ignoresSafeArea(.all, edges: .all)
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
