//
//  ChatAppApp.swift
//  ChatApp
//
//  Created by Admin on 09/02/24.
//

import SwiftUI
import HotKey

@main
struct ChatAppApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
//        WindowGroup {
            Settings {
                ContentView()
                    .frame(width: 400, height: 400)
            }
//            .commands {
//                ChatAppAppCommands(appDelegate: appDelegate)
//            }
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//        }
        .windowStyle(.hiddenTitleBar)
        
    }
}


class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    var popover = NSPopover.init()
    var statusBarItem: NSStatusItem?
    var contentView: ContentView!
    let hotKey = HotKey(key: .k, modifiers: .command)  // Global hotkey
    
    override class func awakeFromNib() {}
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        print("Application launched")
        NSApplication.shared.activate(ignoringOtherApps: true)
        
        contentView = ContentView()
        popover.animates = false
        popover.behavior = .transient
        popover.contentSize = NSSize(width: 400, height: 500)
        
        let contentVc = NSViewController()
        contentVc.view = NSHostingView(rootView: contentView.environmentObject(self))
        popover.contentViewController = contentVc
        
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        let itemImage = NSImage(systemSymbolName: "message", accessibilityDescription: "eye")
        itemImage?.isTemplate = true
        statusBarItem?.button?.image = itemImage
        statusBarItem?.button?.action = #selector(AppDelegate.togglePopover(_:))
        
        hotKey.keyUpHandler = {                                 // Global hotkey handler
            self.togglePopover()
        }
    }
    
    @objc func showPopover(_ sender: AnyObject? = nil) {
        if let button = statusBarItem?.button {
            NSApplication.shared.activate(ignoringOtherApps: true)
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    
    @objc func closePopover(_ sender: AnyObject? = nil) {
        popover.performClose(sender)
    }
    
    @objc func togglePopover(_ sender: AnyObject? = nil) {
        if popover.isShown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
}

struct ChatAppAppCommands: Commands {
    let appDelegate: AppDelegate

    var body: some Commands {
        CommandMenu("App") {
            Button("Launch App", action: {
                appDelegate.showPopover()
            })
        }
    }
}
