//
//  MenuKiri.m
//  PDAMObj
//
//  Created by reisa prasaptaraya on 4/28/16.
//  Copyright © 2016 reisa prasaptaraya. All rights reserved.
//

#import "MenuKiri.h"
#import "cell_menu.h"
#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"
#import "ViewController.h"
#import <Social/Social.h>
#import "TentangPengembang.h"
@interface MenuKiri (){
    NSMutableArray* NamaMenu, *gambarMenu,*id_menu;
}
@property (weak, nonatomic) IBOutlet UIImageView *img_water;
@property (weak, nonatomic) IBOutlet UIView *view_template;
@property (weak, nonatomic) IBOutlet UITableView *tbl_menu;

@end

@implementation MenuKiri

- (void)viewDidLoad {
    [super viewDidLoad];
    NamaMenu = [[NSMutableArray alloc]init];
    gambarMenu = [[NSMutableArray alloc]init];
    id_menu = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view from its nib.
    
    [id_menu addObject:@"1"];
    [id_menu addObject:@"2"];
    [id_menu addObject:@"3"];
    
    
    [NamaMenu addObject:@"Resulties"];
    [NamaMenu addObject:@"Share Aplikasi"];
    [NamaMenu addObject:@"Tentang Pengembang"];
    
    [gambarMenu addObject:@"water-drop.png"];
    [gambarMenu addObject:@"medical-app.png"];
    [gambarMenu addObject:@"brainstorm.png"];
    
    [self.view_template.layer setShadowOffset:CGSizeMake(1, 1)];
    [self.view_template.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [self.view_template.layer setShadowOpacity:0.5];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    return 64.0f;
}
//#pragma mark - UITableViewDataSource
//// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    
    return [id_menu count];
}
//
// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

//// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell_menu";
  
    
    // Similar to UITableViewCell, but
    cell_menu *cell = (cell_menu *)[theTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"cell_menu" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    //    [cell.layer setShadowOffset:CGSizeMake(5, 5)];
    //    [cell.layer setShadowColor:[[UIColor blackColor] CGColor]];
    //    [cell.layer setShadowOpacity:0.5];
    
    
    // Just want to test, so I hardcode the data
    cell.txt_menu.text = [NSString stringWithFormat:@"%@",[NamaMenu objectAtIndex:indexPath.section]];
    NSString* namaImage = [NSString stringWithFormat:@"%@",[gambarMenu objectAtIndex:indexPath.section]];
//    cell.txt_pelanggan.text = [NSString stringWithFormat:@"%@ - %@",object.input1, object.input2];
    cell.img_menu.image = [UIImage imageNamed:namaImage];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//
//#pragma mark - UITableViewDelegate
//// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//      self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[JACenterViewController alloc] init]];
    if(indexPath.section == 0){
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        ViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
          self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:vc];
    }
    else if(indexPath.section == 1){
//        NSArray *activityItems = @[@"I'm use resulties on Apple Store - Membantu dalam melihat tagihan PDAM Kota Bogor", @"PDAM TIRTA PAKUAN KOTA BOGOR"];
//        UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
//        [self presentViewController:activityViewController animated:YES completion:^{}];
        
//        NSString *textToShare = @"Look at this awesome website for aspiring iOS Developers!";
//        NSURL *myWebsite = [NSURL URLWithString:@"http://www.codingexplorer.com/"];
        
        NSArray *objectsToShare = @[@"I'm use resulties on Apple Store - Membantu dalam melihat tagihan PDAM Kota Bogor", @"PDAM TIRTA PAKUAN KOTA BOGOR"];
        
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
        
        NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                       UIActivityTypePrint,
                                       UIActivityTypeAssignToContact,
                                       UIActivityTypeSaveToCameraRoll,
                                       UIActivityTypeAddToReadingList,
                                       UIActivityTypePostToFlickr,
                                       UIActivityTypePostToVimeo,UIActivityTypePostToFacebook,UIActivityTypePostToTwitter];
        
        activityVC.excludedActivityTypes = excludeActivities;
        
        [self presentViewController:activityVC animated:YES completion:nil];
    }
    else{
        
        self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[TentangPengembang alloc] init]];
    }
    
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
