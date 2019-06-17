//
//  ProductsFetcher.h
//  Groceries
//
//  Created by Illia Akhaiev on 6/17/19.
//  Copyright © 2019 Illia Akhaiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Database/DatabaseEngine.h"

@class NBGProduct;

NS_ASSUME_NONNULL_BEGIN

@interface ProductsFetcher : NSObject
- (instancetype)initWithDatabase:(id<DatabaseEngine>)database;
- (void)fetchProducts:(void(^)(NSArray<NBGProduct *> *result))completion;
@end

NS_ASSUME_NONNULL_END
