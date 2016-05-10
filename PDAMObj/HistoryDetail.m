//
//  HistoryDetail.m
//  PDAMObj
//
//  Created by Reisa Prasaptaraya on 5/10/16.
//  Copyright © 2016 reisa prasaptaraya. All rights reserved.
//

#import "HistoryDetail.h"
#import "cell_history.h"
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
#import "SVProgressHUD.h"
#import "PLN.h"
#import "HistoryDetail.h"
#import "Historypln.h"
#import "cell_history.h"
#import <UIKit/UIView.h>

@interface HistoryDetail (){
    NSString *no_meter,*pelanggan_id;
    NSNumber *UserCount;
    NSArray *sortedNotifikasi;
    int timestamp;
   
}

@property (weak, nonatomic) IBOutlet UITableView *tbl_history;
@property (weak, nonatomic) IBOutlet UILabel *txt_nometer;
@property (weak, nonatomic) IBOutlet UILabel *judul_meter;

@end

@implementation HistoryDetail
@synthesize tbl_history,txt_nometer;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* gantiData = [NSString stringWithFormat:@"%@ / %@",no_meter,pelanggan_id];
    [txt_nometer setText:gantiData];
    NSLog(@"ini dia timestampnya = %d",timestamp);
    //NSPredicate *peopleFilter = [NSPredicate predicateWithFormat:@"timestamp IN %d", timestamp];
      //NSLog(@"ini dia peopleFilter = %d",peopleFilter);
   // UserCount = [Historypln MR_numberOfEntitiesWithPredicate:peopleFilter];
    id varTIme = [NSNumber numberWithInteger: timestamp];
    sortedNotifikasi= [Historypln MR_findByAttribute:@"timestamp" withValue:varTIme andOrderBy:@"timestamp" ascending:NO];
    NSLog(@"ini umlah data sortedNotifikasi = %@",sortedNotifikasi);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getTIme : (int)time : (NSString *)Nometer : (NSString*)idPelanggan{
    NSLog(@"ini text = %@",Nometer);
    timestamp = time;
    no_meter = Nometer;
    pelanggan_id = idPelanggan;
    self.txt_nometer.text= @"aasasasa";
    
    //txt_nometer.text = [NSString stringWithFormat:@"%@ / %@",Nometer,idPelanggan];
}

-(void)setnometer{
     txt_nometer.text = @"bbbbb";
     [txt_nometer setNeedsDisplay];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //return 202.0f;
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


#pragma mark - UITableViewDataSource
// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
//    NSLog(@"ini data user = %@",UserCount);
    //NSInteger value = [UserCount integerValue];
    return [sortedNotifikasi count];
}

// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell_history";
    Historypln *object = sortedNotifikasi[indexPath.section];
    
    // Similar to UITableViewCell, but
    cell_history *cell = (cell_history *)[theTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"cell_history" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    //    [cell.layer setShadowOffset:CGSizeMake(5, 5)];
    //    [cell.layer setShadowColor:[[UIColor blackColor] CGColor]];
    //    [cell.layer setShadowOpacity:0.5];
    
    // Just want to test, so I hardcode the data
    cell.isi_token.text = [NSString stringWithFormat:@"%@",object.token];
    cell.pemkwh.text = [NSString stringWithFormat:@"%@",object.pemkwh];
    cell.rupiah.text = [NSString stringWithFormat:@"%@",object.rptoken];
    cell.daya.text = [NSString stringWithFormat:@"%@",object.daya];
    cell.nama_bank.text = [NSString stringWithFormat:@"%@",object.namabank];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
