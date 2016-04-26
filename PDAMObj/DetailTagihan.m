//
//  DetailTagihan.m
//  PDAMObj
//
//  Created by reisa prasaptaraya on 4/25/16.
//  Copyright © 2016 reisa prasaptaraya. All rights reserved.
//

#import "DetailTagihan.h"
#import "AFNetworking.h"
#import "EGYWebViewController.h"
#import "ObjectiveRecord.h"


#define urlUtama "http://localhost"

@interface DetailTagihan (){
    NSString* dataHTMLHasil;
    
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation DetailTagihan

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self getDataUserTagihan];
//    EGYWebViewController *webViewController = [[EGYWebViewController alloc] initWithAddress:@"http://yahoo.com"];
//    [self.navigationController pushViewController:webViewController animated:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getDataUserTagihan : (NSString*)input1 : (NSString*)input2 {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:@"http://0.0.0.0:8080/api/pdamku"
       parameters:@{@"input1": input1, @"input2":input2}
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSString* encodedString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
              dataHTMLHasil = encodedString;
              [_webView loadHTMLString:dataHTMLHasil baseURL:nil];
              
              NSLog(@"%@", encodedString);
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }];
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
