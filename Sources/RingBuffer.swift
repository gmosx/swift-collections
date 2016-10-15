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

/// The buffer is always 'full', non-resizable.
/// https://en.wikipedia.org/wiki/Circular_buffer
/// http://www.boost.org/doc/libs/1_39_0/libs/circular_buffer/doc/circular_buffer.html
public struct RingBuffer<T>: Sequence {
    private var elements: [T?]
    private var appendPosition = 0

    public init(capacity: Int) {
        self.elements = [T?](repeating: nil, count: capacity)
    }
    
    public init(repeating: T, count: Int) {
        self.elements = [T?](repeating: repeating, count: count)
    }

    public var capacity: Int {
        return elements.capacity
    }
    
    public var count: Int {
        return capacity
    }
    
    public mutating func append(_ element: T) {
        elements[appendPosition % capacity] = element
        appendPosition += 1
    }
    
    public subscript(i: Int) -> T? {
        get {
            return elements[(i + count - 1) % capacity]
        }
    }
    
    public var first: T? {
        return nil // TODO: implement me
    }
    
    public var last: T? {
        return nil // TODO: implement me
    }
    
    // MARK: Sequence conformance
    
    public func makeIterator() -> RingBufferIterator<T> {
        return RingBufferIterator(self)
    }
    
    // TODO: first, last, [-index]
}
