//
//  UnitEntity+CoreDataProperties.m
//  Groceries
//
//  Created by Illia Akhaiev on 7/3/19.
//  Copyright © 2019 Illia Akhaiev. All rights reserved.
//
//

#import "UnitEntity+CoreDataProperties.h"

@implementation UnitEntity (CoreDataProperties)

+ (NSFetchRequest<UnitEntity *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"UnitEntity"];
}

@dynamic title;
@dynamic uid;
@dynamic products;

@end
