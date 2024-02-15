//
//  AllChatsView.swift
//  ChatApp
//
//  Created by Admin on 09/02/24.
//

import SwiftUI

struct AllChatsView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    @FocusState var focusState: Bool?
    
    var body: some View {
        VStack {
            HStack {
                Text("Gen AI Chat")
                    .font(.custom("Poppins-Regular", size: 26))
                    .foregroundColor(.white)
                
                Spacer()
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: $homeViewModel.searchText)
                        .textFieldStyle(.plain)
                        .focused($focusState, equals: false)
                        .submitLabel(.search)
                        .onAppear {
                            focusState = true
                        }
                }
                .padding(.vertical, 8)
                .padding(.horizontal)
                .background(.primary.opacity(0.15))
                .cornerRadius(10)
                .padding()
                
                Button {
                    
                } label: {
                    Image(systemName: "sidebar.right")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                .padding()
                .buttonStyle(.plain)
                
                
            }
            
            
            
            DetailView(focusState: $focusState)
            
//            List(selection: $homeViewModel.selectedRecentMessage) {
//                ForEach(homeViewModel.recentMessage) { msg in
////                    NavigationLink {
//                        DetailView(user: msg)
////                    } label: {
////                        RecentCardView(recentMessage: msg)
////                    }
//
//                }
//            }
//            .listStyle(SidebarListStyle())
        }
        .onAppear {
            focusState = true
        }
        .frame(maxWidth: screen.width)
    }
}

struct AllChatsView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
