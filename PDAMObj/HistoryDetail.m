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
#import <MagicalRecord/MagicalRecord.h>
#import "TNRadioButtonGroup.h"
#import "DLRadioButton.h"
#import "AFNetworking.h"
#import "PLN.h"
#import "SVProgressHUD.h"
#import "Historypln.h"
#import <KVNProgress/KVNProgress.h>

@interface HistoryDetail (){
    NSString *no_meter,*pelanggan_id;
    NSNumber *UserCount;
    NSArray *sortedNotifikasi;
    int timestamp;
    int urutanNum;
    int i,count;
   
}

@property (weak, nonatomic) IBOutlet UITableView *tbl_history;
@property (weak, nonatomic) IBOutlet UILabel *txt_nometer;
@property (weak, nonatomic) IBOutlet UILabel *judul_meter;

@end

@implementation HistoryDetail
@synthesize tbl_history,txt_nometer;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    //self.navigationItem.title = @"Back";
    UIImage* image3a = [UIImage imageNamed:@"reload.png"];
    CGRect frameimga = CGRectMake(0, 0, 32, 32);
    UIButton *someButtona = [[UIButton alloc] initWithFrame:frameimga];
    [someButtona setBackgroundImage:image3a forState:UIControlStateNormal];
    [someButtona addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventTouchUpInside];
    [someButtona setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *mailbuttona =[[UIBarButtonItem alloc] initWithCustomView:someButtona];
    self.navigationItem.rightBarButtonItem=mailbuttona;
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

-(void)refreshData{
     [KVNProgress show];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // time-consuming task
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        manager.requestSerializer = requestSerializer;
        NSDictionary *params;
       
            
            params = @{@"nomormeter": no_meter
                       };
       
        
        
        
        [manager GET:@"http://103.28.22.227:5277/v1/prepaid"
          parameters:params
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 // NSString* encodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                 
                 NSLog(@"responseObject = %@", responseObject);
                 
                 NSDictionary *responseDictUSer = responseObject;
                 // NSMutableArray* values =[[NSMutableArray alloc]init];
                 //values = [responseDictUSer objectForKey:@"rows"];
                 NSDictionary* valuesHistory = [responseDictUSer objectForKey:@"HistoryPrepaid"];
                 NSDictionary* values = [valuesHistory objectForKey:@"DataPelanggan"];
                 NSArray* valuesTransaksi = [valuesHistory objectForKey:@"TransaksiPrepaid"];
                 
                 NSLog(@"values data pelanggan= %@",values);
                 NSArray* cekNotif= [PLN MR_findByAttribute:@"nomorkwh" withValue:values[@"Nomorkwh"] andOrderBy:@"nomorkwh" ascending:NO];
                 
                 if(values != NULL && ![values[@"Nomorkwh"] isEqualToString:@""] && [cekNotif count] == 1){
                   
                     
                     NSArray* dataHistory= [Historypln MR_findByAttribute:@"nomorkwh" withValue:no_meter andOrderBy:@"nomorkwh" ascending:NO];
                     int x = 0;
                     int countDA = [dataHistory count];
                     while (x < countDA){
                     Historypln *dataToDelete = dataHistory[x];
                     
                     [dataToDelete MR_deleteEntity];
                    
                     
                     [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                         x++;
                     }

                     i =0;
                     //if(valuesTransaksi != NULL && valuesTransaksi != Nil){
                     count = [valuesTransaksi count];
                     //}
                     
                     
                     
                     
                     
                     //akomodir carii default
                     
                     if(count != 0){
                         while (i < count){
                             
                             Historypln *isi = [Historypln MR_createEntity];
                             NSMutableDictionary* dataName = [valuesTransaksi objectAtIndex:i];
                             NSString* Daya = [dataName  objectForKey:@"Daya"];
                             NSString* Jambayar = [dataName  objectForKey:@"Jambayar"];
                             NSString* Jenis_transaksi = [dataName  objectForKey:@"Jenis_transaksi"];
                             NSString* Namabank = [dataName  objectForKey:@"Namabank"];
                             NSString* Nomorkwh = [dataName  objectForKey:@"Nomorkwh"];
                             NSString* Pemkwh = [dataName  objectForKey:@"Pemkwh"];
                             NSString* Rptoken = [dataName  objectForKey:@"Rptoken"];
                             NSString* Tglbayar = [dataName  objectForKey:@"Tglbayar"];
                             NSString* Tgltransaksi = [dataName  objectForKey:@"Tgltransaksi"];
                             NSString* Token = [dataName  objectForKey:@"Token"];
                             
                             isi.daya=Daya;
                             isi.jambayar=Jambayar;
                             isi.jenistransaksi=Jenis_transaksi;
                             isi.namabank=Namabank;
                             isi.nomorkwh=Nomorkwh;
                             isi.pemkwh=Pemkwh;
                             isi.rptoken=Rptoken;
                             isi.tglbayar=Tglbayar;
                             isi.tgltransaksi=Tgltransaksi;
                             isi.token=Token;
                             isi.timestamp = [NSNumber numberWithInteger:timestamp];
                             [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                             
                             
                             NSLog(@"ini no token saya = %@",Token);
                             
                             
                             i++;
                         }
                     }
                     [KVNProgress showSuccess];
                     id varTIme = [NSNumber numberWithInteger: timestamp];
                     sortedNotifikasi= [Historypln MR_findByAttribute:@"timestamp" withValue:varTIme andOrderBy:@"timestamp" ascending:NO];
                     [tbl_history reloadData];
                     
                 }
                 else{
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                                     message:@"Maaf No Meter/ ID Pelanggan yang Anda masukan sudah ada atau tidak valid !"
                                                                    delegate:nil
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil];
                     [alert show];
                     
                     [KVNProgress showError];
                 }
                 
                 
                 
                 
                               
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"Error: %@", error);
                 [KVNProgress showError];
             }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
//            id varTIme = [NSNumber numberWithInteger: timestamp];
//            sortedNotifikasi= [Historypln MR_findByAttribute:@"timestamp" withValue:varTIme andOrderBy:@"timestamp" ascending:NO];
//             [tbl_history reloadData];
        });
    });

}

-(void)getTIme :(int)sectionNum : (int)time : (NSString *)Nometer : (NSString*)idPelanggan{
    NSLog(@"ini text = %@",Nometer);
    timestamp = time;
    urutanNum = sectionNum;
    no_meter = Nometer;
    pelanggan_id = idPelanggan;
    self.txt_nometer.text= @"aasasasa";
    
    //txt_nometer.text = [NSString stringWithFormat:@"%@ / %@",Nometer,idPelanggan];
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
    cell.tgl_bayar.text = [NSString stringWithFormat:@"%@ %@",object.tglbayar,object.jambayar];
    
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
