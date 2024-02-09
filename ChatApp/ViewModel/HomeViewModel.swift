//
//  HomeViewModel.swift
//  ChatApp
//
//  Created by Admin on 09/02/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var selectedTab :Tabs = .allChats
}
