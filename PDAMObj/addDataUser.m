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




@interface addDataUser (){
    NSString* setDateNotifikasi;
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

@end

@implementation addDataUser

- (void)viewDidLoad {
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
- (IBAction)act_submit:(id)sender {
    if(![[_txt_input1 text] isEqualToString:@""] && ![[_txt_input2 text] isEqualToString:@""] && ![[_txt_judul text] isEqualToString:@""] && ![setDateNotifikasi isEqualToString:@""] && setDateNotifikasi != NULL){
        
        NSLog(@"ini judul = %@", _txt_judul.text);
//        UserData *isi = [UserData create];
//        isi.judul = _txt_judul.text;
//        isi.input1 = _txt_input1.text;
//        isi.input2 = _txt_input2.text;
//        [isi save];
        // Schedule the notification
        UILocalNotification* localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = self.curDate;
        localNotification.alertBody = _txt_judul.text;
        localNotification.alertAction = @"Bayar PDAM Tirta Pakuan";
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
        // Request to reload table view data
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
        NSString * timestamp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
        UserData *isi = [UserData MR_createEntity];
        isi.judul = _txt_judul.text;
        isi.input1 = _txt_input1.text;
        isi.input2 = _txt_input2.text;
        isi.timestamp = [NSNumber numberWithInteger:[timestamp integerValue]];
        
        //Save to persistant storage
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"sendUser"
         object:self];
        NSArray *people = [UserData all];
        NSLog(@"data user save = %@",people);
        [self.navigationController dismissCurrentPopinControllerAnimated:YES];
        
        [self dismissCurrentPopinControllerAnimated:YES completion:^{
            NSLog(@"Popin dismissed !");
        }];
        
        
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Silahkan isi semua field yang tersedia !"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
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
