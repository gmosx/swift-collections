import XCTest
@testable import Collections

class RingBufferTests: XCTestCase {
    func testCount() {
        var buffer = RingBuffer<Int>(repeating: 0, count: 3)

        buffer.append(9)
        buffer.append(3)

        XCTAssertEqual(buffer.count, 2)

        buffer.append(4)
        buffer.append(5)
        buffer.append(6)

        XCTAssertEqual(buffer.count, 3)
        XCTAssertEqual(buffer.totalCount, 5)

        XCTAssertTrue(buffer.isFull)
    }

    func testCircularBehavior() {
        var buffer = RingBuffer<Int>(repeating: 0, count: 2)

        buffer.append(9)
        buffer.append(3)
        buffer.append(5)

        XCTAssertEqual(buffer[0], 3)
        XCTAssertEqual(buffer[1], 5)
    }

    func testIteration() {
        var buffer = RingBuffer<Int>(repeating: 0, count: 2)

        buffer.append(9)
        buffer.append(3)
        buffer.append(5)

        let sum = buffer.reduce(0, +)

        XCTAssertEqual(sum, 8)
    }

    func testCollection() {
        var buffer = RingBuffer<Int>(repeating: 0, count: 2)

        buffer.append(9)

        XCTAssertEqual(buffer.first, 9)
        XCTAssertEqual(buffer.last, 9)

        buffer.append(3)

        XCTAssertEqual(buffer.first, 9)
        XCTAssertEqual(buffer.last, 3)

        buffer.append(5)

        XCTAssertEqual(buffer.first, 3)
        XCTAssertEqual(buffer.last, 5)

        buffer.append(12)

        XCTAssertEqual(buffer.first, 5)
        XCTAssertEqual(buffer.last, 12)
    }

    func testCollection3() {
        var buffer = RingBuffer<Int>(repeating: 0, count: 3)

        buffer.append(9)

        XCTAssertEqual(buffer.first, 9)
        XCTAssertEqual(buffer.last, 9)

        buffer.append(3)

        XCTAssertEqual(buffer.first, 9)
        XCTAssertEqual(buffer.last, 3)

        buffer.append(5)

        XCTAssertEqual(buffer.first, 9)
        XCTAssertEqual(buffer.last, 5)
    }

    static var allTests = [
        ("testCount", testCount),
        ("testCircularBehavior", testCircularBehavior),
        ("testIteration", testIteration),
        ("testCollection", testCollection),
        ("testCollection3", testCollection3),
    ]
}
