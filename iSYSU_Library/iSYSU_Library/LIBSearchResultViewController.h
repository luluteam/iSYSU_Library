//
//  LIBSearchResultViewController.h
//  iSYSU_Library
//
//  Created by 04 developer on 12-11-8.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIBDataManager.h"
@interface LIBSearchResultViewController : UIViewController
@property(weak,nonatomic)NSArray* bookList;
-(void)getBook:(NSInteger *)index;
@end
