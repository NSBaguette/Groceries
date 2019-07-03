//
//  EnqueuedProductEntity+CoreDataProperties.m
//  Groceries
//
//  Created by Illia Akhaiev on 7/3/19.
//  Copyright © 2019 Illia Akhaiev. All rights reserved.
//
//

#import "EnqueuedProductEntity+CoreDataProperties.h"

@implementation EnqueuedProductEntity (CoreDataProperties)

+ (NSFetchRequest<EnqueuedProductEntity *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"EnqueuedProductEntity"];
}

@dynamic amount;
@dynamic note;
@dynamic uid;
@dynamic list;
@dynamic product;

@end
