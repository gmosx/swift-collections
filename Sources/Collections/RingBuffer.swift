// https://en.wikipedia.org/wiki/Circular_buffer
// http://www.boost.org/doc/libs/1_39_0/libs/circular_buffer/doc/circular_buffer.html

public struct RingBufferIterator<T>: IteratorProtocol {
    public typealias Element = T

    let ringBuffer: RingBuffer<T>
    var position: Int

    init(_ ringBuffer: RingBuffer<T>) {
        self.ringBuffer = ringBuffer
        self.position = ringBuffer.startIndex
    }

    public mutating func next() -> T? {
        if (position < ringBuffer.endIndex) {
            let value = ringBuffer[position]
            position += 1
            return value
        } else {
            return nil
        }
    }
}

// TODO: Conform to ExpressibleByArrayLiteral
// TODO: consider `position`, `tail`
// TODO: conform to Queue protocol
// TODO: what about value/reference semantics? COW?
// TODO: position -> index?

public struct RingBuffer<T> {
    private var elements: [T]
    private var appendPosition = 0
    public let capacity: Int

    public init(repeating: T, count: Int) {
        self.elements = [T](repeating: repeating, count: count)
        self.capacity = count

        elements.reserveCapacity(count)
    }

    public var count: Int {
        return Swift.min(capacity, totalCount)
    }

    public var totalCount: Int { // TODO: better name? accoumulatedCount
        return appendPosition
    }

    public var isFull: Bool {
        return capacity <= totalCount
    }

    public mutating func append(_ element: T) {
        elements[appendPosition % capacity] = element
        appendPosition += 1
    }
}

extension RingBuffer: Sequence {
    public typealias Element = T

    public func makeIterator() -> RingBufferIterator<T> {
        return RingBufferIterator<T>(self)
    }
}

extension RingBuffer: Collection {
    private func wrap(_ i: Int) -> Int {
        if capacity < totalCount {
            return (appendPosition + i) % capacity
        } else {
            return i
        }
    }

    public var startIndex: Int {
        return 0
    }

    public var endIndex: Int {
        return count
    }

    public func index(after i: Int) -> Int {
        assert(i < endIndex)
        return i + 1
    }

    public subscript(i: Int) -> Element {
        get {
            // precondition((startIndex..<endIndex).contains(i), "Index out of bounds")
            return elements[wrap(i)]
        }
    }
}

extension RingBuffer: BidirectionalCollection {
    public func index(before i: Int) -> Int {
        assert(i > 0)
        return i - 1
    }
}
