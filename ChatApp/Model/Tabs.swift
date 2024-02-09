//
//  Tabs.swift
//  ChatApp
//
//  Created by Admin on 09/02/24.
//

import Foundation

struct TabDefinition {
    var image: String
    var title: Tabs
}

enum Tabs: String {
    case allChats = "All Chats"
    case edit = "Edit"
    case personal = "Personal"
    case Bots = "Bots"
    case Settings = "Settings"
}
