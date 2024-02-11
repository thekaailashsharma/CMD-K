//
//  HomeViewModel.swift
//  ChatApp
//
//  Created by Admin on 09/02/24.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var selectedTab :Tabs = .allChats
    
    @Published var recentMessage: [RecentMessage] = dummyRecentMessages
    
    @Published var selectedRecentMessage: String? = dummyRecentMessages.first?.id
    
    @Published var searchText: String = ""
}


