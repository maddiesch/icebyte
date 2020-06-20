//
//  EventBus.swift
//  
//
//  Created by Maddie Schipper on 6/20/20.
//

import Foundation
import Combine
import os.log

internal final class EventBus {
    internal static let main = EventBus()
    
    private let _queue = DispatchQueue(label: "app.icebyte.Dispatch")
    private let _process = DispatchQueue(label: "app.icebyte.Dispatch-Processor")
    
    private var _events = Array<Event>()
    
    private var _publisher = PassthroughSubject<Event, Never>()
    
    internal var publisher: AnyPublisher<Event, Never> {
        return self._publisher.eraseToAnyPublisher()
    }
    
    internal func dispatch(eventWithName name: Event.Name, data: Any? = nil) {
        self.dispatch(Event(name, data))
    }
    
    internal func dispatch(_ event: Event) {
        self._queue.async {
            self._events.append(event)
        }
    }
    
    internal func dispatch(now event: Event) {
        self._process.sync {
            timed(name: "publish-event") {
                self._publisher.send(event)
            }
        }
    }
    
    internal func pump(budget: Double = 5.0) {
        self._queue.sync {
            let start = CFAbsoluteTimeGetCurrent()
            
            guard self._events.count > 0 else {
                return
            }
            
            repeat {
                if CFAbsoluteTimeGetCurrent() - start >= budget / 1000.0 {
                    os_log("EventBus time over budget %{public}d", log: Logger.core, type: .error, self._events.count)
                    return
                }
                let event = self._events.removeFirst()
                
                self.dispatch(now: event)
            } while self._events.count > 0
        }
    }
    
    internal func wait() {
        self._process.sync(flags: .barrier, execute: {})
    }
}

public extension Subscribers.Sink {
    convenience init(receiveValue: @escaping ((Input) -> Void)) {
        self.init(receiveCompletion: {_ in}, receiveValue: receiveValue)
    }
}
