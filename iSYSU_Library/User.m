//
//  User.m
//  Library
//
//  Created by ddl on 12-11-1.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize userID;
@synthesize username;
@synthesize password;
@synthesize academy;
@synthesize profession;
@synthesize email;
@synthesize telephone;
@synthesize isMessage;


/**
 *
 * 判断用户是否登录成功
 * 
 * @param loginWithUserID -> 用户学号  userPassword -> 用户密码
 *
 */
- (Boolean)isLoginSuccess:(NSString *)loginWithUserID andPassword:(NSString *)userPassword
{
    if(loginWithUserID == NULL || userPassword == NULL){                                                                //username and password can not be null
        
        return false;
    }
    
    NSURL *logInBaseUrl = [NSURL URLWithString:@"http://202.116.64.108:8991/F/?func=file&file_name=login-session"];      //the url that the user does not log in
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:logInBaseUrl];
    [request setPostValue:loginWithUserID forKey:@"bor_id"];
    [request setPostValue:userPassword forKey:@"bor_verification"];
    [request setPostValue:@"ZSU50" forKey:@"bor_library"];
    [request startSynchronous];

    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:request.responseData];
    NSArray *elements  = [xpathParser searchWithXPathQuery:@"/html/head/script[2]"]; 
    TFHppleElement *element = [[[elements objectAtIndex:0] children] objectAtIndex:0];
    
    NSRange range = {9, [element.content length] - 17};
    NSString *baseUrl = [element.content substringWithRange:range];
    NSLog(@"%@", baseUrl);                                                                                                //the baseUrl is the url that the user has log in
    
    NSURL *infoUrl = [[NSURL alloc] initWithString:[baseUrl stringByAppendingString:@"?func=bor-info"]];
    ASIHTTPRequest *newRequestt = [ASIHTTPRequest requestWithURL:infoUrl];
    [newRequestt startSynchronous];
    
    NSData *infoData = [NSData dataWithContentsOfURL:infoUrl]; 
    TFHpple *xpathParser2 = [[TFHpple alloc] initWithHTMLData:infoData];
    NSArray *elements2  = [xpathParser2 searchWithXPathQuery:@"//div/a/text()"];
    TFHppleElement *infoElement = [elements2 objectAtIndex:0];
    NSString *info = [infoElement content];                                                                                //the info string store the state of the user(log in or log out)
    NSLog(@"%@",info);
    
    if([info hasSuffix:@"退出"]){                                                                                           //if user has log in successfully
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:loginWithUserID forKey:@"userID"];                                                              //username store in the NSUserDefault
        [defaults setValue:userPassword forKey:@"password"];                                                               //store the user password in the host
        [defaults setValue:baseUrl forKey:@"baseUrl"];                                                                     //the baseUrl store the url that has user info
        return true;
        
    } else {
        
        return false;
    }
    
    return false;
}

/**
 *
 *  用户注销登录
 *
 */
- (void)logout
{
    if([User hasUser]){
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:@"" forKey:@"userID"];
        [defaults setValue:@"" forKey:@"password"];
        [defaults setValue:@"" forKey:@"baseUrl"];
    }
    
}

/**
 *
 *  判断本地是否保存有用户信息
 *
 */
+ (Boolean)hasUser
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *defaultUserID = [defaults objectForKey:@"userID"];
    NSString *defaultPassword = [defaults objectForKey:@"password"];
    
    if(defaultUserID != NULL && defaultPassword != NULL){
        
        User *user = [[User alloc] init];
        if([user isLoginSuccess:defaultUserID andPassword:defaultPassword]){
            
            return true;
        }
    }
    
    return false;
}

/**
 *
 * 得到用户的具体信息（包括姓名，学院，专业， email， 手机号码，是否短信提醒的信息）
 *
 *  @return User
 *
 *
 */
