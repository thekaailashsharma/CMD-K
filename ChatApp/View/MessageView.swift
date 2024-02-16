//
//  MessageView.swift
//  ChatApp
//
//  Created by Admin on 11/02/24.
//

import SwiftUI

struct MessageView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var chatsManager: ChatManager
    var isSearching: Bool
    
    var recentMessage: [MyChats]
    
    var body: some View {
        GeometryReader { reader in
            ScrollView {
                ScrollViewReader { proxy in
                    VStack(spacing: 18) {
                        ForEach(recentMessage) { message in
                            
                            MessageCardView(message: message, width: reader.frame(in: .global).width)
                                .padding(.horizontal, 20)
                                .id(recentMessage.firstIndex(of: message))
                        }
                        .background(
                            GeometryReader { geometry in
                                Color.clear
                                    .onAppear {
                                        if recentMessage.count > 0 {
                                            withAnimation(.easeInOut(duration: 100)) {
                                                proxy.scrollTo(recentMessage.count - 1, anchor: .bottomLeading)
                                            }
                                            
                                        }
                                    }
                            }
                        )
                        .background(
                            GeometryReader { geometry in
                                Color.clear
                                    .onAppear {
                                        if !chatsManager.filteredChats.isEmpty && !homeViewModel.searchText.isEmpty {
                                            withAnimation(.easeInOut(duration: 100)) {
                                                proxy.scrollTo(recentMessage.firstIndex(of: chatsManager.filteredChats.first!), anchor: .bottomLeading)
                                            }
                                            
                                        }
                                    }
                            }
                        )
                        
                        
                    }
                    .padding(.vertical, 20)
                    
                }
            }
        }
    }
}

struct MessageCardView: View {
    
    var message: MyChats
    var userImage: String = dummyRecentMessages[0].userImage
    var width: CGFloat
    
    @State var isPasteVisible: Bool  = false
    
    var body: some View {
        
        HStack {
            if !message.isUser {
                
                HStack {
                    ImageView(urlString: userImage)
                        .background(.primary.opacity(0.3))
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                        .offset(y: 10)
                    
                    VStack {
                        
                        Text(LocalizedStringKey(message.message ?? ""))
                            .font(.custom("Poppins-Regular", size: 13))
                            .font(.system(size: 9))
                            .foregroundColor(.white)
                            .frame(minWidth: 0, maxWidth: width, alignment: .leading)
                            .padding(10)
                        
                        Spacer()
                        
                        HStack {
                            
                            Spacer()
                            
                            
                            Button {
                                withAnimation(.interactiveSpring()) {
                                    isPasteVisible.toggle()
                                    let pasteBoard = NSPasteboard.general
                                    pasteBoard.clearContents()
                                    pasteBoard.writeObjects([(message.message ?? "") as NSString])
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        isPasteVisible.toggle()
                                    }
                                }
                            } label: {
                                Image(systemName: isPasteVisible ? "checkmark" : "doc.on.doc")
                                    .frame(width: 30, height: 30)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            }
                            .buttonStyle(.plain)
                            .padding([.trailing, .bottom], 10)
                            
                        }
                    }
                    .frame(minWidth: 0, maxWidth: width, alignment: .leading)
                    .background(.tertiary.opacity(0.3).blendMode(.lighten))
                    .clipShape(MessageBubble())
                    .padding(.horizontal, 10)
                    
                    
                }
            } else {
                Spacer ()
                Text(message.message ?? "")
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

//struct MessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        var homeViewModel = HomeViewModel()
////        var recentMessage = dummyRecentMessages[0]
////        MessageView(recentMessage: recentMessage)
////            .environmentObject(homeViewModel)
//    }
//}


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

