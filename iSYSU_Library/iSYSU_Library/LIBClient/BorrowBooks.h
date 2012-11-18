//
//  BorrowBooks.h
//  Library
//
//  Created by ddl on 12-11-5.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Book.h"

@interface BorrowBooks : NSObject

@property (strong, nonatomic) User *user;

@property (strong, nonatomic) NSMutableArray *bookList;

+ (NSMutableArray *)getMyBorrowedBooks;

@end
