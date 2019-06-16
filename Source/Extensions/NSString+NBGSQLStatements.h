//
//  NSString+NBGSQLStatements.h
//  Groceries
//
//  Created by Illia Akhaiev on 6/11/19.
//  Copyright © 2019 Illia Akhaiev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (NBGSQLStatements)
+ (NSString *)loadStatementsAtPath:(NSString *)path;
@end

NS_ASSUME_NONNULL_END
