//
//  User.h
//  PDAMObj
//
//  Created by reisa prasaptaraya on 4/26/16.
//  Copyright © 2016 reisa prasaptaraya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>



@interface User : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@property (nonatomic, retain) NSString *judul;
@property (nonatomic, retain) NSString *input1;
@property (nonatomic, retain) NSString *input2;


@end


