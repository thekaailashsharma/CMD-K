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
    @State private var searchText = ""
    
    var body: some View {
        
        HStack(spacing: 0) {
            AllChatsView()
                .padding()
                .padding(.top, 30)
                .background(.ultraThickMaterial)
            
            
            
            
        }
        .searchable(text: $chatsManager.searchText)
        .ignoresSafeArea(.all, edges: .all)
        .environmentObject(homeViewModel)
        .environmentObject(chatsManager)
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

