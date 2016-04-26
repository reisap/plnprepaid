//
//  addDataUser.m
//  PDAMObj
//
//  Created by reisa prasaptaraya on 4/25/16.
//  Copyright © 2016 reisa prasaptaraya. All rights reserved.
//

#import "addDataUser.h"
#import "ObjectiveRecord.h"
#import "User.h"
#import "SingleLineTextField.h"
#import <sqlite3.h>
#import <CoreData/CoreData.h>
#import "UIViewController+MaryPopin.h"

@interface addDataUser ()
@property (weak, nonatomic) IBOutlet UIButton *btn_submit;
@property (weak, nonatomic) IBOutlet SingleLineTextField *txt_judul;
@property (weak, nonatomic) IBOutlet SingleLineTextField *txt_input1;
@property (weak, nonatomic) IBOutlet SingleLineTextField *txt_input2;
@property (weak, nonatomic) IBOutlet SingleLineTextField *txt_tgl;

@end

@implementation addDataUser

- (void)viewDidLoad {
    [super viewDidLoad];
    [CoreDataManager sharedManager].modelName = @"SaveUser";
    [CoreDataManager sharedManager].databaseName = @"SaveUser";
    [[CoreDataManager sharedManager] useInMemoryStore];
    
    _btn_submit.layer.cornerRadius = 5.0;
    _btn_submit.layer.masksToBounds = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)act_submit:(id)sender {
    if(![[_txt_input1 text] isEqualToString:@""] && ![[_txt_input2 text] isEqualToString:@""] &&![[_txt_judul text] isEqualToString:@""]){
        
        NSLog(@"ini judul = %@", _txt_judul.text);
        User *isi = [User create];
        isi.judul = _txt_judul.text;
        isi.input1 = _txt_input1.text;
        isi.input2 = _txt_input2.text;
        
        
        
        [isi save];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"sendUser"
         object:self];
        NSArray *people = [User all];
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
