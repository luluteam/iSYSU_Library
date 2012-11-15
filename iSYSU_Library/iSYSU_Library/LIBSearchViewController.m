//
//  LIBSearchViewController.m
//  iSYSU_Library
//
//  Created by 04 developer on 12-11-8.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//
//lulu

#import "LIBSearchViewController.h"

@implementation LIBSearchViewController
@synthesize BookName;
@synthesize searchResult;
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
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //自动登录
    NSLog(@"update");
    //添加observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUpdate) name:@"DidUpdate" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didnotUpdate) name:@"DidNotUpdate" object:nil];
    [[LIBDataManager shareManager] requestUpdate];
}


- (IBAction)stb:(id)sender {
    [self searchWithBookName:[self.BookName text]];
}

-(void)didUpdate
{
     self->update = true;
}
-(void)didnotUpdate
{
    self->update = false;
}
-(BOOL)getUpdate
{
    return self->update;
}

//搜索
-(void)searchWithBookName:(NSString *)name
{
    //添加observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSearchResult:) name:@"finishSearch" object:nil];
    [[LIBDataManager shareManager] requestSearchWithParrtern:name];
}

-(void)showSearchResult:(NSArray *)searchResult
{
    NSLog(@"search result");
    self.searchResult = [[LIBDataManager shareManager] searchResult];
    NSLog(@"%@",self.searchResult);
}

- (void)viewDidUnload
{
    [self setBookName:nil];
    //[self setsearchResult:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
