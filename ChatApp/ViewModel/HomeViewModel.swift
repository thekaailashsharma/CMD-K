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
    
    @Published var selectedRecentMessageid: UUID? = nil
    @Published var selectedRecentMessage: SavedChats? = nil
    
    @Published var searchText: String = ""
    @Published var message: String = ""
    @Published var savedName: String = ""
    
    @Published var isExpanded: Bool = false
    @Published var isSaveOpen: Bool = false
    
    @Published var displayedText = "Loading..."
    @Published var chatName = "New Chat"
    
    private var cancellables = Set<AnyCancellable>()
    
}


