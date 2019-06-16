//
//  NBGLibrarian.m
//  Groceries
//
//  Created by Illia Akhaiev on 6/11/19.
//  Copyright © 2019 Illia Akhaiev. All rights reserved.
//

#import "NBGLibrarian.h"

@interface NBGLibrarian ()
@property (class, readonly) NSString *appSupportDirectoryName;
@property (class, readonly) NSURL *appSupportDirectoryUrl;
@property (class, readonly) NSString *databaseFileName;
@end

@implementation NBGLibrarian

+ (NSURL *)databaseUrl {
    NSError *error = nil;
    NSURL *folderUrl = self.appSupportDirectoryUrl;
    BOOL created = [[NSFileManager defaultManager] createDirectoryAtURL:folderUrl
                                            withIntermediateDirectories:YES
                                                             attributes:nil
                                                                  error:&error];
    if (!created) {
        NSLog(@"Can't create folder: %@", error);
        return nil;
    }
    return [folderUrl URLByAppendingPathComponent:self.databaseFileName isDirectory:false];
}

+ (NSURL *)appSupportDirectoryUrl {
    NSArray<NSURL *> *libraryUrls = [[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory
                                                               inDomains:NSUserDomainMask];
    return  [libraryUrls.firstObject URLByAppendingPathComponent:self.appSupportDirectoryName isDirectory:YES];
}

+ (NSString *)appSupportDirectoryName {
    return @"Application Support";
}

+ (NSString *)databaseFileName {
    return @"db.sqlite";
}

#ifdef DEBUG
+ (NSURL *)testSqlDirectory {
    NSURL *root = [NSBundle mainBundle].resourceURL;
    NSURL *dir = [root URLByAppendingPathComponent:@"sql/test" isDirectory:YES];
    return dir;
}
#endif
@end

