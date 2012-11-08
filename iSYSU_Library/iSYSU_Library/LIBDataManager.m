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
        self.mybookInfo = [[NSArray alloc] initWithArray:[lib getMyBookInfo]];
        NSLog(@"post login");
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
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DidUpdate" object:self];
    } else {
        //登录失败，发送广播
        NSLog(@"post din not update");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DidNotUpdate" object:self];
    }
    
    
}
-(void)requestSearchWithParrtern:(NSString *)parrtern
{
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
@end
