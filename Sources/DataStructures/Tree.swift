public protocol TreeNode {
    var parent: Self? { get set }
    var children: [Self] { get set }
}
