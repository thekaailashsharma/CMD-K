//
//  AppDelegate.swift
//  ChatApp
//
//  Created by Admin on 16/02/24.
//

import Foundation
import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    var hotkeyMonitor: Any?
    var isAppLaunched = false // Flag to track if app is already launched
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Set up hotkey monitoring
        hotkeyMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            if event.keyCode == 40 && event.modifierFlags.contains(.command) && !self.isAppLaunched {
                // Command + O is pressed (Change keycode and modifierFlags according to your desired hotkey)
                self.isAppLaunched = true
                DispatchQueue.main.async {
                    NSApp.activate(ignoringOtherApps: true) // Activate app
                    NSApp.mainWindow?.makeKeyAndOrderFront(nil) // Bring app window to front
                }
            }
            return event
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Remove hotkey monitoring
        if let monitor = hotkeyMonitor {
            NSEvent.removeMonitor(monitor)
        }
    }
}

