//
//  ContentView.swift
//  ChatApp
//
//  Created by Admin on 09/02/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
            .frame(minWidth: 400, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
            .background(VisualEffectView().ignoresSafeArea())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
