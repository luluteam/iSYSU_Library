//
//  BookManage.m
//  Library
//
//  Created by ddl on 12-11-10.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import "BookManage.h"
#include "User.h"

@implementation BookManage

+ (NSMutableArray *)searchBooksByName:(NSString *)bookName
{
    NSString *baseUrl = [NSString new];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    baseUrl = [defaults valueForKey:@"baseUrl"];

    
    NSMutableArray *searchBookList = [NSMutableArray arrayWithCapacity:10];
    NSMutableArray *searchBookImagesList = [NSMutableArray arrayWithCapacity:10];
    NSMutableArray *returnSearchBookList = [NSMutableArray arrayWithCapacity:10];
    
    NSMutableString *searchbook = [NSMutableString stringWithString:@"?func=find-b&request="];
    NSString *sbook = bookName;
    [searchbook appendString:sbook];
    
    NSString *searchUrl = [baseUrl stringByAppendingString:searchbook];
    searchUrl = [searchUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"search url %@", searchUrl);
    
    NSURL *search = [[NSURL alloc] initWithString:searchUrl];
    NSLog(@"%@",search);
    ASIHTTPRequest *searchRequest = [ASIHTTPRequest requestWithURL:search];
    [searchRequest startSynchronous];
    NSData *searchData = [searchRequest responseData];

    TFHpple *searchxPathParser = [[TFHpple alloc] initWithHTMLData:searchData];
    
    //取得进入搜索后的一个url,并保存到searchBaseUrl里面
    NSArray *aArrayForSearchBaseUrl = [searchxPathParser searchWithXPathQuery:@"//a"];
    TFHppleElement *aElementForBaseUrl = [aArrayForSearchBaseUrl objectAtIndex:0];
    NSArray *aArrayForUrl = [[aElementForBaseUrl objectForKey:@"href"] componentsSeparatedByString:@"-"];
    NSString *searchBaseUrl = [aArrayForUrl objectAtIndex:0];
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:searchBaseUrl forKey:@"searchBaseUrl"];
    
    //取得10本书的系统号
    NSArray *aArrayForSystemId = [searchxPathParser searchWithXPathQuery:@"//tr[4]/td/a"];
    NSMutableArray *currentHrefArr = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < [aArrayForSystemId count]; i++) {
        //从<a>的第0个开始取值，共获取10个值
        //属性
        TFHppleElement *aElement = [aArrayForSystemId objectAtIndex:i];
        NSString *hrefStr = [aElement objectForKey:@"href"];
        NSArray *hrefArray = [hrefStr componentsSeparatedByString:@"&"];
        NSArray *temp = [[hrefArray objectAtIndex:2] componentsSeparatedByString:@"="];
        NSString *href = [[NSString alloc] initWithString:[temp objectAtIndex:1]];
        [currentHrefArr addObject:href];
        Book *book = [Book new];
        [book setSystemId:href];
        book = [BookManage getABookInfoBySystemId: href];
        [searchBookList addObject:book];
    }
//    NSLog(@"%@",currentHrefArr);
    
