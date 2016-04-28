//
//  AppDelegate.h
//  PDAMObj
//
//  Created by reisa prasaptaraya on 4/25/16.
//  Copyright © 2016 reisa prasaptaraya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQKeyboardManager.h"
#import "SingleLineTextField.h"

@class JASidePanelController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (strong, nonatomic) JASidePanelController *viewController;


@end

