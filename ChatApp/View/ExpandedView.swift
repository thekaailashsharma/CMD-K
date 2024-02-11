//
//  ExpandedView.swift
//  ChatApp
//
//  Created by Admin on 11/02/24.
//

import SwiftUI

struct ExpandedView: View {
    var user: RecentMessage
    
    var body: some View {
        
        HStack {
            Divider()
            
            VStack(spacing: 25) {
                ImageView(urlString: user.userImage)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 90, height: 90)
                    .clipShape(Circle())
                    .padding(.top, 35)
                
                Text(user.userName)
                    .font(.title2)
                    .fontWeight(.bold)
                
                HStack {
                    Button {
                        
                    } label: {
                        
                    }
                    .buttonStyle(.plain)
                    
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct ExpandedView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
