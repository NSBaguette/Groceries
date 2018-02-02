//
//  Librarian.swift
//  Groceries
//
//  Knows where to find all the files.
//
//  Created by Illia Akhaiev on 12/7/17.
//  Copyright © 2017 Illia Akhaiev. All rights reserved.
//

import Foundation

class Librarian {
    static func databasePath() -> URL {
        let dir = appSupportDirectory()

        do {
            try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true, attributes: [:])
        } catch {
            print(error)
        }

        let db = dir.appendingPathComponent("db.sqlite", isDirectory: false)
        return db
    }

    static func appSupportDirectory() -> URL {
        let library = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0]
        let appSupport = library.appendingPathComponent("Application Support", isDirectory: true)

        return appSupport
    }
}

#if DEBUG
    extension Librarian {
        static func testSqlDirectory() -> URL {
            let root = Bundle.main.resourceURL!
            let dir = root.appendingPathComponent("sql/test", isDirectory: true)

            return dir
        }
    }
#endif
