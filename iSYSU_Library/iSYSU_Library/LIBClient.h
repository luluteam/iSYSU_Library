//
//  LIBClient.h
//  iSYSU_Library
//
//  Created by 04 developer on 12-11-8.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"
@interface LIBClient : NSObject
-(BOOL)login:(NSString *)name password:(NSString *)psw;
-(NSArray *)getInfo;
-(NSArray *)getMyBookInfo;
-(BOOL)search:(NSString *)bookname;
-(NSArray *)getSearchResult;
-(BOOL)update;
-(NSString *)renew:(NSInteger)bookindex;
-(NSString *)changeEmail:(NSString*)email;
-(NSString *)changePhone:(NSString *)phone;
-(Book *)getBookByIndex:(NSInteger)index;
-(BOOL)changePSW:(NSString *)opsw npsw:(NSString *)npsw;
@property(strong,nonatomic)NSArray* bookList;
@end
