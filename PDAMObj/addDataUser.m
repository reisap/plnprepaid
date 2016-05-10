//
//  addDataUser.m
//  PDAMObj
//
//  Created by reisa prasaptaraya on 4/25/16.
//  Copyright © 2016 reisa prasaptaraya. All rights reserved.
//

#import "addDataUser.h"
#import "ObjectiveRecord.h"
#import "UserData.h"
#import "SingleLineTextField.h"
#import <sqlite3.h>
#import <CoreData/CoreData.h>
#import "UIViewController+MaryPopin.h"
#import <MagicalRecord/MagicalRecord.h>
#import "TNRadioButtonGroup.h"
#import "DLRadioButton.h"
#import "AFNetworking.h"
#import "PLN.h"
#import "SVProgressHUD.h"
#import "Historypln.h"
#import <KVNProgress/KVNProgress.h>




@interface addDataUser (){
    NSString* setDateNotifikasi;
    int checkPilihan;
    int count;
    int i;
}
@property (weak, nonatomic) IBOutlet UIButton *btn_submit;
@property (weak, nonatomic) IBOutlet SingleLineTextField *txt_judul;
@property (weak, nonatomic) IBOutlet SingleLineTextField *txt_input1;
@property (weak, nonatomic) IBOutlet SingleLineTextField *txt_input2;
@property (weak, nonatomic) IBOutlet SingleLineTextField *txt_tgl;
@property (weak, nonatomic) IBOutlet UIButton *btn_calendar;
@property (weak, nonatomic) IBOutlet UILabel *txt_tgl_notif;
@property (nonatomic, strong) THDatePickerViewController * datePicker;
@property (nonatomic, retain) NSDate * curDate;
@property (nonatomic, retain) NSDateFormatter * formatter;
@property (weak, nonatomic) IBOutlet DLRadioButton *btn_nometer;
@property (weak, nonatomic) IBOutlet DLRadioButton *btn_idpelanggan;

@end

@implementation addDataUser

- (void)viewDidLoad {
    checkPilihan = -1;
    [super viewDidLoad];
    self.curDate = [NSDate date];
    self.formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"dd/MM/yyyy"];
    [CoreDataManager sharedManager].modelName = @"SaveUser";
    [CoreDataManager sharedManager].databaseName = @"SaveUser";
    [[CoreDataManager sharedManager] useInMemoryStore];
    
    _btn_submit.layer.cornerRadius = 5.0;
    _btn_submit.layer.masksToBounds = YES;
    // Do any additional setup after loading the view from its nib.
    _txt_tgl_notif.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(act_notif:)];
    [_txt_tgl_notif addGestureRecognizer:tapGesture];
}
- (IBAction)act_notif:(id)sender {
    if(!self.datePicker)
        self.datePicker = [THDatePickerViewController datePicker];
    self.datePicker.date = self.curDate;
    self.datePicker.delegate = self;
    [self.datePicker setAllowClearDate:NO];
    [self.datePicker setClearAsToday:YES];
    [self.datePicker setAutoCloseOnSelectDate:NO];
    [self.datePicker setAllowSelectionOfSelectedDate:YES];
    [self.datePicker setDisableYearSwitch:YES];
    //[self.datePicker setDisableFutureSelection:NO];
    [self.datePicker setDaysInHistorySelection:1];
    [self.datePicker setDaysInFutureSelection:0];
    //    [self.datePicker setAllowMultiDaySelection:YES];
    //    [self.datePicker setDateTimeZoneWithName:@"UTC"];
    //[self.datePicker setAutoCloseCancelDelay:5.0];
    [self.datePicker setSelectedBackgroundColor:[UIColor colorWithRed:125/255.0 green:208/255.0 blue:0/255.0 alpha:1.0]];
    [self.datePicker setCurrentDateColor:[UIColor colorWithRed:242/255.0 green:121/255.0 blue:53/255.0 alpha:1.0]];
    [self.datePicker setCurrentDateColorSelected:[UIColor yellowColor]];
    
    [self.datePicker setDateHasItemsCallback:^BOOL(NSDate *date) {
        int tmp = (arc4random() % 30)+1;
        return (tmp % 5 == 0);
    }];
    //[self.datePicker slideUpInView:self.view withModalColor:[UIColor lightGrayColor]];
    [self presentSemiViewController:self.datePicker withOptions:@{
                                                                  KNSemiModalOptionKeys.pushParentBack    : @(NO),
                                                                  KNSemiModalOptionKeys.animationDuration : @(1.0),
                                                                  KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
                                                                  }];
}
#pragma mark - THDatePickerDelegate

