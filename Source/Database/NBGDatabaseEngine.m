//
//  FMDBDatabaseEngine.m
//  Groceries
//
//  Created by Illia Akhaiev on 6/11/19.
//  Copyright © 2019 Illia Akhaiev. All rights reserved.
//

#import "NBGDatabaseEngine.h"
#import <FMDB/FMDB.h>
#import "NSString+NBGSQLStatements.h"
#import "NBGDatabaseEngine+Debug.h"

@interface NBGDatabaseEngine ()
@property (nonatomic, strong) FMDatabaseQueue *databaseQueue;
- (FMDatabaseQueue *)createDatabase:(NSURL *)path;
@end

@implementation NBGDatabaseEngine
- (instancetype)initWithUrl:(NSURL *)url {
    self = [super init];
    self.databaseQueue = [self createDatabase:url];
    return self;
}

- (void)executeFetchBlock:(nonnull void (^)(FMDatabase * _Nonnull))fetchBlock {
    if (fetchBlock == nil) { return; }

    [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        fetchBlock(db);
    }];
}

- (void)executeUpdateBlock:(nonnull void (^)(FMDatabase * _Nonnull))updateBlock {
    if (updateBlock == nil) { return; }

    [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        updateBlock(db);
    }];
}

- (FMDatabaseQueue *)createDatabase:(NSURL *)url {
    BOOL databaseExists = [[NSFileManager defaultManager] fileExistsAtPath:url.path];
    FMDatabaseQueue *databaseQueue = [FMDatabaseQueue databaseQueueWithPath:url.path];

    if (!databaseExists) {
        NSString *schemaPath = [[NSBundle mainBundle] pathForResource:@"schema" ofType:@"sql" inDirectory:@"sql"];
        if (schemaPath == nil) { return nil; }
        NSString *schema = [NSString loadStatementsAtPath:schemaPath];
        if (schema == nil) { return nil; }

        [databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
            [db executeStatements:schema];
        }];
#if DEBUG
        [self prepareTestDatabase: databaseQueue];
#endif
    }

    return databaseQueue;
}

- (void)dealloc {
    [self.databaseQueue close];
}

@end
