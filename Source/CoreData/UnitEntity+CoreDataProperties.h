//
//  UnitEntity+CoreDataProperties.h
//  Groceries
//
//  Created by Illia Akhaiev on 7/3/19.
//  Copyright © 2019 Illia Akhaiev. All rights reserved.
//
//

#import "UnitEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UnitEntity (CoreDataProperties)

+ (NSFetchRequest<UnitEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *uid;
@property (nullable, nonatomic, retain) NSSet<ProductEntity *> *products;

@end

@interface UnitEntity (CoreDataGeneratedAccessors)

- (void)addProductsObject:(ProductEntity *)value;
- (void)removeProductsObject:(ProductEntity *)value;
- (void)addProducts:(NSSet<ProductEntity *> *)values;
- (void)removeProducts:(NSSet<ProductEntity *> *)values;

@end

NS_ASSUME_NONNULL_END
