//
//  ViewController.m
//  PDAMObj
//
//  Created by reisa prasaptaraya on 4/25/16.
//  Copyright © 2016 reisa prasaptaraya. All rights reserved.
//

#import "ViewController.h"
#import "KLCPopup.h"
#import "addDataUser.h"
#import "UIViewController+MaryPopin.h"
#import <QuartzCore/QuartzCore.h>
#import "cell_user.h"
//#import "ObjectiveRecord.h"
#import "UserData.h"
#import <MagicalRecord/MagicalRecord.h>
#import "DetailTagihan.h"
#import "WelcomeScreen.h"
#import "UIViewController+JASidePanel.h"
#import "JASidePanelController.h"

@interface ViewController (){
    NSNumber *UserCount;
     NSArray *sortedNotifikasi;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btn_add;
@property (weak, nonatomic) IBOutlet UITableView *tbl_data_user;

@end

@implementation ViewController
@synthesize btn_add,tbl_data_user;


- (void)viewDidLoad {
    [super viewDidLoad];
//    UIBarButtonItem *_btn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"1461752752_circle-add"]
//                                                          style:UIBarButtonItemStylePlain
//                                                         target:self
//                                                         action:@selector(act_add_tagihan:)];
//    _btn.accessibilityFrame = CGRectMake(100, 100, 30, 30);
//    self.navigationItem.rightBarButtonItem=_btn;
    
    UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
    imgView.image = [UIImage imageNamed:@"1461749591_water.png"];
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    
    self.navigationItem.titleView = imgView;
    
    self.navigationController.navigationBar.topItem.title = @"Tagihan";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:119.0/255.0 green:179.0/255.0 blue:212.0/255.0 alpha:1];
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
    
    
    UIImage* image3a = [UIImage imageNamed:@"user1.png"];
    CGRect frameimga = CGRectMake(0, 0, 32, 32);
    UIButton *someButtona = [[UIButton alloc] initWithFrame:frameimga];
    [someButtona setBackgroundImage:image3a forState:UIControlStateNormal];
    [someButtona addTarget:self action:@selector(act_add_tagihan:) forControlEvents:UIControlEventTouchUpInside];
    [someButtona setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *mailbuttona =[[UIBarButtonItem alloc] initWithCustomView:someButtona];
    self.navigationItem.rightBarButtonItem=mailbuttona;
    
    self.tbl_data_user.emptyDataSetSource = self;
    self.tbl_data_user.emptyDataSetDelegate = self;
    
    // A little trick for removing the cell separators
    self.tbl_data_user.tableFooterView = [UIView new];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.tbl_data_user.estimatedRowHeight = 75.0 ;
    self.tbl_data_user.rowHeight = UITableViewAutomaticDimension;
    //sortedNotifikasi= [UserData MR_findAllSortedBy:@"timestamp" ascending:YES];
    UserCount = [UserData MR_numberOfEntities];
    sortedNotifikasi= [UserData MR_findAllSortedBy:@"timestamp" ascending:YES];
    [self.tbl_data_user reloadData];
    
   
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"welcomescreen"];
    
    if(savedValue ==NULL){
    [self WelcomeScreen];
        NSString *valueToSave = @"1";
        [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"welcomescreen"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else{
        
    }
}

-(void)openMenu {
    [self.sidePanelController showLeftPanelAnimated:YES];
}

//php -S 192.168.2.12:8080 -t public public/index.php

-(void)WelcomeScreen {
    WelcomeScreen *popin = [[WelcomeScreen alloc] initWithNibName:@"WelcomeScreen" bundle:nil];
    
    
    //UIViewController *popin = [[UIStoryboard storyboardWithName:@"InterestStoryBoard" bundle:nil] instantiateViewControllerWithIdentifier:@"PitchCommunity"];
    popin.view.bounds = CGRectMake(0, 0, 280, 274);
    [popin setPopinTransitionStyle:BKTPopinTransitionStyleSnap];
    //[popin setPopinOptions:BKTPopinDisableAutoDismiss];
    
    popin.view.layer.cornerRadius = 5.0;
    popin.view.layer.masksToBounds = YES;
    BKTBlurParameters *blurParameters = [[BKTBlurParameters alloc] init];
    //blurParameters.alpha = 0.5;
    blurParameters.tintColor = [UIColor colorWithWhite:0 alpha:0.2];
    blurParameters.radius = 0.3;
    [popin setBlurParameters:blurParameters];
    [popin setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
    //popin.presentingController = self;
   // CGRect presentationRect = CGRectOffset(CGRectInset(self.view.bounds, 0.0, 100.0), 0.0, 30.0);
    
    //Present popin on the desired controller
    //Note that if you are using a UINavigationController, the navigation bar will be active if you present
    // the popin on the visible controller instead of presenting it on the navigation controller
    [self presentPopinController:popin animated:YES completion:^{
        NSLog(@"Popin presented !");
    }];

}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"1461749591_water.png"];
}
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
    
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
    
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"No Content\nTaps + button to add new item";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:12.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBar.topItem.title = @"Tagihan";
//    [CoreDataManager sharedManager].modelName = @"SaveUser";
//    [CoreDataManager sharedManager].databaseName = @"SaveUser";
//    [[CoreDataManager sharedManager] useInMemoryStore];
     UserCount = [UserData MR_numberOfEntities];
    NSArray *people = [UserData MR_findAllSortedBy:@"timestamp" ascending:YES];
    NSLog(@"data user save = %@",people);
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTable:)
                                                 name:@"sendUser"
                                               object:nil];
    
}

