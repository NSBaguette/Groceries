//
//  NBGDatabaseEngine.h
//  Groceries
//
//  Created by Illia Akhaiev on 6/11/19.
//  Copyright © 2019 Illia Akhaiev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseEngine.h"

NS_ASSUME_NONNULL_BEGIN

@interface NBGDatabaseEngine: NSObject<DatabaseEngine>
- (instancetype)initWithUrl:(NSURL *)url;
@end

NS_ASSUME_NONNULL_END
