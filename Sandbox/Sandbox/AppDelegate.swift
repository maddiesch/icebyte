//
//  AppDelegate.swift
//  Sandbox
//
//  Created by Maddie Schipper on 6/20/20.
//  Copyright © 2020 Maddie Schipper. All rights reserved.
//

import Cocoa
import SwiftUI
import IceByte

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let engine: Engine = Engine()
    
    var window: NSWindow! {
        return self.engine.window
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        try! self.engine.prepare()
        
        try! self.engine.present()
        
        self.engine.start()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
