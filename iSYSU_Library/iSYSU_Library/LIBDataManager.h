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
+(LIBDataManager *)shareManager;
-(void)setMybookInfo:(NSArray *)mybookInfo;
-(void)setPersonalInfo:(NSArray *)personalInfo;
-(void)setSearchResult:(NSArray *)searchResult;
-(void)requestUpdate;
-(void)requestLonIn:(NSString *)name password:(NSString *)psw;
-(void)requestSearchWithParrtern:(NSString *)parrtern;
@end
