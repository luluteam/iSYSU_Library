//
//  LIBBookViewController.h
//  iSYSU_Library
//
//  Created by lovaday on 12-11-12.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIBDataManager.h"
@interface LIBBookViewController : UIViewController
{
@private NSInteger index;
}
@property (weak, nonatomic) IBOutlet UIImageView *bookImg;
@property(weak,nonatomic)NSString* bookname;
@property(weak,nonatomic)NSString* isbn;
@property(weak,nonatomic)NSString* number;
@property(weak,nonatomic)NSString* borrownumber;
@property(weak,nonatomic)NSString* searchnumber;
@property(weak,nonatomic)NSString* star;
@property(weak,nonatomic)NSArray* commint;
@property(weak,nonatomic)NSString* author;
-(void)getBookInfo;
-(void)setSytle;
@end
