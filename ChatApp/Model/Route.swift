//
//  Route.swift
//  ChatApp
//
//  Created by Admin on 15/02/24.
//

import Foundation

enum Route {
    case detailView(SavedChats)
}


class AppState: ObservableObject {
    @Published var routes: [Route] = []
    @Published var currentSavedChat: SavedChats? = nil
    
    var currentRoute: Route? {
        routes.last
    }
    
    func updateCurrentSavedChat(_ route: SavedChats) {
       currentSavedChat = route
    }
    
    func push(_ route: Route) {
        routes.append(route)
    }
    
    @discardableResult
    func pop() -> Route? {
        routes.popLast()
    }
}
