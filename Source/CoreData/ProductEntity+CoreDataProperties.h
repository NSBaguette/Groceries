//
//  ProductEntity+CoreDataProperties.h
//  Groceries
//
//  Created by Illia Akhaiev on 7/3/19.
//  Copyright © 2019 Illia Akhaiev. All rights reserved.
//
//

#import "ProductEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProductEntity (CoreDataProperties)

+ (NSFetchRequest<ProductEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *lastUsed;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSUUID *uid;
@property (nullable, nonatomic, retain) AisleEntity *aisle;
@property (nullable, nonatomic, retain) NSSet<EnqueuedProductEntity *> *enqueuedProducts;
@property (nullable, nonatomic, retain) UnitEntity *unit;

@end

@interface ProductEntity (CoreDataGeneratedAccessors)

- (void)addEnqueuedProductsObject:(EnqueuedProductEntity *)value;
- (void)removeEnqueuedProductsObject:(EnqueuedProductEntity *)value;
- (void)addEnqueuedProducts:(NSSet<EnqueuedProductEntity *> *)values;
- (void)removeEnqueuedProducts:(NSSet<EnqueuedProductEntity *> *)values;

@end

NS_ASSUME_NONNULL_END
