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
#import "ObjectiveRecord.h"
#import "User.h"
#import "DetailTagihan.h"

@interface ViewController (){
    NSUInteger UserCount;
     NSArray *sortedNotifikasi;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btn_add;
@property (weak, nonatomic) IBOutlet UITableView *tbl_data_user;

@end

@implementation ViewController
@synthesize btn_add,tbl_data_user;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tbl_data_user.estimatedRowHeight = 75.0 ;
    self.tbl_data_user.rowHeight = UITableViewAutomaticDimension;
    sortedNotifikasi= [User all];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [CoreDataManager sharedManager].modelName = @"SaveUser";
    [CoreDataManager sharedManager].databaseName = @"SaveUser";
    [[CoreDataManager sharedManager] useInMemoryStore];
     UserCount = [User count];
    NSArray *people = [User all];
    NSLog(@"data user save = %@",people);
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTable:)
                                                 name:@"sendUser"
                                               object:nil];
    
}

- (void) reloadTable:(NSNotification *) notification
{
    [CoreDataManager sharedManager].modelName = @"SaveUser";
    UserCount = [User count];
     sortedNotifikasi= [User all];
    [self.tbl_data_user reloadData];
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
       
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
    [popin setPopinTransitionStyle:BKTPopinTransitionStyleSpringySlide];
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
     CGRect presentationRect = CGRectOffset(CGRectInset(self.view.bounds, 0.0, 100.0), 0.0, 30.0);
   
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
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    UIView *headerView;
    if (section == ([tableView numberOfSections] - 1)) {
        // pageLoad +=10;
        NSLog(@"ini footer masuk reload data");
        //  [self SinkronDataNotifikasi: pageLoad];
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 70)];
    
        [headerView setBackgroundColor:[UIColor clearColor]];
        
        return 0;
    }
    else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 75.0f;
}
#pragma mark - UITableViewDataSource
// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    NSLog(@"ini data user = %d",UserCount);
    return UserCount;
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
     User *object = sortedNotifikasi[indexPath.section];
    
    // Similar to UITableViewCell, but
    cell_user *cell = (cell_user *)[theTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"cell_user" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    [cell.layer setShadowOffset:CGSizeMake(5, 5)];
    [cell.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [cell.layer setShadowOpacity:0.5];
    
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
    User *object = sortedNotifikasi[indexPath.section];
    NSString* input1 = [NSString stringWithFormat:@"%@",object.input1] ;
    NSString* input2 = [NSString stringWithFormat:@"%@",object.input2];
    NSLog(@"selected %d row", indexPath.row);
    
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
