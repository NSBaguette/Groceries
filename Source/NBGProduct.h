//
//  NBGProduct.h
//  Groceries
//
//  Created by Illia Akhaiev on 6/17/19.
//  Copyright © 2019 Illia Akhaiev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NBGProduct : NSObject
@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) int uid;
@property (assign, nonatomic) BOOL enqueued;

@end

NS_ASSUME_NONNULL_END
