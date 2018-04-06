// https://en.wikipedia.org/wiki/Circular_buffer
// http://www.boost.org/doc/libs/1_39_0/libs/circular_buffer/doc/circular_buffer.html

/// A RingBuffer retains the last `n` appended values, where `n` is equal to the
/// `capacity` of the buffer. This buffer is always 'full'.
public struct RingBuffer<T> {
    private var elements: [T]
    private var appendPosition = 0

    public init<S>(_ sequence: S) where S : Sequence, Element == S.Element {
        elements = Array(sequence)
        appendPosition = elements.count
    }
    public init(repeating: T, count: Int) {
        elements = [T](repeating: repeating, count: count)
        appendPosition = elements.count
    }

    public var capacity: Int {
        return elements.count
    }

    public var count: Int {
        return elements.count
    }

    public mutating func append(_ element: T) {
        elements[appendPosition % capacity] = element
        appendPosition += 1
    }
}

public struct RingBufferIterator<T>: IteratorProtocol {
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

extension RingBuffer: Sequence {
    public typealias Element = T

    public func makeIterator() -> RingBufferIterator<T> {
        return RingBufferIterator<T>(self)
    }
}

extension RingBuffer: Collection {
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
            assert((startIndex..<endIndex).contains(i), "Index out of bounds")
            return elements[(appendPosition + i) % capacity]
        }
    }
}

extension RingBuffer: BidirectionalCollection {
    public func index(before i: Int) -> Int {
        assert(i > 0)
        return i - 1
    }
}

extension RingBuffer: ExpressibleByArrayLiteral {
    public init(arrayLiteral: Element...) {
        self.init(arrayLiteral)
    }
}
