//
//  UserData.h
//  PDAMObj
//
//  Created by reisa prasaptaraya on 4/27/16.
//  Copyright © 2016 reisa prasaptaraya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>



@interface UserData : NSManagedObject

@property (nullable, nonatomic, retain) NSString *judul;
@property (nullable, nonatomic, retain) NSString *input1;
@property (nullable, nonatomic, retain) NSString *input2;
@property (nullable, nonatomic, retain) NSNumber *timestamp;

@end


