//
//  LIBMyinfoViewController.m
//  iSYSU_Library
//
//  Created by 04 developer on 12-11-10.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import "LIBMyinfoViewController.h"

@implementation LIBMyinfoViewController
@synthesize renewBook;
//@synthesize setTable;
@synthesize mybooklist;
@synthesize mybookinfo;
@synthesize setting;
@synthesize tableViewCell;
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self getInfo];
    [self.mybooklist reloadData];
    NSLog(@"view appear");
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *arr = [NSArray arrayWithObjects:@"帐号设置",@"提醒设置",nil];  
    self.setting = arr;
    [self setStyle];    
    //添加observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getInfo) name:@"DidUpdate" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Login) name:@"DidNotUpdate" object:nil];
    [[LIBDataManager shareManager] requestUpdate];
    
}
-(void)setStyle
{
    [self setBtn];
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
    NSLog(@"%d",currentBookIndex);
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
    [self setRenewBook:nil];
    [super viewDidUnload];
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self setMybooklist:nil];
//    [self setSetTable:nil];
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
    
    if (tableView.tag == 1) {
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
    else {
        static NSString *CustomCellIdentifier =@"CellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CustomCellIdentifier];
        if (cell ==nil) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"LIBMyBookCellView" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        NSUInteger row = [indexPath row];
        Book *book = [Book new];
        book = [mybookinfo objectAtIndex:row];
        UILabel *nameLabel = (UILabel *)[cell viewWithTag:2];
        nameLabel.text = [NSString stringWithString:[book bookName]];
        
        UILabel *deadlineLabel = (UILabel *)[cell viewWithTag:3];
        deadlineLabel.text = [NSString stringWithString:[book returnDate]]; 
        UILabel *backdataLabel = (UILabel *)[cell viewWithTag:4];
        backdataLabel.text = @"2";  
        UIImage *image = [UIImage imageNamed:@"radio.png"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];  
        CGRect frame = CGRectMake(30, 10, 22, 22);  
        button.frame = frame;  
        [button setImage:image forState:UIControlStateNormal];  
        [button addTarget:self action:@selector(rbtnClicked:event:) forControlEvents:UIControlEventTouchUpInside];  
        button.backgroundColor = [UIColor clearColor]; 
        button.tag = 6;
        [cell addSubview: button]; 
        return cell;
    }
    
    
}
-(NSInteger)numberOfSectionInTableView:(UITableView *)tableView{ 
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 1) {
        return 2;
    } else {
        return mybookinfo.count;
    }
}
// 检查用户点击按钮时的位置，并转发事件到对应的accessory tapped事件
//- (void)btnClicked:(id)sender event:(id)event
//{
//    NSSet *touches = [event allTouches];
//    UITouch *touch = [touches anyObject];
//    CGPoint currentTouchPosition = [touch locationInView:self.setTable];
//    NSIndexPath *indexPath = [self.setTable indexPathForRowAtPoint:currentTouchPosition];
//    if(indexPath != nil)
//    {
//        [self tableView:self.setTable accessoryButtonTappedForRowWithIndexPath:indexPath];
//    }
//}
-(void)rbtnClicked:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.mybooklist];
    NSIndexPath *indexPath = [self.mybooklist indexPathForRowAtPoint:currentTouchPosition];
//    UIImage *image = [UIImage imageNamed:@"radioS.png"];
//    UIButton *button = (UIButton *)sender;
//    button.tag =1;
//    [button setImage:image forState:UIControlStateNormal];
////    [self setBtn];
//    button.tag =6;
    if(indexPath != nil)
    {
        [self tableView:self.mybooklist accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}
-(void)setBtn
{
//    NSArray *subviews = [[NSArray alloc] initWithArray:mybooklist.subviews];
//    NSLog(@"%@",subviews);
//    for (UIView *oneview in subviews) {
//        if(oneview.tag == 0){
//             UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom]; 
//            UIImage *image = [UIImage imageNamed:@"radio.png"];
//            [btn setImage:image forState:UIControlStateNormal];
//            CGRect frame = CGRectMake(30, 10, 22, 22);  
//            btn.frame = frame; 
//            [btn addTarget:self action:@selector(rbtnClicked:event:) forControlEvents:UIControlEventTouchUpInside];
//            [oneview addSubview:btn];
//        }
//    }
//    NSLog(@"%@",mybooklist.subviews);
//    UIButton *button = [[UIButton alloc] viewWithTag:0];
//    [button setImage:[UIImage imageNamed:@"radio.png"] forState:UIControlStateNormal];
    UIButton *btn1 = (UIButton *)[self.view viewWithTag:7];
}
-(void)radioButtonSelectedAtIndex:(NSUInteger)index inGroup:(NSString *)groupId{
    NSLog(@"changed to %d in %@",index,groupId);
    self->currentBookIndex = index;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSInteger idx = indexPath.row;
    if (tableView.tag == 1) {
        if (idx == 0) {
            LIBConfigureViewController *confg = [[LIBConfigureViewController alloc] init];
            [[self navigationController] pushViewController:confg animated:YES]; 
        } else {
            LIBRemindViewController *remind = [[LIBRemindViewController alloc] init];
            [[self navigationController]pushViewController:remind animated:YES];
        }
    } 
    else{
        Book *book = [Book new];
        book = [mybookinfo objectAtIndex:idx];
        NSString *name = [[NSString alloc]initWithFormat:@"你选择了《%@》，单击续接按钮续借",book.bookName]; 
        NSLog(@"idx:%@",name);
        self->currentBookIndex = idx;
        renewBook.text = name;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath   
{
    if (tableView.tag == 2) {
        NSLog(@"index:%@",indexPath);
    }
}

@end
