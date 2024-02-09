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
            .background(VisualEffectView().ignoresSafeArea())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
