//
//  LIBSearchResultViewController.h
//  iSYSU_Library
//
//  Created by 04 developer on 12-11-8.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIBDataManager.h"
#import "SVPullToRefresh.h"
@interface LIBSearchResultViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>


@property(retain, nonatomic)NSArray* bookList;
@property(strong,nonatomic)NSString* keyword;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
-(void)getBook;
-(void)setStyle;
-(void)refresh;
-(void)changeBooklist;
@end
