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
    
    
    var body: some View {
        
        NavigationView {
            HStack(spacing: 0) {
                AllChatsView()
                .padding()
                .padding(.top, 30)
                .background(.ultraThinMaterial)
               
                
                
                
            }
        }.ignoresSafeArea(.all, edges: .all)
//            .frame(maxWidth: screen.width / 1.2, maxHeight: screen.height - 60)
            .environmentObject(homeViewModel)
            .environmentObject(chatsManager)
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

