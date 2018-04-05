import XCTest
@testable import DataStructures

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
                
        let sum = buffer.reduce(0) {
            sum, x in sum + x
        }
        
        XCTAssertEqual(sum, 8)
    }
}
