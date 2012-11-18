//
//  User.h
//  Library
//
//  Created by ddl on 12-11-1.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "TFHpple.h"

@interface User : NSObject

@property (strong, nonatomic) NSString *userID;               //User ID
@property (strong, nonatomic) NSString *username;             //User name
@property (strong, nonatomic) NSString *password;             //User password
@property (strong, nonatomic) NSString *academy;              //User academy
@property (strong, nonatomic) NSString *profession;           //User profession
@property (strong, nonatomic) NSString *email;                //User email
@property (strong, nonatomic) NSString *telephone;            //User telephone
@property (strong, nonatomic) NSString *isMessage;            //whether to send user a message

- (Boolean)isLoginSuccess: (NSString *)loginWithUserID andPassword: (NSString *)password;               //judge whether the user can log in the library
- (void)logout;                                                                                         //log out

+ (Boolean)changePassword: (NSString *)currPassword withNewPassword: (NSString *)newPassword andConfirmPassword: (NSString *)confirmPassword;       //change user's password
+ (Boolean)hasUser;                                                                                     //judge whether there has user in the host
+ (User *)getAnUserInfo;                                                                                //to get an user's information
+ (Boolean)isChangedEmailOk: (NSString *)email;                                                         //change user's email
+ (Boolean)isChangedPhoneNumberOk: (NSString *)phone;                                                   //change user's email

@end
