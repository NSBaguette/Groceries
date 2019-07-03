//
//  ListEntity+CoreDataProperties.m
//  Groceries
//
//  Created by Illia Akhaiev on 7/3/19.
//  Copyright © 2019 Illia Akhaiev. All rights reserved.
//
//

#import "ListEntity+CoreDataProperties.h"

@implementation ListEntity (CoreDataProperties)

+ (NSFetchRequest<ListEntity *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"ListEntity"];
}

@dynamic index;
@dynamic title;
@dynamic uid;
@dynamic products;

@end
