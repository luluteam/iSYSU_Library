//
//  LIBSearchResultViewController.h
//  iSYSU_Library
//
//  Created by 04 developer on 12-11-8.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIBDataManager.h"
@interface LIBSearchResultViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>


@property(retain, nonatomic)NSArray* bookList;

@property (weak, nonatomic) IBOutlet UITableView *tableview;
-(void)getBook:(NSInteger *)index;
-(void)setStyle;

@end
