//
//  TentangPengembang.m
//  PDAMObj
//
//  Created by reisa prasaptaraya on 4/28/16.
//  Copyright © 2016 reisa prasaptaraya. All rights reserved.
//

#import "TentangPengembang.h"
#import "UIViewController+JASidePanel.h"
#import "JASidePanelController.h"

@interface TentangPengembang ()

@end

@implementation TentangPengembang

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    imgView.image = [UIImage imageNamed:@"light-bulb.png"];
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    
    self.navigationItem.titleView = imgView;
    
    self.navigationController.navigationBar.topItem.title = @"Tagihan";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:137.0/255.0 green:47.0/255.0 blue:64.0/255.0 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
    UIImage* image3 = [UIImage imageNamed:@"circle-menu.png"];
    CGRect frameimg = CGRectMake(0, 0, 32, 32);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.leftBarButtonItem=mailbutton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)openMenu {
    [self.sidePanelController showLeftPanelAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
