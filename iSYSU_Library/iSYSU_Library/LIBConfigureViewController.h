//
//  LIBConfigureViewController.h
//  iSYSU_Library
//
//  Created by 04 developer on 12-11-10.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIBDataManager.h"
#import "LIBSetPSWViewController.h"
#import "LIBPhoneViewController.h"
#import "LIBEmailViewController.h"
@interface LIBConfigureViewController : UIViewController
{
    UIImageView *navigationBarBackgroundImage;
}

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *school;
@property (weak, nonatomic) IBOutlet UILabel *college;
@property (weak,nonatomic) NSArray* personalinfo;
//@property (weak, nonatomic) IBOutlet UITableView *configTable;
@property(strong,nonatomic)NSArray *setting;
@property(strong,nonatomic)NSArray *gotoPsw;
@property (nonatomic, retain) UIImageView *navigationBarBackgroundImage;
-(void)showInfo;
-(void)setSytle;
//- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;
//- (void)btnClicked:(id)sender event:(id)event;
@end
