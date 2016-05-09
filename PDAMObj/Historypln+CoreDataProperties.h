//
//  Historypln+CoreDataProperties.h
//  PDAMObj
//
//  Created by Reisa Prasaptaraya on 5/10/16.
//  Copyright © 2016 reisa prasaptaraya. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Historypln.h"

NS_ASSUME_NONNULL_BEGIN

@interface Historypln (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *daya;
@property (nullable, nonatomic, retain) NSString *jambayar;
@property (nullable, nonatomic, retain) NSString *jenistransaksi;
@property (nullable, nonatomic, retain) NSString *namabank;
@property (nullable, nonatomic, retain) NSString *pemkwh;
@property (nullable, nonatomic, retain) NSString *rptoken;
@property (nullable, nonatomic, retain) NSString *tglbayar;
@property (nullable, nonatomic, retain) NSString *tgltransaksi;
@property (nullable, nonatomic, retain) NSNumber *timestamp;
@property (nullable, nonatomic, retain) NSString *token;
@property (nullable, nonatomic, retain) NSString *nomorkwh;

@end

NS_ASSUME_NONNULL_END
