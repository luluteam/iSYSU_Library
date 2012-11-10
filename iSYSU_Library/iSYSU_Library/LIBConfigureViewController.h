//
//  LIBConfigureViewController.h
//  iSYSU_Library
//
//  Created by 04 developer on 12-11-10.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIBDataManager.h"
@interface LIBConfigureViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *myinfolist;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *school;
@property (weak, nonatomic) IBOutlet UILabel *college;
@property (weak,nonatomic) NSArray* personalinfo;
@end
