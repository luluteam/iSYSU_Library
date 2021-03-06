//
//  LIBMyinfoViewController.m
//  iSYSU_Library
//
//  Created by 04 developer on 12-11-10.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import "LIBMyinfoViewController.h"

@implementation LIBMyinfoViewController
@synthesize setTable;
@synthesize mybooklist;
@synthesize mybookinfo;
@synthesize setting;
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
    NSArray *arr = [NSArray arrayWithObjects:@"帐号设置",@"提醒设置",nil];  
    self.setting = arr;
//    [self.tabBarController.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"homeBtn_On"]];
    [self setStyle];    
    //自动登录
//    NSLog(@"update");
    //添加observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getInfo) name:@"DidUpdate" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Login) name:@"DidNotUpdate" object:nil];
    [[LIBDataManager shareManager] requestUpdate];
    
}
-(void)setStyle
{
    self.tabBarItem.image = [UIImage imageNamed:@"homeBtn_On"];
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
    CGRect rect = CGRectMake(0, 0, 100, 74);
    UILabel *title= [[UILabel alloc] initWithFrame:rect];
    title.backgroundColor = [UIColor clearColor];
    title.text = @" 我的图书馆";
    title.textColor = [UIColor colorWithRed:145.0f/255.0f green:229.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
    self.navigationItem.titleView = title;

}
-(void)Login
{
     [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"login"] animated:YES completion:nil];  
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

- (IBAction)logout:(id)sender {
    [self Login];
}
- (void)viewDidUnload
{
     [self.navigationController popToRootViewControllerAnimated:YES];
    [self setMybooklist:nil];
    [self setSetTable:nil];
    [super viewDidUnload];
    self.setting = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* TableIdentifier = @"setTable";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableIdentifier];
    }
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [self.setting objectAtIndex:row];
    cell.textLabel.textColor = [UIColor colorWithRed:145.0f/255.0f green:229.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
    UIImage *image = [UIImage imageNamed:@"rArrow.png"];    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];  
    CGRect frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);  
    button.frame = frame;  
    
    [button setBackgroundImage:image forState:UIControlStateNormal];  
    
    [button addTarget:self action:@selector(btnClicked:event:) forControlEvents:UIControlEventTouchUpInside];  
    button.backgroundColor = [UIColor clearColor];  
    cell.accessoryView = button;  
    return cell;
}
-(NSInteger)numberOfSectionInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
// 检查用户点击按钮时的位置，并转发事件到对应的accessory tapped事件
- (void)btnClicked:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.setTable];
    NSIndexPath *indexPath = [self.setTable indexPathForRowAtPoint:currentTouchPosition];
    if(indexPath != nil)
    {
        [self tableView:self.setTable accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSInteger idx = indexPath.row;
    if (idx == 0) {
        LIBConfigureViewController *confg = [[LIBConfigureViewController alloc] init];
        [[self navigationController] pushViewController:confg animated:YES]; 
    } else {
        LIBRemindViewController *remind = [[LIBRemindViewController alloc] init];
        [[self navigationController]pushViewController:remind animated:YES];
    }
}
@end
