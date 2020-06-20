//
//  Event.swift
//  
//
//  Created by Maddie Schipper on 6/20/20.
//

import Foundation

/// Event contains the information from a single event that will be processed by the engine's layers & sub-systems
public struct Event {
    /// Name contains the event system
    public struct Name : Equatable {
        private let rawValue: String
        
        public init(_ rawValue: String) {
            self.rawValue = rawValue
        }
        
        public static func ==(lhs: Self, rhs: Self) -> Bool {
            return lhs.rawValue == rhs.rawValue
        }
    }
    
    // The name of the event
    public let name: Event.Name
    
    // Optional additional event data
    public let data: Any?
    
    public init(_ name: Event.Name, _ data: Any? = nil) {
        self.name = name
        self.data = data
    }
}
