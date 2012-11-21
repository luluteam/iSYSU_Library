//
//  LIBPhoneViewController.h
//  iSYSU_Library
//
//  Created by 04 developer on 12-11-10.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIBDataManager.h"
@interface LIBPhoneViewController : UIViewController
{
@private BOOL didMsg;
}
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
- (IBAction)changPhone:(id)sender;
@property(weak,nonatomic)NSString* phone;
-(void)feedBack;
-(void)setSytle;
@end
