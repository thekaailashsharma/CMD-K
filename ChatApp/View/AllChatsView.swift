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
            Text("Gen AI Chat")
                .font(.custom("Poppins-Regular", size: 19))
                .foregroundColor(.white)
                .padding(.bottom)
            
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
            
            
            
            
            
            DetailView(focusState: $focusState)
            
            
               
        }
        .onAppear {
            focusState = true
        }
    }
}

struct AllChatsView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
