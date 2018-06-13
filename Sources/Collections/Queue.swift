
// FIFO

// TODO: consider renaming to PriorityQueue? i.e. FIFO

/// A queue is a collection in which elements are kept in order and the only
/// operations are the addition of elements to the rear terminal position and
/// removal of elements from the front terminal position.
///
/// General names like `enqueue` and `dequeue` are used to make this protocol
/// as abstract as possible.
public protocol Queue {
    associatedtype Element

    func enqueue(_ element: Element) // i.e. append()
    func dequeue() -> Element // i.e removeFirst()
}

