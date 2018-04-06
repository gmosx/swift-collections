
// TODO: consider renaming to PriorityQueue? i.e. FIFO

/// This protocol is as general as possible.
public protocol Queue {
    associatedtype Element

    func enqueue(_ element: Element)
    func dequeue() -> Element

//    func append(_ element: Element)
//    func removeFirst() -> Element
}

