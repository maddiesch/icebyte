//
//  DisplayLink.swift
//  
//
//  Created by Maddie Schipper on 6/20/20.
//

import Foundation
import CoreVideo

public class DisplayLink {
    public struct Error : Swift.Error {
        public let description: String
        
        internal init(_ description: String) {
            self.description = description
        }
    }
    
    private let link: CVDisplayLink!
    
    public var isRunning: Bool {
        return CVDisplayLinkIsRunning(link)
    }
    
    public init(display: CGDirectDisplayID) throws {
        var link: CVDisplayLink?
        
        guard CVDisplayLinkCreateWithCGDisplay(display, &link) == kCVReturnSuccess else {
            throw Error("Failed to create display link")
        }
        
        guard CVDisplayLinkSetOutputCallback(link!, ds_callback, nil) == kCVReturnSuccess else {
            throw Error("Failed to set display link callback")
        }
        
        self.link = link
    }
    
    deinit {
        self.stop()
    }
    
    public func start() {
        guard self.isRunning == false else {
            return
        }
        
        CVDisplayLinkStart(link)
    }
    
    public func stop() {
        guard self.isRunning else {
            return
        }
        
        CVDisplayLinkStop(link)
    }
}

internal extension Event.Name {
    static let render = Event.Name("render-frame")
}

fileprivate func ds_callback(_ link: CVDisplayLink, _ in: UnsafePointer<CVTimeStamp>, _ out: UnsafePointer<CVTimeStamp>, _ opts: CVOptionFlags, _ flags: UnsafeMutablePointer<CVOptionFlags>, _ ctx: UnsafeMutableRawPointer?) -> CVReturn {
    
    let event = Event(.render)
    
//    EventBus.main.dispatch(now: event)
    
    return kCVReturnSuccess
}