+ (User *)getAnUserInfo
{
    
    User *user = [[User alloc] init];
    
    if([User hasUser]){
     
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *baseUrl = [defaults valueForKey:@"baseUrl"];
   
        NSString *updateUrlStr = [baseUrl stringByAppendingString:@"?func=bor-update"];
        
        NSURL *updateUrl = [[NSURL alloc] initWithString:updateUrlStr];
        NSLog(@"userInfo: %@", updateUrlStr);
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:updateUrl];
        [request startSynchronous];
        
        NSData *htmlData = [NSData dataWithContentsOfURL:updateUrl]; 
        TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:htmlData];
        NSArray *elements  = [xpathParser searchWithXPathQuery:@"//td[@class='td2']/input/@value"];
        for(int i = 0; i < [elements count]; i++)
        {
            TFHppleElement *element = [elements objectAtIndex:i];  
            
            //0->username, 1->profession, 2->academy, 5->email, 13->telephone, 15->isMessage
            if (i == 0){
                
                NSString *username = [element content];
                [user setUsername:username];
            } else if (i == 1) {
                
                NSString *profession = [element content];
                [user setProfession:profession];
            } else if (i == 2){
                
                NSString *academy = [element content];
                [user setAcademy:academy];
            } else if (i == 5) {
                
                NSString *email = [element content];
                [user setEmail:email];
            } else if (i == 13) {
                
                NSString *telephone = [element content];
                [user setTelephone:telephone];
            } else if (i == 14) {
                
                NSString *isMessage = [element content];
                [user setIsMessage:isMessage];
            }

        }

    }
    
    return user;
}


/**
 *  
 *  修改用户密码
 *
 *  @param currPassword -> 用户当前密码 newPassword -> 新密码 confirmPassword -> 确认密码
 *
 */
+ (BOOL)changePassword:(NSString *)currPassword withNewPassword:(NSString *)newPassword andConfirmPassword:(NSString *)confirmPassword
{
    if([User hasUser]){
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *baseUrl = [defaults valueForKey:@"baseUrl"];
        NSString *password = [defaults valueForKey:@"password"];
        
        if(![password isEqualToString:currPassword]){                                   //输入的当前用户密码和本地的用户密码不匹配
            
            return false;
        } else{
            
            NSURL *changePasswordUrl = [NSURL URLWithString:[baseUrl stringByAppendingString: @"?func=file&file_name=bor-update-password"]];      
            ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:changePasswordUrl];
    
            [request setPostValue:@"bor-mod-passwd" forKey:@"func"];
            [request setPostValue:currPassword forKey:@"c_verification"];
            [request setPostValue:newPassword forKey:@"new_verification"];
            [request setPostValue:confirmPassword forKey:@"check_verification"];
            [request startSynchronous];
        
            return true; 
        }
    }
    
    return false;

}

/**
 *
 *  修改用户的email，修改成功则返回true，否则返回false
 *
 *  @param email -> 用户的email地址
 *
 */
+ (Boolean)isChangedEmailOk:(NSString *)email
{
    if([User hasUser]){
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *baseUrl = [defaults valueForKey:@"baseUrl"];
        
        NSURL *changeEmailUrl = [NSURL URLWithString:[baseUrl stringByAppendingString: @"?func=bor-update"]];      
        ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:changeEmailUrl];
        
        [request setPostValue:@"bor-update-1" forKey:@"func"];
        [request setPostValue:email forKey:@"F10"];
        [request startSynchronous];
        
        return true; 

    }
    
    return false;
}

/**
 *
 *  修改用户的手机号码，修改成功则返回true，否则返回false
 *
 *  @param phone -> 用户的手机号码
 *
 */
+ (Boolean)isChangedPhoneNumberOk:(NSString *)phone
{
    if([User hasUser]){
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *baseUrl = [defaults valueForKey:@"baseUrl"];
        
        NSURL *changePhoneNumberUrl = [NSURL URLWithString:[baseUrl stringByAppendingString: @"?func=bor-update"]];      
        ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:changePhoneNumberUrl];
        
        [request setPostValue:@"bor-update-1" forKey:@"func"];
        [request setPostValue:phone forKey:@"F16"];
        [request startSynchronous];
        
        return true; 
        
    }
    
    return false;
}


@end
