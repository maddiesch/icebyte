//
//  Window.swift
//  
//
//  Created by Maddie Schipper on 6/20/20.
//

import Foundation

#if canImport(Cocoa)
import Cocoa

public final class Window : NSWindow {
    public override var acceptsMouseMovedEvents: Bool {
        get {
            return true
        }
        set {
            fatalError()
        }
    }
    
    public override func mouseDown(with event: NSEvent) {
        EventBus.main.dispatch(eventWithName: .mouseDown, data: event.locationInWindow)
    }
    
    public override func mouseUp(with event: NSEvent) {
        EventBus.main.dispatch(eventWithName: .mouseUp, data: event.locationInWindow)
    }
    
    public override func mouseMoved(with event: NSEvent) {
        EventBus.main.dispatch(eventWithName: .mouseMoved, data: event.locationInWindow)
    }
    
    public override func mouseExited(with event: NSEvent) {
        EventBus.main.dispatch(eventWithName: .mouseExited, data: event.locationInWindow)
    }
    
    public override func rightMouseDown(with event: NSEvent) {
        EventBus.main.dispatch(eventWithName: .rightMouseDown, data: event.locationInWindow)
    }
    
    public override func rightMouseUp(with event: NSEvent) {
        EventBus.main.dispatch(eventWithName: .rightMouseUp, data: event.locationInWindow)
    }
    
    public override func otherMouseDown(with event: NSEvent) {
        EventBus.main.dispatch(eventWithName: .otherMouseDown, data: event.locationInWindow)
    }
    
    public override func otherMouseUp(with event: NSEvent) {
        EventBus.main.dispatch(eventWithName: .otherMouseUp, data: event.locationInWindow)
    }
    
    public override func scrollWheel(with event: NSEvent) {
        if event.phase == .changed {
            if event.deltaY >= 1.0 {
                EventBus.main.dispatch(eventWithName: .scrollDown, data: event.deltaY)
            } else if event.deltaY <= -1.0 {
                EventBus.main.dispatch(eventWithName: .scrollUp, data: event.deltaY)
            }
            if event.deltaX >= 1.0 {
                EventBus.main.dispatch(eventWithName: .scrollRight, data: event.deltaX)
            } else if event.deltaY <= -1.0 {
                EventBus.main.dispatch(eventWithName: .scrollLeft, data: event.deltaX)
            }
        }
    }
    
    public override func keyDown(with event: NSEvent) {
        EventBus.main.dispatch(eventWithName: .keyDown, data: event.keyCode)
    }
    
    public override func keyUp(with event: NSEvent) {
        EventBus.main.dispatch(eventWithName: .keyUp, data: event.keyCode)
    }
}

internal extension Event.Name {
    static let mouseDown = Event.Name("mouseDown")
    static let rightMouseDown = Event.Name("rightMouseDown")
    static let otherMouseDown = Event.Name("otherMouseDown")
    static let mouseUp = Event.Name("mouseUp")
    static let rightMouseUp = Event.Name("rightMouseUp")
    static let otherMouseUp = Event.Name("otherMouseUp")
    static let mouseMoved = Event.Name("mouseMoved")
    static let mouseExited = Event.Name("mouseExited")
    static let scrollDown = Event.Name("scrollDown")
    static let scrollUp = Event.Name("scrollUp")
    static let scrollLeft = Event.Name("scrollLeft")
    static let scrollRight = Event.Name("scrollRight")
    
    static let keyDown = Event.Name("keyDown")
    static let keyUp = Event.Name("keyUp")
}

#endif
