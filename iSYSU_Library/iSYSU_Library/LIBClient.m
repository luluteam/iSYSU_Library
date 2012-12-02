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
#import "User.h"

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
//    NSLog(@"%@", bookList);
    if(bookList.count <= 0){
        
        return false;
    }
    
    return true;
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
    Boolean isChangeEmailOk = [User isChangedEmailOk:email];
    if(isChangeEmailOk){
        
        return @"你已经成功修改email";
    } else {
        
        return @"修改email失败，请稍后再试";
    }
}
-(NSString *)changePhone:(NSString *)phone 
{
    Boolean isChangePhoneOk = [User isChangedPhoneNumberOk:phone];
    if(isChangePhoneOk){
        
        return @"你已经成功修改手机号码";
    } else {
        
        return @"修改手机号码失败，请稍后再试";
    }
}
-(Book*)getBookByIndex:(NSInteger)index
{
    return [bookList objectAtIndex:index];
}
-(BOOL)changePSW:(NSString *)opsw npsw:(NSString *)npsw
{
    BOOL isChangePswOk = [User changePassword:opsw withNewPassword:npsw andConfirmPassword:npsw];
    return isChangePswOk;
}
-(BOOL)nextPage:(NSInteger)pageNum
{
    //更新booklist，注意是要加进去～～
//    [bookList addObject:@"1"];
    return YES;
}
@end
