//
//  LIBClient.m
//  iSYSU_Library
//
//  Created by 04 developer on 12-11-8.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import "LIBClient.h"

@implementation LIBClient
-(BOOL)login:(NSString *)name password:(NSString *)psw
{
    NSLog(@"%@,%@",name,psw);
    if ([name isEqualToString:@"lulu"]) {
        return true;
    } else {
        return false;
    }
    return true;
}

-(NSArray *)getInfo
{
    NSArray *arr = [NSArray arrayWithObjects:@"lulu",@"SS",@"SE",@"123@123.com",@"123456",@"yes",@"psw",nil];
    return arr;
}

-(NSArray *)getMyBookInfo
{
    NSArray *arr = [NSArray arrayWithObjects: @"a",@"b",@"c",@"d",nil];
    return arr;
}

-(BOOL)search:(NSString *)bookname
{
//    if (bookname == @"book") {
//        return true;
//    } else {
//        return false;
//    }
    return true;
}

-(NSArray *)getSearchResult
{
    NSArray *arr = [NSArray arrayWithObjects:@"e",@"f",@"g",@"h",nil];
    return arr;
}

-(BOOL)update
{
    return true;
}
@end
