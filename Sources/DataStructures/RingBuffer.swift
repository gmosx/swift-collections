public struct RingBufferIterator<T>: IteratorProtocol {
    public typealias Element = T
    
    let ringBuffer: RingBuffer<T>
    var position: Int = 0
    
    init(_ ringBuffer: RingBuffer<T>) {
        self.ringBuffer = ringBuffer
    }
    
    public mutating func next() -> T? {
        if (position < ringBuffer.count) {
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

/// The buffer is always 'full', non-resizable.
/// https://en.wikipedia.org/wiki/Circular_buffer
/// http://www.boost.org/doc/libs/1_39_0/libs/circular_buffer/doc/circular_buffer.html
public struct RingBuffer<T> {
    private var elements: [T?]
    private var appendPosition = 0 // TODO: somehow expose this.

    public init(count: Int) {
        self.elements = [T?](repeating: nil, count: count)
    }
    
    public init(repeating: T, count: Int) {
        self.elements = [T?](repeating: repeating, count: count)
    }

    public var capacity: Int {
        return elements.capacity
    }
    
    public var count: Int {
        return Swift.min(appendPosition, capacity)
    }
    
    public mutating func append(_ element: T) {
        elements[appendPosition % capacity] = element
        appendPosition += 1
    }
}

extension RingBuffer: Sequence {
    public typealias Element = T

    public func makeIterator() -> RingBufferIterator<T> {
        return RingBufferIterator(self)
    }
}

extension RingBuffer: Collection {
    public var startIndex: Int {
        return 0
    }

    public var endIndex: Int {
        return elements.count
    }

    public func index(after i: Int) -> Int {
        precondition(i < endIndex)
        return i + 1
    }

    public subscript(i: Int) -> Element {
        get {
            precondition((startIndex..<endIndex).contains(i), "Index out of bounds")
            return elements[(i + count - 1) % capacity]!
        }
    }

    // TODO: first, last, [-index]
}
