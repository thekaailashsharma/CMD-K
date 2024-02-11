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
        VStack {
            
            HStack {
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                .padding()
                .buttonStyle(.plain)

            }
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search", text: $homeViewModel.searchText)
                    .textFieldStyle(.plain)
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            .background(.primary.opacity(0.15))
            .cornerRadius(10)
            .padding()
            
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
        .frame(width: (screen.width / 1.2) / 4)
    }
}

struct AllChatsView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
