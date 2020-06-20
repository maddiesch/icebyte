import XCTest
import Combine
@testable import IceByte

extension Event {
    init(_ name: String, _ data: Any? = nil) {
        self.init(Event.Name(name), data)
    }
}

final class IceByteTests: XCTestCase {
    func testIceByteEnginePrepare() throws {
        let engine = Engine()
        try engine.prepare()
    }
    
    func testDispatchPump() {
        let e1 = Event("test-event-1")
        let e2 = Event("test-event-2")
        
        EventBus.main.dispatch(e1)
        EventBus.main.dispatch(e2)
        
        let canceler = EventBus.main.publisher.sink(receiveValue: EventLogger)
        
        EventBus.main.pump()
        EventBus.main.wait()
        
        canceler.cancel()
    }
}