- (void) reloadTable:(NSNotification *) notification
{
   // [CoreDataManager sharedManager].modelName = @"SaveUser";
   UserCount = [UserData MR_numberOfEntities];
     sortedNotifikasi= [UserData MR_findAllSortedBy:@"timestamp" ascending:YES];
    [self.tbl_data_user reloadData];
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        UserData *object = sortedNotifikasi[indexPath.section];
        NSString* input1 = [NSString stringWithFormat:@"%@",object.input1] ;
        NSLog(@"ini input 1 yang mau didelete = %@",input1);
        [object MR_deleteEntity];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        [self reloadTable:nil];
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
- (IBAction)act_add_tagihan:(id)sender {
//    NSString * storyboardName = @"DetailData";
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
//    ShareContent * popin = [storyboard instantiateViewControllerWithIdentifier:@"ShareContent"];
//    
//    [popin dataShare:@"4" :content:id_news:data_id:@"news/share"];
    
    addDataUser *popin = [[addDataUser alloc] initWithNibName:@"addDataUser" bundle:nil];
    
    
    //UIViewController *popin = [[UIStoryboard storyboardWithName:@"InterestStoryBoard" bundle:nil] instantiateViewControllerWithIdentifier:@"PitchCommunity"];
    //popin.view.bounds = CGRectMake(0, 0, 245, 250);
    [popin setPopinTransitionStyle:BKTPopinTransitionStyleSnap];
    //[popin setPopinOptions:BKTPopinDisableAutoDismiss];
    
    popin.view.layer.cornerRadius = 5.0;
    popin.view.layer.masksToBounds = YES;
    BKTBlurParameters *blurParameters = [[BKTBlurParameters alloc] init];
    //blurParameters.alpha = 0.5;
    blurParameters.tintColor = [UIColor colorWithWhite:0 alpha:0.5];
    blurParameters.radius = 0.3;
    [popin setBlurParameters:blurParameters];
    [popin setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
    //popin.presentingController = self;
    // CGRect presentationRect = CGRectOffset(popin.view.frame, 10.0, 10.0);
    CGRect presentationRect = CGRectMake(self.view.bounds.size.width/2 - 135, 70, popin.view.bounds.size.width + 20, popin.view.bounds.size.height + 20);
//    popin.view.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
//    CGRect presentationRect = CGRectMake(popin.view.center.x - 80, popin.view.center.y - 80, 250, 317);
    
   
    //Present popin on the desired controller
    //Note that if you are using a UINavigationController, the navigation bar will be active if you present
    // the popin on the visible controller instead of presenting it on the navigation controller
    [self.navigationController presentPopinController:popin fromRect:presentationRect animated:YES completion:^{
        NSLog(@"Popin presented !");
    }];
    
//    [self presentPopinController:popin animated:YES completion:^{
//        
//        NSLog(@"Popin presented !");
//    }];
 
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return UITableViewAutomaticDimension;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   
     if (section == 0) {
         
         return 10.0;
     }
     else{
    return 0;
     }
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView;
    if (section == 0){
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 70)];
        [headerView setBackgroundColor:[UIColor whiteColor]];
    return headerView;
    }
    else {
        [headerView setBackgroundColor:[UIColor clearColor]];
    return headerView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    UIView *headerView;
    if (section == ([tableView numberOfSections] - 1)) {
        // pageLoad +=10;
        NSLog(@"ini footer masuk reload data");
        //  [self SinkronDataNotifikasi: pageLoad];
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 70)];
    
        [headerView setBackgroundColor:[UIColor whiteColor]];
        
        return 0;
    }
    else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 77.0f;
}
#pragma mark - UITableViewDataSource
// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    NSLog(@"ini data user = %@",UserCount);
    NSInteger value = [UserCount integerValue];
    return value;
}

// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell_user";
     UserData *object = sortedNotifikasi[indexPath.section];
    
    // Similar to UITableViewCell, but
    cell_user *cell = (cell_user *)[theTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"cell_user" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
//    [cell.layer setShadowOffset:CGSizeMake(5, 5)];
//    [cell.layer setShadowColor:[[UIColor blackColor] CGColor]];
//    [cell.layer setShadowOpacity:0.5];
    
    // Just want to test, so I hardcode the data
    cell.txt_judul.text = [NSString stringWithFormat:@"%@",object.judul];
    cell.txt_pelanggan.text = [NSString stringWithFormat:@"%@ - %@",object.input1, object.input2];
    
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserData *object = sortedNotifikasi[indexPath.section];
    NSString* input1 = [NSString stringWithFormat:@"%@",object.input1] ;
    NSString* input2 = [NSString stringWithFormat:@"%@",object.input2];
    NSLog(@"selected %ld row", (long)indexPath.row);
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    DetailTagihan * vc = [storyboard instantiateViewControllerWithIdentifier:@"DetailTagihan"];
    [vc getDataUserTagihan:input1 :input2 ];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
