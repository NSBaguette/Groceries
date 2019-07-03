//
//  EnqueuedProductEntity+CoreDataProperties.h
//  Groceries
//
//  Created by Illia Akhaiev on 7/3/19.
//  Copyright © 2019 Illia Akhaiev. All rights reserved.
//
//

#import "EnqueuedProductEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface EnqueuedProductEntity (CoreDataProperties)

+ (NSFetchRequest<EnqueuedProductEntity *> *)fetchRequest;

@property (nonatomic) double amount;
@property (nullable, nonatomic, copy) NSString *note;
@property (nullable, nonatomic, copy) NSUUID *uid;
@property (nullable, nonatomic, retain) ListEntity *list;
@property (nullable, nonatomic, retain) ProductEntity *product;

@end

NS_ASSUME_NONNULL_END
