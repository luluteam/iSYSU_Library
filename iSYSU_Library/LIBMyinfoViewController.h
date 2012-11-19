//
//  LIBMyinfoViewController.h
//  iSYSU_Library
//
//  Created by 04 developer on 12-11-10.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIBDataManager.h"
#import "LIBLogInViewController.h"
#import "LIBRemindViewController.h"
#import "LIBConfigureViewController.h"
@interface LIBMyinfoViewController : UIViewController
{
    @private NSInteger currentBookIndex;
}
@property (strong, nonatomic) IBOutlet UITableView *mybooklist;
@property (weak,nonatomic)NSArray* mybookinfo;
-(NSString *)RenewWithIndex:(NSInteger *)bookindex;
-(NSString *)getRewMsg;
- (IBAction)DidRenew:(id)sender;
- (IBAction)logout:(id)sender;
-(void)Login;
-(void)getInfo;
－
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;
- (void)btnClicked:(id)sender event:(id)event;
@property (weak, nonatomic) IBOutlet UITableView *setTable;
@property(strong,nonatomic)NSArray *setting;
@end
