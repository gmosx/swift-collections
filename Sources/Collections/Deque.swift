/// https://en.wikipedia.org/wiki/Double-ended_queue

// TODO: consider extending Queue?
// kind-of combines Queue + Stack (FIFO, LIFO)

/// A Double-Ended Queue (Deque) is a collection that generalizes a queue, for
/// which elements can be added to or removed from either the front (head) or
/// back (tail).
///
/// https://en.wikipedia.org/wiki/Double-ended_queue
public protocol Deque {
    associatedtype Element
}
