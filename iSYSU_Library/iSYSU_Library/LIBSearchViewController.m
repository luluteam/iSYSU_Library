//
//  LIBSearchViewController.m
//  iSYSU_Library
//
//  Created by 04 developer on 12-11-8.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//
//lulu

#import "LIBSearchViewController.h"
#import "SVProgressHUD.h"

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
    if ([self.tabBarController.tabBar respondsToSelector:@selector(setTintColor:)])
    self.tabBarController.tabBar.backgroundImage = [UIImage imageNamed:@"tabBar.png"];
    self.tabBarController.tabBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [[UIDevice currentDevice] systemVersion];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 4.9) {
        
        //iOS 5
        UIImage *toolBarIMG = [UIImage imageNamed: @"nav.png"];  
        
        if ([self.navigationController.toolbar respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)]) { 
            [self.navigationController.toolbar  setBackgroundImage:toolBarIMG forToolbarPosition:0 barMetrics:0]; 
        }
        
    } 
    //[[self.navigationController.navigationBar] setBackgroundImage:[UIImage imageNamed:@"navbar.png"]];
//    [self.tabBarController.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"searchBtn_On"]];
    
}


- (IBAction)stb:(id)sender {

    [SVProgressHUD showWithStatus:@"loading"];
    [self searchWithBookName:[self.BookName text]];
    
    [self performSegueWithIdentifier:@"search" sender:self];
    [SVProgressHUD dismiss];
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
    NSLog(@"hisdbaoidh");
    CGRect cg = CGRectMake(10, 10, 100, 100);
    UIView *view = [[UIView alloc] initWithFrame:cg];
    view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view];
    [[LIBDataManager shareManager] requestSearchWithParrtern:name];
}

-(void)showSearchResult:(NSArray *)searchResult
{
    NSLog(@"search result");
    self.searchResult = [[LIBDataManager shareManager] searchResult];
    [self.view removeFromSuperview];
    NSLog(@"%@",self.searchResult);
}

- (IBAction)backgroundTap:(id)sender {
    
    [BookName resignFirstResponder];
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
