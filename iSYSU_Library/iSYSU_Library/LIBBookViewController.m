//
//  LIBBookViewController.m
//  iSYSU_Library
//
//  Created by lovaday on 12-11-12.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import "LIBBookViewController.h"

@implementation LIBBookViewController
@synthesize bookImg;
@synthesize bookname;
@synthesize isbn;
@synthesize number;
@synthesize borrownumber;
@synthesize star;
@synthesize searchnumber;
@synthesize commint;
@synthesize author;
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
    [self setSytle];
    // Do any additional setup after loading the view from its nib.
    //从前一个页面传值给index；
    self->index = 0;
    //获得那本书的详细信息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getBookInfo) name:@"get book info" object:nil];
    [[LIBDataManager shareManager] requestBookWithIndex:self->index];
}
-(void)getBookInfo
{
    self.bookname = [[LIBDataManager shareManager] bookname];
    self.isbn = [[LIBDataManager shareManager] isbn];
    self.number = [[LIBDataManager shareManager]number];
    self.borrownumber = [[LIBDataManager shareManager] borrownumber];
    self.star = [[LIBDataManager shareManager]star];
    self.searchnumber = [[LIBDataManager shareManager]searchnumber];
    self.commint = [[LIBDataManager shareManager] commint];
    self.author = [[LIBDataManager shareManager] author];
}
- (void)viewDidUnload
{
    [self setBookImg:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)setSytle
{
    CGRect rect = CGRectMake(0, 0, 100, 74);
    UILabel *title= [[UILabel alloc] initWithFrame:rect];
    title.backgroundColor = [UIColor clearColor];
    title.text = @" 书籍信息";
    title.textColor = [UIColor colorWithRed:145.0f/255.0f green:229.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
    self.navigationItem.titleView = title;
}
@end
