//
//  DatabaseEngine.h
//  Groceries
//
//  Created by Illia Akhaiev on 6/11/19.
//  Copyright © 2019 Illia Akhaiev. All rights reserved.
//

#ifndef DatabaseEngine_h
#define DatabaseEngine_h

#import <Foundation/Foundation.h>
@class FMDatabase;

NS_ASSUME_NONNULL_BEGIN

@protocol DatabaseEngine <NSObject>
- (void)executeFetchBlock:(void (^)(FMDatabase *database))fetchBlock;
- (void)executeUpdateBlock:(void (^)(FMDatabase *database))updateBlock;
@end

NS_ASSUME_NONNULL_END


#endif /* DatabaseEngine_h */
