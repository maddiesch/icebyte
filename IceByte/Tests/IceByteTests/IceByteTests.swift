import XCTest
@testable import IceByte

final class IceByteTests: XCTestCase {
    func testIceByteEnginePrepare() throws {
        let engine = Engine()
        try engine.prepare()
    }
}
