//
//  cell_user.h
//  PDAMObj
//
//  Created by reisa prasaptaraya on 4/26/16.
//  Copyright © 2016 reisa prasaptaraya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cell_user : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *txt_judul;
@property (weak, nonatomic) IBOutlet UILabel *txt_pelanggan;
@property (weak, nonatomic) IBOutlet UILabel *txt_nama_perumahan;
@property (weak, nonatomic) IBOutlet UILabel *txt_no_meter;
@property (weak, nonatomic) IBOutlet UILabel *txt_tarif;

@end