//    //取得进入搜索后的一个url,并保存到searchBaseUrl里面
//    NSArray *aArrayForSearchBaseUrl = [searchxPathParser searchWithXPathQuery:@"//a"];
//    TFHppleElement *aElementForBaseUrl = [aArrayForSearchBaseUrl objectAtIndex:0];
//    NSArray *aArrayForUrl = [[aElementForBaseUrl objectForKey:@"href"] componentsSeparatedByString:@"-"];
//    NSString *searchBaseUrl = [aArrayForUrl objectAtIndex:0];
//    defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setValue:searchBaseUrl forKey:@"searchBaseUrl"];
    
    //得到10本书的图片
    NSArray *booImageArray = [searchxPathParser searchWithXPathQuery:@"//img"];
    for (int i = 2; i < [booImageArray count] - 3; i++) {
        
        TFHppleElement *aElementForBookImage = [booImageArray objectAtIndex:i];
        NSString *image = [aElementForBookImage objectForKey:@"src"];
        [searchBookImagesList addObject:image];
    }
    
    //得到10本书的馆藏状态
    NSArray *bookStateArray = [searchxPathParser searchWithXPathQuery:@"//td[@class='libs']/a/text()"];
    NSLog(@"%d", [bookStateArray count]);
    for(int i = 0; i < [bookStateArray count]; i++){
        
        TFHppleElement *aElement = [bookStateArray objectAtIndex:i];
        NSString *bookState = [aElement content];
        
        [bookState stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        //NSLog(@"%@", bookState);
        NSArray *tmp = [bookState componentsSeparatedByString:@"，"];
        
        //截取到馆藏复本
        NSArray *tmp1 = [[tmp objectAtIndex:0] componentsSeparatedByString:@":"];
        //截取到已借出复本 
        NSArray *tmp2 = [[tmp objectAtIndex:1] componentsSeparatedByString:@":"];
        
        NSString *copyNumber = [[tmp1 objectAtIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        //NSLog(@"%@", copyNumber);
        
        NSString *borrowedNumber = [[tmp2 objectAtIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        //NSLog(@"%@", borrowedNumber);
        
        Book *book = [searchBookList objectAtIndex:i];
        NSString *imageUrl = [searchBookImagesList objectAtIndex:i];
        [book setImageUrl:[[NSURL alloc] initWithString:imageUrl]];
//        [book setBookStateCopyNumber:copyNumber];
//        [book setBookStateBorrowedNumber:borrowedNumber];
        [returnSearchBookList addObject:book];
    }

//    NSLog(@"%@", returnSearchBookList);
    return returnSearchBookList;
}

+ (NSMutableArray *)requestForMoreSearchBooks
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *baseUrl = [defaults valueForKey:@"searchBaseUrl"];
    
    NSMutableArray *searchBookList = [NSMutableArray arrayWithCapacity:10];
    NSMutableArray *searchBookImagesList = [NSMutableArray arrayWithCapacity:10];
    NSMutableArray *returnSearchBookList = [NSMutableArray arrayWithCapacity:10];
    
    NSString *searchNextPageUrl = [baseUrl stringByAppendingString:@"?func=short-jump&jump="];
    
    NSURL *nextPage = [[NSURL alloc] initWithString:searchNextPageUrl];
    ASIHTTPRequest *searchRequest = [ASIHTTPRequest requestWithURL:nextPage];
    [searchRequest startSynchronous];
    NSData *searchData = [searchRequest responseData];
    
    TFHpple *searchxPathParser = [[TFHpple alloc] initWithHTMLData:searchData];
    
    //取得10本书的系统号
    NSArray *aArrayForSystemId = [searchxPathParser searchWithXPathQuery:@"//tr[4]/td/a"];
    NSMutableArray *currentHrefArr = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < [aArrayForSystemId count]; i++) {
        //从<a>的第0个开始取值，共获取10个值
        //属性
        TFHppleElement *aElement = [aArrayForSystemId objectAtIndex:i];
        NSString *hrefStr = [aElement objectForKey:@"href"];
        NSArray *hrefArray = [hrefStr componentsSeparatedByString:@"&"];
        NSArray *temp = [[hrefArray objectAtIndex:2] componentsSeparatedByString:@"="];
        NSString *href = [[NSString alloc] initWithString:[temp objectAtIndex:1]];
        [currentHrefArr addObject:href];
        Book *book = [Book new];
        [book setSystemId:href];
        book = [BookManage getABookInfoBySystemId: href];
        [searchBookList addObject:book];
    }
//    NSLog(@"%@",currentHrefArr);
    
    //取得进入搜索后的一个url,并保存到searchBaseUrl里面
    NSArray *aArrayForSearchBaseUrl = [searchxPathParser searchWithXPathQuery:@"//a"];
    TFHppleElement *aElementForBaseUrl = [aArrayForSearchBaseUrl objectAtIndex:0];
    NSArray *aArrayForUrl = [[aElementForBaseUrl objectForKey:@"href"] componentsSeparatedByString:@"-"];
    NSString *searchBaseUrl = [aArrayForUrl objectAtIndex:0];
    
    //得到10本书的图片
    NSArray *booImageArray = [searchxPathParser searchWithXPathQuery:@"//img"];
    for (int i = 2; i < [booImageArray count] - 3; i++) {
        
        TFHppleElement *aElementForBookImage = [booImageArray objectAtIndex:i];
        NSString *image = [aElementForBookImage objectForKey:@"src"];
        [searchBookImagesList addObject:image];
    }
    
    //得到10本书的馆藏状态
    NSArray *bookStateArray = [searchxPathParser searchWithXPathQuery:@"//td[@class='libs']/a/text()"];
    NSLog(@"%d", [bookStateArray count]);
    for(int i = 0; i < [bookStateArray count]; i++){
        
        TFHppleElement *aElement = [bookStateArray objectAtIndex:i];
        NSString *bookState = [aElement content];
        
        [bookState stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        //NSLog(@"%@", bookState);
        NSArray *tmp = [bookState componentsSeparatedByString:@"，"];
        
        //截取到馆藏复本
        NSArray *tmp1 = [[tmp objectAtIndex:0] componentsSeparatedByString:@":"];
        //截取到已借出复本 
        NSArray *tmp2 = [[tmp objectAtIndex:1] componentsSeparatedByString:@":"];
        
        NSString *copyNumber = [[tmp1 objectAtIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        //NSLog(@"%@", copyNumber);
        
        NSString *borrowedNumber = [[tmp2 objectAtIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        //NSLog(@"%@", borrowedNumber);
        
        Book *book = [searchBookList objectAtIndex:i];
        NSString *imageUrl = [searchBookImagesList objectAtIndex:i];
        [book setImageUrl:[[NSURL alloc] initWithString:imageUrl]];
        [book setBookStateCopyNumber:copyNumber];
        [book setBookStateBorrowedNumber:borrowedNumber];
        [returnSearchBookList addObject:book];
    }
    
    return returnSearchBookList;
}

+ (Book *)getABookInfoBySystemId:(NSString *)systemId
{
    Book *book = [[Book alloc] init];
 
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *baseUrl = [defaults valueForKey:@"searchBaseUrl"];

    NSMutableString *viewABookInfoStr = [NSMutableString stringWithString:@"?func=direct&doc_number="];
    [viewABookInfoStr appendString:systemId];
    [viewABookInfoStr appendString:@"&format=002"];
    NSString *viewABookInfoUrlStr = [baseUrl stringByAppendingString:viewABookInfoStr];
//    NSLog(@"view %@",viewABookInfoUrlStr);
    NSURL *viewABookInfoUrl = [[NSURL alloc] initWithString:viewABookInfoUrlStr];
    ASIHTTPRequest *searchRequest = [ASIHTTPRequest requestWithURL:viewABookInfoUrl];
    [searchRequest startSynchronous];
    NSData *searchData = [searchRequest responseData];
    
    TFHpple *searchxpathParser = [[TFHpple alloc] initWithHTMLData:searchData];


    NSArray *AbookInfoes = [searchxpathParser searchWithXPathQuery:@"//td[@class='td1']/text()"];
    for(int i = 0; i < [AbookInfoes count]; i++){
        
        TFHppleElement *aElement = [AbookInfoes objectAtIndex:i];
        NSString *info = [aElement content];
        
        //书本的isbn
        if([info isEqualToString:@"ISBN"]){
            
            ++i;
            TFHppleElement *isbnElement = [AbookInfoes objectAtIndex:i];
            NSString *isbn = [isbnElement content];
//            NSLog(@"%@", isbn);
            if(isbn.length > 0){
                
                [book setIsbn:isbn];
            }
        }
        
        //书名和作者信息
        if([info isEqualToString:@"题名"]){
            
            ++i;
            TFHppleElement *bookNameAndAuthorElement = [AbookInfoes objectAtIndex:i];
            NSString *bookNameAndAuthorStr = [bookNameAndAuthorElement content];
//            NSLog(@"%@", bookNameAndAuthorStr);
            
            //判断是否只存在书名
            NSRange range = [bookNameAndAuthorStr rangeOfString:@"/"];
            if(range.length > 0){
 
                NSArray *bookNameAndAuthorArray = [bookNameAndAuthorStr componentsSeparatedByString:@"/"];
                
                NSString *bookName = [bookNameAndAuthorArray objectAtIndex:0];
                NSArray *trimBookName = [bookName componentsSeparatedByString:@" "];
                
                [book setBookName:[trimBookName objectAtIndex:1]];
//                NSLog(@"%@", [trimBookName objectAtIndex:1]); 
                
                NSString *author = [bookNameAndAuthorArray objectAtIndex:1];
                NSArray *trimBookAuthor = [author componentsSeparatedByString:@" "];
                [book setAuthor:[trimBookAuthor objectAtIndex:1]];
//                NSLog(@"%@", [trimBookAuthor objectAtIndex:1]);
            } else {
                
                NSArray *trimBookName = [bookNameAndAuthorStr componentsSeparatedByString:@" "];
                
                [book setBookName:[trimBookName objectAtIndex:1]];
//                NSLog(@"%@", [trimBookName objectAtIndex:1]); 
            }
        }
        
        //图书摘要或简介
        if([info isEqualToString:@"提要或文摘附"]){
            
            ++i;
            TFHppleElement *bookInfoElement = [AbookInfoes objectAtIndex:i];
            NSString *bookInfo = [bookInfoElement content];
//            NSLog(@"%@", bookInfo);
            if(bookInfo.length > 0){
                
                [book setBookInfo:bookInfo];
            }
        }
        
        //图书分类法
        if([info isEqualToString:@"中图分类法"]){
            
            ++i;
            TFHppleElement *bookIdentifierElement = [AbookInfoes objectAtIndex:i];
            NSString *bookIdentifier = [bookIdentifierElement content];
//            NSLog(@"%@", bookIdentifier);
            [book setBookIdentifier:bookIdentifier];
            
        }
        
        //索书号
        if([info isEqualToString:@"索书号"]){
            
            ++i;
            TFHppleElement *bookIdentifierElement = [AbookInfoes objectAtIndex:i];
            NSString *bookIdentifier = [bookIdentifierElement content];
//            NSLog(@"%@", bookIdentifier);
            if(bookIdentifier.length > 0){
                
                [book setBookIdentifier:bookIdentifier];
            }

        }

    }
    
    return book;

}

@end
