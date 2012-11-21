//
//  LIBClient.m
//  iSYSU_Library
//
//  Created by 04 developer on 12-11-8.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import "LIBClient.h"
#import "BorrowBooks.h"
#import "BookManage.h"
#import "SVProgressHUD.h"

@implementation LIBClient
@synthesize bookList;
-(BOOL)login:(NSString *)name password:(NSString *)psw
{
    NSLog(@"%@,%@",name,psw);
    
    User *user = [User new];
    BOOL flag = [user isLoginSuccess:name andPassword:psw];
    return flag;
}

-(NSArray *)getInfo
{
    User *user = [User getAnUserInfo];
    NSArray *arr = [NSArray arrayWithObjects:[user username], [user academy], [user profession], [user email], [user telephone], [user isMessage], nil];
    return arr;
}

-(NSArray *)getMyBookInfo
{
    NSArray *arr = [BorrowBooks getMyBorrowedBooks];
    NSLog(@"arr:%@",arr);
    return arr;
}

-(BOOL)search:(NSString *)bookname
{
    bookList = [BookManage searchBooksByName:bookname];
    
    if([bookList count] > 0){
        
        return true;
    }
    
    return false;
}

-(NSArray *)getSearchResult
{
    return self.bookList;
}

-(BOOL)update
{
    if([User hasUser]){
        NSLog(@"update!");
        return true;
    }
    NSLog(@"can not update!");
    return false;
        
}
-(NSString *)renew:(NSInteger)bookindex
{
    NSString * msg = @"renew success";
    return msg;
}
-(NSString *)changeEmail:(NSString *)email
{
    return @"change email success";
}
-(NSString *)changePhone:(NSString *)phone 
{
    return @"change phone success";
}
-(Book*)getBookByIndex:(NSInteger)index
{
    return [bookList objectAtIndex:index];
}
-(BOOL)changePSW:(NSString *)opsw npsw:(NSString *)npsw
{
    return true;
}
@end
