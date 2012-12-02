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
#import "LIBTIMEViewController.h"
#import "LIBConfigureViewController.h"
#import "Book.h"
#import "RadioButton.h"
#import "LIBBookViewController.h"
@interface LIBMyinfoViewController : UIViewController<UIAlertViewDelegate>
{
    @private NSInteger currentBookIndex;
    NSInteger curbook;
}
@property (strong, nonatomic) IBOutlet UITableView *mybooklist;
@property (weak,nonatomic)NSArray* mybookinfo;
-(NSString *)RenewWithIndex:(NSInteger)bookindex;
-(NSString *)getRewMsg;
- (IBAction)logout:(id)sender;
-(void)Login;
- (IBAction)DidRenew:(id)sender;
-(void)doRenew;
-(void)getInfo;
-(void)setStyle;
-(NSString *)DaysCalculator:(NSString *)deadline;
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;
//- (void)btnClicked:(id)sender event:(id)event;
- (void)rbtnClicked:(id)sender event:(id)event;
@property (weak, nonatomic) IBOutlet UILabel *renewBook;
//@property (weak, nonatomic) IBOutlet UITableView *setTable;
@property(nonatomic,retain)IBOutlet UITableViewCell *tableViewCell;
@property(strong,nonatomic)NSArray *setting;
@end
