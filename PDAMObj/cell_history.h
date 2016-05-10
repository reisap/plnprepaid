//
//  cell_history.h
//  PDAMObj
//
//  Created by reisa prasaptaraya on 5/10/16.
//  Copyright © 2016 reisa prasaptaraya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cell_history : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *isi_token;
@property (weak, nonatomic) IBOutlet UILabel *pemkwh;
@property (weak, nonatomic) IBOutlet UILabel *rupiah;
@property (weak, nonatomic) IBOutlet UILabel *daya;
@property (weak, nonatomic) IBOutlet UILabel *nama_bank;
@property (weak, nonatomic) IBOutlet UILabel *tgl_bayar;
@end
