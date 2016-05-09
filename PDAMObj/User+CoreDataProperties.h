//
//  User+CoreDataProperties.h
//  PDAMObj
//
//  Created by reisa prasaptaraya on 4/26/16.
//  Copyright © 2016 reisa prasaptaraya. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *id_user;
@property (nullable, nonatomic, retain) NSString *judul;
@property (nullable, nonatomic, retain) NSString *input1;
@property (nullable, nonatomic, retain) NSString *input2;
@property (nullable, nonatomic, retain) NSDate *notifikasi;

@end

NS_ASSUME_NONNULL_END
