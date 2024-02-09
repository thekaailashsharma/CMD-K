//
//  AllChatsView.swift
//  ChatApp
//
//  Created by Admin on 09/02/24.
//

import SwiftUI

struct AllChatsView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        List(selection: $homeViewModel.selectedRecentMessage) {
            ForEach(homeViewModel.recentMessage) { msg in
                NavigationLink {
                    Text("Destination")
                } label: {
                    RecentCardView(recentMessage: msg)
                }
            
            }
        }
        .listStyle(SidebarListStyle())
    }
}

struct AllChatsView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
