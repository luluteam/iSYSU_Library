//
//  LIBConfigureViewController.m
//  iSYSU_Library
//
//  Created by 04 developer on 12-11-10.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import "LIBConfigureViewController.h"

@implementation LIBConfigureViewController

@synthesize name;
@synthesize school;
@synthesize college;
@synthesize personalinfo;
//@synthesize configTable;
@synthesize setting;
@synthesize gotoPsw;
@synthesize navigationBarBackgroundImage;
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
    [self setSytle];
    NSArray *arr = [NSArray arrayWithObjects:@"Email",@"手机号码",nil];  
    self.setting = arr;
    arr = [NSArray arrayWithObjects:@"更改密码", nil];
    self.gotoPsw = arr;
    //取出个人信息，并显示
    self.personalinfo = [[LIBDataManager shareManager] personalInfo];
    NSLog(@"个人信息：%@",personalinfo);
    //显示信息
    [self showInfo];
    
}

//显示信息
-(void)showInfo
{
    self.name.text = [[self personalinfo] objectAtIndex:0];
    self.school.text = [[self personalinfo] objectAtIndex:1];
    self.college.text = [[self personalinfo] objectAtIndex:2];
}

- (void)viewDidUnload
{
    [self setName:nil];
    [self setSchool:nil];
    [self setCollege:nil];
//    [self setConfigTable:nil];
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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    CGRect rect = CGRectMake(0, 0, 100, 74);
    UILabel *title= [[UILabel alloc] initWithFrame:rect];
    title.backgroundColor = [UIColor clearColor];
    title.text = @"  帐号设置";
    title.textColor = [UIColor whiteColor];
    //title.textColor = [UIColor colorWithRed:145.0f/255.0f green:229.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
    self.navigationItem.titleView = title;
    UIImage *image = [UIImage imageNamed:@"nav.png"];
    UIImageView * imageview = [[UIImageView alloc] initWithImage:image];
    self.navigationBarBackgroundImage = imageview;
}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//        static NSString* TableIdentifier = @"configTable";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableIdentifier];
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableIdentifier];
//        }
//        NSUInteger row = [indexPath row];
//        cell.textLabel.text = [self.setting objectAtIndex:row];
//        cell.textLabel.textColor = [UIColor colorWithRed:145.0f/255.0f green:229.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
//        UIImage *image = [UIImage imageNamed:@"rArrow.png"];    
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];  
//        CGRect frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);  
//        button.frame = frame;  
//        
//        [button setBackgroundImage:image forState:UIControlStateNormal];  
//        
//        [button addTarget:self action:@selector(btnClicked:event:) forControlEvents:UIControlEventTouchUpInside];  
//        button.backgroundColor = [UIColor clearColor];  
//        cell.accessoryView = button; 
//        return cell;
//}
//-(NSInteger)numberOfSectionInTableView:(UITableView *)tableView{ 
//    return 1;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//        return 2;
//    
//}
// 检查用户点击按钮时的位置，并转发事件到对应的accessory tapped事件
//- (void)btnClicked:(id)sender event:(id)event
//{
//    NSSet *touches = [event allTouches];
//    UITouch *touch = [touches anyObject];
//    CGPoint currentTouchPosition = [touch locationInView:self.configTable];
//    NSIndexPath *indexPath = [self.configTable indexPathForRowAtPoint:currentTouchPosition];
//    if(indexPath != nil)
//    {
//        [self tableView:self.configTable accessoryButtonTappedForRowWithIndexPath:indexPath];
//    }
//}
//
//- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
//{
//    NSInteger idx = indexPath.row;
//        if (idx == 0) {
//            LIBEmailViewController *email = [[LIBEmailViewController alloc] init];
//            [[self navigationController] pushViewController:email animated:YES]; 
//        } else {
//            LIBPhoneViewController *phone = [[LIBPhoneViewController alloc] init];
//            [[self navigationController]pushViewController:phone animated:YES];
//        }    
//}

@end
