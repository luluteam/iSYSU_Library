//
//  LIBSetPSWViewController.h
//  iSYSU_Library
//
//  Created by lovaday on 12-11-17.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIBDataManager.h"
@interface LIBSetPSWViewController : UIViewController
-(void)setStyle;
- (IBAction)savePSW:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *ordPSW;
@property (weak, nonatomic) IBOutlet UITextField *nPSW;
@property (weak, nonatomic) IBOutlet UITextField *confPSW;
-(void)didChange;
-(void)didNotChange;
@end
