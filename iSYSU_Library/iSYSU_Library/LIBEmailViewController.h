//
//  LIBEmailViewController.h
//  iSYSU_Library
//
//  Created by 04 developer on 12-11-10.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIBDataManager.h"
@interface LIBEmailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property(weak,nonatomic)NSString* email;
- (IBAction)changEmail:(id)sender;
-(void)feedBack;
-(void)setStyle;
@end
