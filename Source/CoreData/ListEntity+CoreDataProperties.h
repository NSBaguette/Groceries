//
//  ListEntity+CoreDataProperties.h
//  Groceries
//
//  Created by Illia Akhaiev on 7/3/19.
//  Copyright © 2019 Illia Akhaiev. All rights reserved.
//
//

#import "ListEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ListEntity (CoreDataProperties)

+ (NSFetchRequest<ListEntity *> *)fetchRequest;

@property (nonatomic) int64_t index;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSUUID *uid;
@property (nullable, nonatomic, retain) NSSet<EnqueuedProductEntity *> *products;

@end

@interface ListEntity (CoreDataGeneratedAccessors)

- (void)addProductsObject:(EnqueuedProductEntity *)value;
- (void)removeProductsObject:(EnqueuedProductEntity *)value;
- (void)addProducts:(NSSet<EnqueuedProductEntity *> *)values;
- (void)removeProducts:(NSSet<EnqueuedProductEntity *> *)values;

@end

NS_ASSUME_NONNULL_END
