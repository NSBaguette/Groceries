//
//  some.m
//  Groceries
//
//  Created by Illia Akhaiev on 6/11/19.
//  Copyright © 2019 Illia Akhaiev. All rights reserved.
//

#import "NSString+NBGSQLStatements.h"

@implementation NSString (NBGSQLStatements)

+ (NSString *)loadStatementsAtPath:(NSString *)path {
    NSError *error = nil;
    NSString *schema = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (error == nil) { return schema; }

    return nil;
}

@end
