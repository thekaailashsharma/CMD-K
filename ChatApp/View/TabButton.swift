//
//  TabButton.swift
//  ChatApp
//
//  Created by Admin on 09/02/24.
//

import SwiftUI

struct TabButton: View {
    
    var tabInfo: TabDefinition
    @Binding var selectedTab: Tabs
    
    var body: some View {
        Button {
            withAnimation {
                selectedTab = tabInfo.title
            }
        } label: {
            VStack(spacing: 7) {
                Image(systemName: tabInfo.image)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(selectedTab == tabInfo.title ? .white : .gray)
                
                Text(tabInfo.title.rawValue)
                    .font(.custom("Poppins-Regular", size: 9))
                    .font(.system(size: 9))
                    .foregroundColor(selectedTab == tabInfo.title ? .white : .gray)
                    .padding(.horizontal, 5)
                
            }
            .padding(.vertical, 8)
            .frame(width: 110)
            .contentShape(Rectangle())
            .background(.primary.opacity(selectedTab == tabInfo.title ? 0.15: 0))
            .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle())


    }
}

struct TabButton_Previews: PreviewProvider {
    static var previews: some View {
        TabButton(tabInfo: TabDefinition(image: "house", title: .allChats), selectedTab: .constant(.allChats))
    }
}
