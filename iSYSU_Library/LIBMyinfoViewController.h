//
//  LIBMyinfoViewController.h
//  iSYSU_Library
//
//  Created by 04 developer on 12-11-10.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIBDataManager.h"
@interface LIBMyinfoViewController : UIViewController
{
    @private NSInteger currentBookIndex;
}
@property (strong, nonatomic) IBOutlet UITableView *mybooklist;
@property (weak,nonatomic)NSArray* mybookinfo;
-(NSString *)RenewWithIndex:(NSInteger *)bookindex;
-(NSString *)getRewMsg;
- (IBAction)DidRenew:(id)sender;
@end
