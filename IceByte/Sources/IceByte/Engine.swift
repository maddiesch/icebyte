//
//  Engine.swift
//  
//
//  Created by Maddie Schipper on 6/20/20.
//

import Foundation
import Combine
import os.log

#if canImport(Cocoa)
import Cocoa
#endif

#if canImport(QuartzCore)
import QuartzCore
#endif

public final class Engine {
    public init() {}
    
    private var observers = Set<AnyCancellable>()
    
    private var timer: Timer!
    
    public func prepare() throws {
        os_log("IceByte Preparing", log: Logger.core, type: .info)
        
        EventBus.main.publisher.sink(receiveValue: EventLogger).store(in: &observers)
        
        let timer = Timer(fire: Date(), interval: 0.05, repeats: true, block: tickFireHandler)
        
        self.timer = timer
    }
    
    deinit {
        self.observers.cancel()
    }
    
    public func start() {
        self.link?.start()
        
        RunLoop.main.add(self.timer, forMode: .default)
    }
    
    private func tickFireHandler(_ timer: Timer) {
        EventBus.main.pump()
    }
    
    #if canImport(Cocoa)
    
    public private(set) var window: Window?
    public private(set) var controller: NSWindowController?
    
    private var link: DisplayLink?
    
    public func present() throws {
        let frame = CGRect(x: 0.0, y: 0.0, width: 1280.0, height: 720.0)
        let window = Window(contentRect: frame, styleMask: [.resizable, .titled], backing: .buffered, defer: false)
        window.minSize = CGSize(width: 640.0, height: 360.0)
        let controller = NSWindowController(window: window)
        
        self.controller = controller
        self.window = window
        
        window.makeKeyAndOrderFront(self)
        
        self.link = try DisplayLink(display: CGMainDisplayID())
    }
    
    #endif
}

fileprivate extension Set where Element == AnyCancellable {
    mutating func cancel() {
        for canceler in self {
            canceler.cancel()
        }
        self.removeAll()
    }
}
