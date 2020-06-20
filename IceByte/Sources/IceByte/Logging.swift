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
}
