//
//  LIBMyinfoViewController.m
//  iSYSU_Library
//
//  Created by 04 developer on 12-11-10.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import "LIBMyinfoViewController.h"

@implementation LIBMyinfoViewController
@synthesize mybooklist;
@synthesize mybookinfo;
//点击续借的书的index

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad]; 
    //自动登录
    NSLog(@"update");
    //添加observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Login) name:@"DidUpdate" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Login) name:@"DidNotUpdate" object:nil];
    [[LIBDataManager shareManager] requestUpdate];
    
}
-(void)Login
{
    CGRect frame = CGRectMake(50, 50, 250, 200); 
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor grayColor];  
    [self.view addSubview:view]; 
}
-(void)getInfo
{
    //拿到借书的信息
    self.mybookinfo = [[LIBDataManager shareManager] mybookInfo];
    NSLog(@"mybook info：%@",mybookinfo);
}
//请求续借
-(NSString *)RenewWithIndex:(NSInteger)bookindex
{
    //添加observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getRewMsg) name:@"did renew" object:nil];
    [[LIBDataManager shareManager] requestRenew:bookindex];
    return [[LIBDataManager shareManager] renewMsg];
}
-(NSString *)getRewMsg
{
    return [[LIBDataManager shareManager] renewMsg];
}

- (IBAction)DidRenew:(id)sender {
    self->currentBookIndex = 0;
    [self RenewWithIndex:self->currentBookIndex];
    NSString * msg = [self getRewMsg];
    NSLog(@"%@",msg);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"续借结果" message:msg delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
    [alert show];
    
}
- (void)viewDidUnload
{
    [self setMybooklist:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
