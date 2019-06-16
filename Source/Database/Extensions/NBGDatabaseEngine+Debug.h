//
//  NBGDatabaseEngine+Debug.h
//  Groceries
//
//  Created by Illia Akhaiev on 6/11/19.
//  Copyright © 2019 Illia Akhaiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NBGDatabaseEngine.h"

NS_ASSUME_NONNULL_BEGIN
#if DEBUG

@interface NBGDatabaseEngine (Debug)
- (void)prepareTestDatabase:(FMDatabaseQueue *)databaseQueue;
@end

#endif
NS_ASSUME_NONNULL_END
