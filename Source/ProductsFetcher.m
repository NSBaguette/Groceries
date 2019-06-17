//
//  ProductsFetcher.m
//  Groceries
//
//  Created by Illia Akhaiev on 6/17/19.
//  Copyright © 2019 Illia Akhaiev. All rights reserved.
//

#import "ProductsFetcher.h"
#import "NBGProduct.h"
#import <FMDB/FMDB.h>

@interface ProductsFetcher ()
@property (weak, nonatomic) id<DatabaseEngine> database;
@end

@implementation ProductsFetcher

- (instancetype)initWithDatabase:(id<DatabaseEngine>)database {
    self = [super init];
    self.database = database;
    return self;
}

- (void)fetchProducts:(void(^)(NSArray<NBGProduct *> *result))completion {
    NSString *query = [self testProductsFetchQuery];
    [self.database executeFetchBlock:^(FMDatabase * _Nonnull database) {
        FMResultSet *result = [database executeQuery:query withArgumentsInArray:@[]];
        if (result == nil) { completion(@[]); }
        NSArray *products = [self parseProducts:result];
        completion(products);
    }];
}

- (NSArray<NBGProduct *> *)parseProducts:(FMResultSet *)fetchResult {
    NSMutableArray *products = [[NSMutableArray alloc] init];
    while ([fetchResult next]) {
        NSString *name = [fetchResult stringForColumn:@"name"];
        int uid = [fetchResult intForColumn:@"uid"];
        BOOL enqueued = [fetchResult boolForColumn:@"enqueued"];
        if (!(name && uid > 0 && enqueued)) { continue; }

        NBGProduct *product = [[NBGProduct alloc] init];
        product.name = name;
        product.uid = uid;
        product.enqueued = enqueued;
        [products addObject:product];
    }

    return [products copy];
}

- (NSString *)testProductsFetchQuery {
    return @"SELECT \
    Groceries.Name,\
    Groceries.uid,\
    1 AS Enqueued\
    FROM GroceriesLists\
    INNER JOIN Groceries\
    ON GroceriesLists.ProductID=Groceries.uid\
    WHERE GroceriesLists.ListID=1\
    ORDER BY GroceriesLists.Position";
}
@end
