
// LIFO

public protocol Stack {
    associatedtype Element

    func push(_ element: Element)
    func pop() -> Element

    func append(_ element: Element)
    func removeLast() -> Element
}
