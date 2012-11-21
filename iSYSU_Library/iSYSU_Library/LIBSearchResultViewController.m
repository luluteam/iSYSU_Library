//
//  LIBSearchResultViewController.m
//  iSYSU_Library
//
//  Created by 04 developer on 12-11-8.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import "LIBSearchResultViewController.h"

@implementation LIBSearchResultViewController
@synthesize bookList;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setStyle];
    // Do any additional setup after loading the view from its nib.
    //获取搜索结果
    self.bookList = [[LIBDataManager shareManager] searchResult];
    NSLog(@"%@",self.bookList);
}

//获取单本书的信息
-(void)getBook:(NSInteger *)index
{
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)setStyle
{
    CGRect rect = CGRectMake(0, 0, 100, 74);
    UILabel *title= [[UILabel alloc] initWithFrame:rect];
    title.backgroundColor = [UIColor clearColor];
    title.text = @" 搜索结果";
    title.textColor = [UIColor colorWithRed:145.0f/255.0f green:229.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
    self.navigationItem.titleView = title;
}

@end
