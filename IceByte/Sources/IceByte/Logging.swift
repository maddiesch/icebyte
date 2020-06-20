//
//  Logging.swift
//  
//
//  Created by Maddie Schipper on 6/20/20.
//

import Foundation
import os.log

internal struct Logger {
    internal static let core = OSLog(subsystem: "app.icebyte.Core", category: "core")
    internal static let client = OSLog(subsystem: "app.icebyte.System", category: "client")
    internal static let performance = OSLog(subsystem: "app.icebyte.Core", category: "performance")
}

internal func EventLogger(_ event: Event) {
    os_log("Event Dispatched: %{public}@", log: Logger.core, type: .debug, event.name.rawValue)
}

internal func timed<T>(name: String, _ block: () throws -> T) rethrows -> T {
    let start = CFAbsoluteTimeGetCurrent()
    let out = try block()
    let end = CFAbsoluteTimeGetCurrent()
    
    let delta = (end - start) * 1000.0
    
    os_log("%{public}@: %0.03fms", log: Logger.performance, type: .debug, name, delta)
    
    return out
}
