//
//  LIBBookViewController.h
//  iSYSU_Library
//
//  Created by lovaday on 12-11-12.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIBDataManager.h"
#import "Book.h"

@interface LIBBookViewController : UIViewController
{
@private NSInteger index;
}

@property (retain, nonatomic) Book *book;

@property (weak, nonatomic) IBOutlet UIImageView *bookImgIB;
@property (weak, nonatomic) IBOutlet UILabel *bookNameIB;
@property (weak, nonatomic) IBOutlet UILabel *authorIB;
@property (weak, nonatomic) IBOutlet UILabel *identifierIB;
@property (weak, nonatomic) IBOutlet UILabel *statusIB;
@property (weak, nonatomic) IBOutlet UILabel *isbnIB;



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
