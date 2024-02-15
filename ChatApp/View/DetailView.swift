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
    var focusState: FocusState<Bool?>.Binding
    
    var body: some View {
        
        HStack {
            VStack {
                MessageView(recentMessage: chatsManager.allChats)
                
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
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
