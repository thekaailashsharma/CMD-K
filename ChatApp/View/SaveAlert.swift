//
//  SaveAlert.swift
//  ChatApp
//
//  Created by Admin on 14/02/24.
//

import SwiftUI

struct SaveAlert: View {
    @Binding var isShown: Bool
    @State var text: String = ""
    var body: some View {
        VStack() {
            Button {
                
            } label: {
                Text("Save")
                    .font(.custom("Poppins-regular", size: 20))
            }
            .buttonStyle(.plain)

        }
        .padding()
        .alert(isPresented: $isShown, content: {
            Alert(title: Text("Save Chat"),
                  message: Text("Enter your chat message"),
                  primaryButton: .default(Text("Save"), action: {
            }),
            secondaryButton: .cancel()
            )
        })
    }
}

