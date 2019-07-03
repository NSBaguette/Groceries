//
//  ProductEntity+CoreDataProperties.m
//  Groceries
//
//  Created by Illia Akhaiev on 7/3/19.
//  Copyright © 2019 Illia Akhaiev. All rights reserved.
//
//

#import "ProductEntity+CoreDataProperties.h"

@implementation ProductEntity (CoreDataProperties)

+ (NSFetchRequest<ProductEntity *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"ProductEntity"];
}

@dynamic lastUsed;
@dynamic title;
@dynamic uid;
@dynamic aisle;
@dynamic enqueuedProducts;
@dynamic unit;

@end
