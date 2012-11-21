//
//  LIBDataManager.h
//  iSYSU_Library
//
//  Created by 04 developer on 12-11-8.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LIBClient.h"
@interface LIBDataManager : NSObject
@property(strong,nonatomic) NSArray* personalInfo;
@property(strong,nonatomic) NSArray* mybookInfo;
@property(strong,nonatomic) NSArray* searchResult;
@property(strong,nonatomic)NSString* renewMsg;
@property(strong,nonatomic)NSString* changeEmailMsg;
@property(strong,nonatomic)NSString* changPhoneMsg;
@property(strong,nonatomic)NSString* bookname;
@property(strong,nonatomic)NSString* isbn;
@property(strong,nonatomic)NSString* number;
@property(strong,nonatomic)NSString* borrownumber;
@property(strong,nonatomic)NSString* searchnumber;
@property(strong,nonatomic)NSString* star;
@property(strong,nonatomic)NSArray* commint;
@property(strong,nonatomic)NSString* author;
+(LIBDataManager *)shareManager;
-(void)setMybookInfo:(NSArray *)mybookInfo;
-(void)setPersonalInfo:(NSArray *)personalInfo;
-(void)setSearchResult:(NSArray *)searchResult;
-(void)requestUpdate;
-(void)requestLonIn:(NSString *)name password:(NSString *)psw;
-(void)requestSearchWithParrtern:(NSString *)parrtern;
-(void)requestRenew:(NSInteger)bookindex;
-(void)requestChangeEmailwithParrtern:(NSString*)email;
-(void)requestChangePhonewithParrtern:(NSString *)phone ;
-(void)requestBookWithIndex:(NSInteger)index;
-(void)requestChangePSWWithPSW:(NSString *)opsw npsw:(NSString *)npsw;
@end
