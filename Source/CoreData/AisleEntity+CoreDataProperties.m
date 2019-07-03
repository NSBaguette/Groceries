//
//  AisleEntity+CoreDataProperties.m
//  Groceries
//
//  Created by Illia Akhaiev on 7/3/19.
//  Copyright © 2019 Illia Akhaiev. All rights reserved.
//
//

#import "AisleEntity+CoreDataProperties.h"

@implementation AisleEntity (CoreDataProperties)

+ (NSFetchRequest<AisleEntity *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"AisleEntity"];
}

@dynamic title;
@dynamic uid;
@dynamic products;

@end
