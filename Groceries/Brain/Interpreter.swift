import FMDB
import Foundation

enum ProductFields: String {
    case name
    case uid
    case enqueued
    case purchased
}

struct Interpreter {
    static func interpretProducts(_ fetchResult: FMResultSet) -> [Product] {
        var result = [Product]()
        while fetchResult.next() {
            guard
                let name = fetchResult.string(for: .name),
                let uid = fetchResult.int(for: .uid),
                let enqueued = fetchResult.bool(for: .enqueued) else {
                continue
            }

            let product = Product(uid: uid, name: name, enqueued: enqueued)
            result.append(product)
        }

        return result
    }
    
    static func interpretEnqueuedProducts(_ fetchResult: FMResultSet) -> [EnqueuedProduct] {
        var result = [EnqueuedProduct]()
        while fetchResult.next() {
            guard
                let name = fetchResult.string(for: .name),
                let uid = fetchResult.int(for: .uid),
                let enqueued = fetchResult.bool(for: .enqueued),
                let purchased = fetchResult.bool(for: .purchased) else {
                continue
            }

            let product = EnqueuedProduct(uid: uid, name: name, enqueued: enqueued, purchased: purchased)
            result.append(product)
        }

        return result
    }
}

extension FMResultSet {
    func string(for field: ProductFields) -> String? {
        return string(forColumn: field.rawValue)
    }

    func int(for field: ProductFields) -> Int? {
        let value = int(forColumn: field.rawValue)
        return Int(value)
    }

    func bool(for field: ProductFields) -> Bool? {
        return bool(forColumn: field.rawValue)
    }
}
