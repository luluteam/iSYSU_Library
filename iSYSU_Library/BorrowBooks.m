//
//  BorrowBooks.m
//  Library
//
//  Created by ddl on 12-11-5.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import "BorrowBooks.h"

@implementation BorrowBooks

@synthesize user;
@synthesize bookList;

+ (NSMutableArray *)getMyBorrowedBooks
{
    NSString *myBookName;                               //借的书的名字
    NSString *bookInfo;                                 //借的书的归还日期
    NSString *systemId;                                 //借的书的系统号
    
    NSMutableArray *bookList = [NSMutableArray arrayWithCapacity:10];                           //包含我借的书的数组
    
    if([User hasUser]){
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *baseUrl = [defaults valueForKey:@"baseUrl"];
            
        NSString *myBookUrl = [baseUrl stringByAppendingString:@"?func=bor-loan&adm_library=ZSU50"];
            
            
        NSURL *myBook = [[NSURL alloc] initWithString:myBookUrl];
        NSLog(@"myBook: %@", myBookUrl);
            
        ASIHTTPRequest *myBookRequest = [ASIHTTPRequest requestWithURL:myBook];
        [myBookRequest startSynchronous];
            
        NSData *myBookData = [NSData dataWithContentsOfURL:myBook]; 
        TFHpple *myBookxpathParser = [[TFHpple alloc] initWithHTMLData:myBookData];
        NSArray *myBooks = [myBookxpathParser searchWithXPathQuery:@"//td[@class='td1']/text()"];
        NSArray *myBooklinks = [myBookxpathParser searchWithXPathQuery:@"//td[@class='td1']/a/text()"];
        NSArray *aArray = [myBookxpathParser searchWithXPathQuery:@"//td[@class='td1']/a"];
        
        
            
        int count = [myBooklinks count];
        NSLog(@"%d", count);
        
        NSMutableArray *myBorrowedBookNames = [NSMutableArray arrayWithCapacity:10];
        NSMutableArray *myBorrowedBookReturnDate = [NSMutableArray arrayWithCapacity:10];
        NSMutableArray *myBookBorrowedSystemId = [NSMutableArray arrayWithCapacity:10];
        
        //得到所借书的书名
        //myBookLinks的个数是书本个数的2倍 + 1
        for(int i = 1; i <= (([myBooklinks count] - 1) / 2); i++)
        {
            TFHppleElement *myBookNameElement = [myBooklinks objectAtIndex:(i * 2)];
            myBookName = [myBookNameElement content];
            if(myBookName != nil){
                NSLog(@"%@", myBookName);
                [myBorrowedBookNames addObject:myBookName];
            }
        }
        
        //得到所借书的系统号
        int count_systemId = 0;
        for(int i = 0; i < [aArray count]; i++){
            
            TFHppleElement *aElement = [aArray objectAtIndex:i];
            NSString *hrefStr = [aElement objectForKey:@"href"];
            NSRange range;
            range = [hrefStr rangeOfString:@"doc_number="];
            
            if(range.length){
                
                count_systemId++;
                //NSLog(@"%d", range.length);
                NSArray *hrefArray = [hrefStr componentsSeparatedByString:@"&"];
                NSArray *temp = [[hrefArray objectAtIndex:1] componentsSeparatedByString:@"="];
                //NSLog(@"%@",[[temp objectAtIndex:1] class]);
                NSString *href = [[NSString alloc] initWithString:[temp objectAtIndex:1]];
                if(count_systemId % 3 == 0){
                    
                    [myBookBorrowedSystemId addObject:href];
                    //NSLog(@"href:%@",href); 
                }
            }
        }
        
        //得到所借书的归还日期
        int infoCount = [myBooks count];
        NSLog(@"%d", infoCount);
            
        for(int i = 0; i < [myBooks count]; i++)
        {
            TFHppleElement *myBookInfoElement = [myBooks objectAtIndex:i];
            bookInfo = [myBookInfoElement content];
            
            NSString *dateFormat = @"[0-9]{8}";
            NSError *error;
            
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:dateFormat options:0 error:&error];
            NSTextCheckingResult *isMatchDate = [[NSTextCheckingResult alloc] init];
            if(regex != nil){
                
                isMatchDate = [regex firstMatchInString:bookInfo options:0 range:NSMakeRange(0, [bookInfo length])];
            }
            
            if(isMatchDate){
                
                [myBorrowedBookReturnDate addObject:bookInfo];
                //NSLog(@"%@", bookInfo);
            }
            
        }
        
        //将我借阅的书籍和它的归还日期插入到数组中
        for(int i = 0; i < (([myBooklinks count] - 1) / 2); i++){
            
            Book *borrowBook = [[Book alloc] init];
            
            myBookName = [myBorrowedBookNames objectAtIndex:i];
            bookInfo = [myBorrowedBookReturnDate objectAtIndex:i];
            systemId = [myBookBorrowedSystemId objectAtIndex:i];
            
            [borrowBook setBookName:myBookName];
            [borrowBook setReturnDate:bookInfo];
            [borrowBook setSystemId:systemId];
            
            [bookList addObject:borrowBook];
            
        }
        
        return bookList;
    }
    
    return NULL;
}

@end
