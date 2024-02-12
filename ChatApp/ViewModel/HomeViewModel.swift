//
//  HomeViewModel.swift
//  ChatApp
//
//  Created by Admin on 09/02/24.
//

import Foundation
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var selectedTab :Tabs = .allChats
    
    @Published var recentMessage: [RecentMessage] = dummyRecentMessages
    
    @Published var selectedRecentMessage: String? = dummyRecentMessages.first?.id
    
    @Published var searchText: String = ""
    @Published var message: String = ""
    
    @Published var isExpanded: Bool = false
    
    @Published var displayedText = "Loading..."
    
    private var cancellables = Set<AnyCancellable>()
    
}


