//
//  NBGLibrarian.h
//  Groceries
//
//  Created by Illia Akhaiev on 6/11/19.
//  Copyright © 2019 Illia Akhaiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NBGLibrarian : NSObject
+ (NSURL *)databaseUrl;

#ifdef DEBUG
+ (NSURL *)testSqlDirectory;
#endif
@end
