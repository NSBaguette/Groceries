//
//  AisleEntity+CoreDataProperties.h
//  Groceries
//
//  Created by Illia Akhaiev on 7/3/19.
//  Copyright © 2019 Illia Akhaiev. All rights reserved.
//
//

#import "AisleEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface AisleEntity (CoreDataProperties)

+ (NSFetchRequest<AisleEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSUUID *uid;
@property (nullable, nonatomic, retain) NSSet<ProductEntity *> *products;

@end

@interface AisleEntity (CoreDataGeneratedAccessors)

- (void)addProductsObject:(ProductEntity *)value;
- (void)removeProductsObject:(ProductEntity *)value;
- (void)addProducts:(NSSet<ProductEntity *> *)values;
- (void)removeProducts:(NSSet<ProductEntity *> *)values;

@end

NS_ASSUME_NONNULL_END
