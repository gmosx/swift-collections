public protocol Queue {
    associatedtype Element

    func enqueue(element: Element)
    func dequeue() -> Element
}

