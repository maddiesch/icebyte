//
//  Engine.swift
//  
//
//  Created by Maddie Schipper on 6/20/20.
//

import Foundation
import os.log

public final class Engine {
    public init() {}
    
    public func prepare() throws {
        os_log("IceByte Preparing", log: Logger.core, type: .info)
    }
}
