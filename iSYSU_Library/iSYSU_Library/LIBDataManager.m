//
//  LIBDataManager.m
//  iSYSU_Library
//
//  Created by 04 developer on 12-11-8.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import "LIBDataManager.h"

@implementation LIBDataManager
@synthesize personalInfo;
@synthesize mybookInfo;
@synthesize searchResult;
@synthesize renewMsg;
@synthesize changPhoneMsg;
@synthesize changeEmailMsg;
@synthesize bookname;
@synthesize isbn;
@synthesize number;
@synthesize borrownumber;
@synthesize star;
@synthesize searchnumber;
@synthesize commint;
@synthesize author;
+(LIBDataManager *)shareManager{
    static LIBDataManager* shareManager;
    if (!shareManager) {
        shareManager = [LIBDataManager new];
    }
    return shareManager;
}
-(void)requestLonIn:(NSString *)name password:(NSString *)psw
{
    LIBClient *lib = [LIBClient new];
    if ([lib login:name password:psw]) {
        //发送登陆成功的广播，并获取个人信息
        self.personalInfo = [lib getInfo];
        self.mybookInfo = [lib getMyBookInfo];
        NSLog(@"post login:%@",mybookInfo);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DidLogIn" object:self];
    } else {
        //发送登陆失败的广播
        NSLog(@"post can not login");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DidNotLogIn" object:self];
    }
}
-(void)requestUpdate
{
    LIBClient *lib = [LIBClient new];
    if ([lib update]) {
        //登陆成功，发送广播
        NSLog(@"post did update");
        self.personalInfo = [lib getInfo];
        self.mybookInfo = [lib getMyBookInfo];
        NSLog(@"mybook:%@",mybookInfo);
        self->isupdate = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DidUpdate" object:self];
    } else {
        //登录失败，发送广播
        NSLog(@"post din not update");
        self->isupdate = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DidNotUpdate" object:self];
    }
    
    
}
-(void)requestSearchWithParrtern:(NSString *)parrtern
{
    self->pagenum = 0;
    LIBClient *lib = [LIBClient new];
    if ([lib search:parrtern]) {
        //搜索成功，发送广播，并存储搜索结果
        NSLog(@"finish search");
        self.searchResult = [[NSArray alloc] initWithArray:[lib getSearchResult]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"finishSearch" object:self];
        
    } else {
        //搜索失败，发送广播
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cannotSearch" object:self];
    }
}
-(void)requestRenew:(NSInteger)bookindex
{
    LIBClient *lib = [LIBClient new];
    self.renewMsg =[lib renew:bookindex];
    NSLog(@"%@",self.renewMsg);
    //发送广播
    NSLog(@"post renew");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"did renew" object:self];
}
-(void)requestChangeEmailwithParrtern:(NSString *)email
{
    NSLog(@"new email:%@",email);
    LIBClient *lib = [LIBClient new];
    self.changeEmailMsg = [lib changeEmail:email];
    //发送广播
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Did change email" object:nil];
}
-(void)requestChangePhonewithParrtern:(NSString *)phone
{
    NSLog(@"new phone:%@",phone);
    LIBClient *lib = [LIBClient new];
    self.changPhoneMsg = [lib changePhone:phone ];
    //发送广播
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Did change phonenumber" object:nil];
}
-(void)requestBookWithIndex:(NSInteger)index
{
    Book* book = [self.searchResult objectAtIndex:index];
    bookname = [book bookName];
    isbn = [book isbn];
    number = @"2";
    borrownumber = @"1";
    star = @"5";
    searchnumber = @"TP-234";
    commint = nil;
    author = [book author];
    //发送广播
    [[NSNotificationCenter defaultCenter] postNotificationName:@"get book info" object:nil];
}
-(void)requestChangePSWWithPSW:(NSString *)opsw npsw:(NSString *)npsw
{
    LIBClient *lib = [LIBClient new];
    if ([lib changePSW:opsw npsw:npsw]) {
        //更改密码成功发送广播
        [[NSNotificationCenter defaultCenter] postNotificationName:@"did change password" object:nil];
    } else {
        //未能更改成功
        [[NSNotificationCenter defaultCenter] postNotificationName:@"did not change password" object:nil];
    }
}
-(void)requestNextPageOfBook
{
    self->pagenum++;
    LIBClient *lib = [LIBClient new];
    if ([lib nextPage:self->pagenum]) {
        //刷新，发送广播，并存储结果
        self.searchResult = [[NSArray alloc] initWithArray:[lib getSearchResult]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"finish refresh" object:self];
        
    } else {
        //搜索失败，发送广播
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cannot refresh" object:self];
    }
}
@end
