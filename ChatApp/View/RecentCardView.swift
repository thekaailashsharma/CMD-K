//
//  RecentCardView.swift
//  ChatApp
//
//  Created by Admin on 10/02/24.
//

import SwiftUI

struct RecentCardView: View {
    var recentMessage: RecentMessage
    var body: some View {
        HStack {
            ImageView(urlString: recentMessage.userImage)
                .aspectRatio(contentMode: .fill)
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            VStack(spacing: 4) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(recentMessage.userName)
                            .font(.custom("Poppins-Regular", size: 13))
                            .foregroundColor(.white)
                        
                        Text(recentMessage.lastMsg)
                            .font(.custom("Poppins-Regular", size: 13))
                            .font(.system(size: 9))
                            .foregroundColor(.gray)
                        
                        
                    }
                    Spacer(minLength: 10)
                    VStack {
                        Text(recentMessage.lastMsgTime)
                            .font(.custom("Poppins-Regular", size: 13))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Text(recentMessage.pendingMsg)
                            .font(.custom("Poppins-Regular", size: 13))
                            .padding(5)
                            .foregroundColor(.white)
                            .background(Color.green.opacity(0.5))
                            .clipShape(Circle())
                        
                        
                        
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        
    }
}


struct RecentCardView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct ImageView: View {
    @ObservedObject private var imageViewModel: ImageViewModel
    
    init(urlString: String?) {
        imageViewModel = ImageViewModel(urlString: urlString)
    }
    
    var body: some View {
        Image(nsImage: imageViewModel.image ?? NSImage())
            .resizable()
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(urlString: "https://developer.apple.com/news/images/og/swiftui-og.png")
    }
}







