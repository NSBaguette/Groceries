//
//  Engine.swift
//  Groceries
//
//  Responsible for loading/updating data from db. That's all.
//
//  Created by Illia Akhaiev on 11/21/17.
//  Copyright © 2017 Illia Akhaiev. All rights reserved.
//

import FMDB
import Foundation

enum DatabaseAction: String {
    case testFetchEnqueuedProducts = """
    SELECT
        Products.Name,
        Products.uid,
        1 AS Enqueued,
        ProductsLists.Purchased
    FROM ProductsLists
    INNER JOIN Products
        ON ProductsLists.ProductID=Products.uid
        WHERE ProductsLists.ListID=1
        ORDER BY ProductsLists.Position
    """
    case testDequeueProduct = "DELETE FROM ProductsLists WHERE ListID = ? AND ProductId = ?"
    case testPurchaseProduct = "UPDATE ProductsLists SET Purchased=1 WHERE ListID=1 AND ProductId = ?"
    case testCreateNewProduct = "INSERT INTO Products (Name) VALUES (?)"
    case testFetchProducts = """
    SELECT
        Name,
        uid,
        CASE WHEN ProductsLists.ProductID IS NOT NULL
            THEN 1
            ELSE 0
        END AS Enqueued
    FROM Products
        LEFT JOIN ProductsLists
            ON Products.uid = ProductsLists.ProductID
            AND ProductsLists.ListID=1
    """
    case testEnqueueProduct = "INSERT INTO ProductsLists (Position, ListID, ProductId, Purchased) VALUES (?, 1, ?, 0)"
    case testFetchLastInsertedGrocery = """
    SELECT
        Name,
        uid,
        CASE WHEN ProductsLists.ProductID IS NOT NULL
            THEN 1
            ELSE 0
        END AS Enqueued
    FROM Products
        LEFT JOIN ProductsLists
            ON Products.uid = ProductsLists.ProductID
            AND ProductsLists.ListID=1
    ORDER BY uid DESC
    LIMIT 1
    """
}

final class FMDBDatabaseEngine: Engine {
    private let serialQueue = DispatchQueue(label: "com.twealm.groceries.db.serial")
    private var database: FMDatabase

    init(with url: URL) {
        database = FMDBDatabaseEngine.createDatabase(url.path, queue: serialQueue)
    }

    func executeFetchBlock(_ block: @escaping (FMDatabase) -> Void) {
        serialQueue.async {
            [weak self] in
            if let db = self?.database {
                autoreleasepool {
                    block(db)
                }
            }
        }
    }

    func executeUpdateBlock(_ block: @escaping (FMDatabase) -> Void) {
        serialQueue.async {
            [weak self] in
            if let db = self?.database {
                autoreleasepool {
                    block(db)
                }
            }
        }
    }

    deinit {
        database.close()
    }
}

extension FMDBDatabaseEngine {
    fileprivate static func createDatabase(_ path: String, queue: DispatchQueue) -> FMDatabase {
        let exists = FileManager.default.fileExists(atPath: path)
        let db = FMDatabase(path: path)

        if !exists {
            let schema = Bundle.main.path(forResource: "schema", ofType: "sql", inDirectory: "sql")!
            let st = try! String(contentsOf: URL(fileURLWithPath: schema))

            db.open()
            _ = db.executeStatements(st)

            #if DEBUG
                FMDBDatabaseEngine.prepareTestDatabase(db: db, queue: queue)
            #endif

        } else {
            db.open()
        }

        return db
    }
}

#if DEBUG
    extension FMDBDatabaseEngine {
        static func prepareTestDatabase(db: FMDatabase, queue _: DispatchQueue) {
            let url = Librarian.testSqlDirectory()

            do {
                let result = try FileManager.default.contentsOfDirectory(atPath: url.path)
                for item in result {
                    let itemUrl = url.appendingPathComponent(item, isDirectory: false)
                    let st = try! String(contentsOf: itemUrl)
                    _ = db.executeStatements(st)
                }
            } catch {
                print(error)
            }
        }
    }
#endif
