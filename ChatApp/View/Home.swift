//
//  Home.swift
//  ChatApp
//
//  Created by Admin on 09/02/24.
//

import Foundation
import SwiftUI


var screen = NSScreen.main!.visibleFrame
struct Home: View {
    
    @StateObject var homeViewModel = HomeViewModel()
    @StateObject var chatsManager = ChatManager()
    @StateObject var appState = AppState()
    @State var currentSavedChat: SavedChats = SavedChats()
    
    var body: some View {
        
        NavigationView {
            HStack(spacing: 0) {
                VStack {
                    TabButton(tabInfo: TabDefinition(image: "message", title: .allChats), selectedTab: $homeViewModel.selectedTab)
                    
                    TabButton(tabInfo: TabDefinition(image: "person.fill", title: .personal), selectedTab: $homeViewModel.selectedTab)
                    
                    TabButton(tabInfo: TabDefinition(image: "bubble.middle.bottom", title: .Bots), selectedTab: $homeViewModel.selectedTab)
                    
                    TabButton(tabInfo: TabDefinition(image: "slider.horizontal.3", title: .edit), selectedTab: $homeViewModel.selectedTab)
                    
                    Spacer()
                    
                    TabButton(tabInfo: TabDefinition(image: "gear", title: .Settings), selectedTab: $homeViewModel.selectedTab)
                }
                .padding()
                .padding(.top, 30)
                .background(.ultraThickMaterial)
                
                
                ZStack {
                    switch homeViewModel.selectedTab {
                    case .Bots : Text(homeViewModel.selectedTab.rawValue)
                    case .allChats:
                        NavigationView {
                            List(selection: $homeViewModel.selectedRecentMessage) {
                                ForEach(chatsManager.savedChats, id: \.name) { msg in
                                    Button {
                                        withAnimation {
                                            appState.push(.detailView(msg))
                                            appState.updateCurrentSavedChat(msg)
                                            currentSavedChat = msg
                                        }
                                    } label: {
                                        RecentCardView(recentMessage: dummyRecentMessages[0], savedChats: msg)
                                          
                                    }.buttonStyle(.plain)
                                        .padding()

                                    
                                    
                                }
                            }
                            AllChatsView(savedMessage: $currentSavedChat)
                        }
                    case .edit:
                        Text(homeViewModel.selectedTab.rawValue)
                        
                    case .personal:
                        Text(homeViewModel.selectedTab.rawValue)
                        
                    case .Settings:
                        Text(homeViewModel.selectedTab.rawValue)
                        
                        
                    }
                }
                
            }
        }.ignoresSafeArea(.all, edges: .all)
        //            .frame(width: screen.width / 1.2, height: screen.height - 60)
            .environmentObject(homeViewModel)
            .environmentObject(chatsManager)
            .environmentObject(appState)
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