- (void)datePickerDonePressed:(THDatePickerViewController *)datePicker {
   self.curDate = datePicker.date;
    _txt_tgl_notif.text = [NSString stringWithFormat:@"%@",[_formatter stringFromDate:datePicker.date]];
    setDateNotifikasi =  _txt_tgl_notif.text;
    [self dismissSemiModalView];
}

- (void)datePickerCancelPressed:(THDatePickerViewController *)datePicker {
    [self dismissSemiModalView];
}

- (void)datePicker:(THDatePickerViewController *)datePicker selectedDate:(NSDate *)selectedDate {
    NSLog(@"Date selected: %@",[_formatter stringFromDate:selectedDate]);
   // _txt_tgl_notif.text = [NSString stringWithFormat:@"%@",[_formatter stringFromDate:selectedDate]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pilihIDPElanggan:(DLRadioButton *)radioButton {
    NSLog(@"ini sendernya = %@",radioButton.selectedButton.titleLabel.text);
    if ([radioButton.selectedButton.titleLabel.text isEqualToString:@"No Meter"]) {
        checkPilihan = 0;
    } else {
        checkPilihan = 1;
    }
    
}
- (IBAction)act_submit:(id)sender {
    if(![[_txt_input1 text] isEqualToString:@""] && ![[_txt_judul text] isEqualToString:@""] && checkPilihan != -1){
        
        [KVNProgress show];

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // time-consuming task
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
            
            [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            manager.requestSerializer = requestSerializer;
            NSDictionary *params;
            if(checkPilihan == 0){
               
                    params = @{@"nomormeter": _txt_input1.text
                              };
            }
            else{
                params = @{@"idpel": _txt_input1.text
                           };

            }
            

            
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
                      
                      if(values != NULL && ![values[@"Nomorkwh"] isEqualToString:@""]){
                      //ini data pelanggannya
                      NSString *Alamat = [NSString stringWithFormat:@"%@",values[@"Alamat"]];
                      NSString *Daya = [NSString stringWithFormat:@"%@",values[@"Daya"]];
                      NSString *Idpel = [NSString stringWithFormat:@"%@",values[@"Idpel"]];
                      NSString *Nama = [NSString stringWithFormat:@"%@",values[@"Nama"]];
                      NSString *Nomorkwhku = [NSString stringWithFormat:@"%@",values[@"Nomorkwh"]];
                      NSString *Tarif = [NSString stringWithFormat:@"%@",values[@"Tarif"]];
                      
                      
                      NSLog(@"Idpel data Idpel= %@",Idpel);
                      NSString * timestamp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
                      PLN *isi = [PLN MR_createEntity];
                      isi.alamat = Alamat;
                      isi.daya = Daya;
                      isi.idpelanggan = Idpel;
                      isi.nama = Nama;
                      isi.nomorkwh = Nomorkwhku;
                      isi.tarif = Tarif;
                      isi.judul = _txt_judul.text;
                      isi.timestamp = [NSNumber numberWithInteger:[timestamp integerValue]];
              
                      //Save to persistant storage
                      [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
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
                              isi.timestamp = [NSNumber numberWithInteger:[timestamp integerValue]];
                              [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                             
                              
                              NSLog(@"ini no token saya = %@",Token);
                             
                              
                              i++;
                          }
                      }
                           [KVNProgress showSuccess];
                          [[NSNotificationCenter defaultCenter]
                           postNotificationName:@"sendUser"
                           object:self];
                          
                      }
                      else{
                            [KVNProgress showError];
                      }
                      
                      
                      
                    
                      
                      
                      [self.navigationController dismissCurrentPopinControllerAnimated:YES];
                      
                      [self dismissCurrentPopinControllerAnimated:YES completion:^{
                          NSLog(@"Popin dismissed !");
                      }];

                  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      NSLog(@"Error: %@", error);
                                            [KVNProgress showError];
                  }];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
        });

       
        
        // Request to reload table view data
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
//        NSString * timestamp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
//        UserData *isi = [UserData MR_createEntity];
//        isi.judul = _txt_judul.text;
//        isi.input1 = _txt_input1.text;
//        isi.input2 = _txt_input2.text;
//        isi.timestamp = [NSNumber numberWithInteger:[timestamp integerValue]];
//        
//        //Save to persistant storage
//        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//        
//        
        
        
        
        
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Silahkan isi semua field yang tersedia !"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
                              [SVProgressHUD dismiss];
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
