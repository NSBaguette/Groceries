import Foundation

typealias ProductId = Int

struct Product: Equatable {
    private(set) var uid: ProductId
    private(set) var name: String
    private(set) var enqueued: Bool
}

struct EnqueuedProduct: Equatable {
    private(set) var uid: ProductId
    private(set) var name: String
    private(set) var enqueued: Bool
    private(set) var purchased: Bool
}
