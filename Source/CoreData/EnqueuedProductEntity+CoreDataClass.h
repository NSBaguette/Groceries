//
//  EnqueuedProductEntity+CoreDataClass.h
//  Groceries
//
//  Created by Illia Akhaiev on 7/3/19.
//  Copyright © 2019 Illia Akhaiev. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ListEntity, ProductEntity;

NS_ASSUME_NONNULL_BEGIN

@interface EnqueuedProductEntity : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "EnqueuedProductEntity+CoreDataProperties.h"
