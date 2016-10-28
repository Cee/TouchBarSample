//
//  AppDelegate.swift
//  TouchBarSample
//
//  Created by Cee on 10/28/16.
//  Copyright © 2016 Cee. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var windowController: NSWindowController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let windowController = WindowController()
        windowController.showWindow(self)
        self.windowController = windowController

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}

