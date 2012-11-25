//
//  LIBLogIn.h
//  iSYSU_Library
//
//  Created by 04 developer on 12-11-8.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIBDataManager.h"
@interface LIBLogInViewController : UIViewController
{
    BOOL flag;
}

-(void)LogInWithParrtern:(NSString *)usname password:(NSString *)psw;
-(void)DidLogIn;
-(void)DidNotLogIn;
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
- (IBAction)login:(id)sender;
@end
