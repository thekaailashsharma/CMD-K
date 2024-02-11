//
//  MessageView.swift
//  ChatApp
//
//  Created by Admin on 11/02/24.
//

import SwiftUI

struct MessageView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var recentMessage: RecentMessage
    
    var body: some View {
        GeometryReader { reader in
            ScrollView {
                VStack(spacing: 18) {
                    ForEach(recentMessage.allMessage) { message in
                        MessageCardView(message: message, userImage: recentMessage.userImage, width: reader.frame(in: .global).width)
                    }
                }
                
            }
        }
    }
}

struct MessageCardView: View {
    
    var message: Message
    var userImage: String
    var width: CGFloat
    
    var body: some View {
        
        HStack {
            if message.isMessageMine {
                HStack {
                    ImageView(urlString: userImage)
                        .background(.primary.opacity(0.3))
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                        .offset(y: 10)
                    
                    Text(message.message)
                        .font(.custom("Poppins-Regular", size: 13))
                        .font(.system(size: 9))
                        .padding(10)
                        .background(.primary.opacity(0.3))
                        .foregroundColor(.white)
                        .clipShape(MessageBubble())
                        .frame(minWidth: 0, maxWidth: width, alignment: .leading)
                }
            } else {
                Spacer ()
                Text(message.message)
                    .font(.custom("Poppins-Regular", size: 13))
                    .font(.system(size: 9))
                    .padding(10)
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(MyMessageBubble())
                    .frame(minWidth: 0, maxWidth: width / 2, alignment: .trailing)
                    
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        var homeViewModel = HomeViewModel()
        var recentMessage = dummyRecentMessages[0]
        MessageView(recentMessage: recentMessage)
            .environmentObject(homeViewModel)
    }
}


struct MessageBubble : Shape {
    
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let pt1 = CGPoint(x: 0, y: 0)
            let pt2 = CGPoint(x: rect.width, y: 0)
            let pt3 = CGPoint(x: rect.width, y: rect.height)
            let pt4 = CGPoint(x: 0, y: rect.height)
            
            path.move(to: pt4)
            
            path.addArc(tangent1End: pt4, tangent2End: pt1, radius: 15)
            path.addArc(tangent1End: pt1, tangent2End: pt2, radius: 15)
            path.addArc(tangent1End: pt2, tangent2End: pt3, radius: 15)
            path.addArc(tangent1End: pt3, tangent2End: pt4, radius: 15)
            
        }
    }
}

struct MyMessageBubble : Shape {
    
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let pt1 = CGPoint(x: 0, y: 0)
            let pt2 = CGPoint(x: rect.width, y: 0)
            let pt3 = CGPoint(x: rect.width, y: rect.height)
            let pt4 = CGPoint(x: 0, y: rect.height)
            
            path.move(to: pt3)
            
            path.addArc(tangent1End: pt3, tangent2End: pt4, radius: 15)
            path.addArc(tangent1End: pt4, tangent2End: pt1, radius: 15)
            path.addArc(tangent1End: pt1, tangent2End: pt2, radius: 15)
            path.addArc(tangent1End: pt2, tangent2End: pt3, radius: 15)
            
        }
    }
}
    
