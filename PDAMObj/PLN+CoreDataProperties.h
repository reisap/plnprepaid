//
//  PLN+CoreDataProperties.h
//  PDAMObj
//
//  Created by reisa prasaptaraya on 5/9/16.
//  Copyright © 2016 reisa prasaptaraya. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PLN.h"

NS_ASSUME_NONNULL_BEGIN

@interface PLN (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *nama;
@property (nullable, nonatomic, retain) NSString *judul;
@property (nullable, nonatomic, retain) NSNumber *timestamp;
@property (nullable, nonatomic, retain) NSString *daya;
@property (nullable, nonatomic, retain) NSString *nomorkwh;
@property (nullable, nonatomic, retain) NSString *alamat;
@property (nullable, nonatomic, retain) NSString *tarif;
@property (nullable, nonatomic, retain) NSString *idpelanggan;

@end

NS_ASSUME_NONNULL_END
