//
//  DatabaseController.swift
//  Groceries
//
//  Created by Illia Akhaiev on 11/21/17.
//  Copyright © 2017 Illia Akhaiev. All rights reserved.
//

import Foundation
import FMDB

protocol DatabaseEngineUser {
    func injectDatabase(_ engine: DatabaseEngine);
}

protocol DatabaseEngine {
    func executeFetchBlock(_ block: @escaping (FMDatabase) -> ())
}

final class FMDBDatabaseEngine: DatabaseEngine {
    private let serialQueue = DispatchQueue(label: "com.twealm.groceries.db.serial")
    private var database: FMDatabase
    
    init(with url: URL) {
        database = FMDBDatabaseEngine.createDatabase(url.path, queue: serialQueue)
    }
    
    func executeFetchBlock(_ block: @escaping (FMDatabase) -> ()) {
        serialQueue.async {
            [weak self] in
            if let db = self?.database {
                autoreleasepool {
                    block(db)
                }
            }
        }
    }
    
    static func createDatabase(_ path: String, queue: DispatchQueue) -> FMDatabase {
        let exists = FileManager.default.fileExists(atPath: path)
        let db = FMDatabase(path: path)
        
        if !exists {
            let schema = Bundle.main.path(forResource: "schema", ofType: "sql", inDirectory: "sql")!
            let st = try! String(contentsOf: URL(fileURLWithPath: schema))
            
            db.open()
            let _ = db.executeStatements(st)
            
            #if DEBUG
                FMDBDatabaseEngine.prepareTestDatabase(db: db, queue: queue)
            #endif
            
        } else {
            db.open()
        }
        
        return db
    }
    
    deinit {
        database.close()
    }
}

#if DEBUG
    extension FMDBDatabaseEngine {
        static func prepareTestDatabase(db: FMDatabase, queue: DispatchQueue) {
            let url = Librarian.testSqlDirectory()
            
            do {
                let result = try FileManager.default.contentsOfDirectory(atPath: url.path)
                for item in result {
                    let itemUrl = url.appendingPathComponent(item, isDirectory: false)
                    let st = try! String(contentsOf: itemUrl)
                    let _ = db.executeStatements(st)
                }
            } catch {
                print(error)
            }
        }
    }
#endif
