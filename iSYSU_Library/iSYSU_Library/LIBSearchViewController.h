//
//  LIBSearchViewController.h
//  iSYSU_Library
//
//  Created by 04 developer on 12-11-8.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIBDataManager.h"
@interface LIBSearchViewController : UIViewController
{
    @private
        bool update;
}
@property (weak,nonatomic) NSArray* searchResult;
@property (strong, nonatomic) IBOutlet UITextField *BookName;
- (IBAction)stb:(id)sender;

-(void)didUpdate;
-(void)didnotUpdate;
-(BOOL)getUpdate;
-(void)searchWithBookName:(NSString *)name;
-(void)showSearchResult:(NSArray *)searchResult;
@end
