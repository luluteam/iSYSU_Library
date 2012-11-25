//
//  BookManage.h
//  Library
//
//  Created by ddl on 12-11-10.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"

@interface BookManage : NSObject   

+ (NSMutableArray *)searchBooksByName: (NSString *)bookName;
+ (Book *)getABookInfoBySystemId: (NSString *)systemId;
+ (NSMutableArray *)requestForMoreSearchBooks;

@end
