//
//  Book.h
//  Library
//
//  Created by ddl on 12-11-5.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property (strong, nonatomic) NSString *bookName;                   //书名

@property (strong, nonatomic) NSString *author;                     //作者

@property (strong, nonatomic) NSString *bookIdentifier;             //索书号

@property (strong, nonatomic) NSURL *imageUrl;                      //图书图片的链接

@property (strong, nonatomic) NSString *returnDate;                 //归还日期

@property (strong, nonatomic) NSString *systemId;                   //书籍的系统号

@property (strong, nonatomic) NSString *isbn;                       //图书的isbn

@property (strong, nonatomic) NSString *bookInfo;                   //图书的摘要

@end
