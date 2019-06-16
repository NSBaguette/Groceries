//
//  NBGDatabaseEngine+Debug.m
//  Groceries
//
//  Created by Illia Akhaiev on 6/11/19.
//  Copyright © 2019 Illia Akhaiev. All rights reserved.
//

#import <FMDB/FMDB.h>
#import "NBGDatabaseEngine+Debug.h"
#import "NSString+NBGSQLStatements.h"
#import "NBGLibrarian.h"

#if DEBUG
@implementation NBGDatabaseEngine (Debug)

- (void)prepareTestDatabase:(FMDatabaseQueue *)databaseQueue {
    NSURL *url = [NBGLibrarian testSqlDirectory];
    NSError *error = nil;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:url.path error:&error];
    for (NSString *file in files) {
        NSURL *itemUrl = [url URLByAppendingPathComponent:file isDirectory:false];
        NSString *statement = [NSString loadStatementsAtPath:itemUrl.path];
        if (statement == nil) { continue; }
        [databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
            [db executeStatements:statement];
        }];
    }
}

@end
#endif
