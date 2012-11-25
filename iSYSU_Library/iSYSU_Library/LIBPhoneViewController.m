//
//  LIBPhoneViewController.m
//  iSYSU_Library
//
//  Created by 04 developer on 12-11-10.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import "LIBPhoneViewController.h"

@implementation LIBPhoneViewController
@synthesize phoneText;
@synthesize phone;
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
    //获得原来的电话号码
    self.phone = [[[LIBDataManager shareManager] personalInfo] objectAtIndex:4];
    NSLog(@"phone : %@",phone);
    //显示在text上
    self.phoneText.text = self.phone;
}


- (void)viewDidUnload
{
    [self setPhoneText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
//更改电话号码
- (IBAction)changPhone:(id)sender {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(feedBack) name:@"Did change phonenumber" object:nil];
    [[LIBDataManager shareManager] requestChangePhonewithParrtern:self.phoneText.text];
}
-(void)setSytle
{
    CGRect rect = CGRectMake(0, 0, 100, 74);
    UILabel *title= [[UILabel alloc] initWithFrame:rect];
    title.backgroundColor = [UIColor clearColor];
    title.text = @" 手机号码";
    title.textColor = [UIColor whiteColor];
   // title.textColor = [UIColor colorWithRed:145.0f/255.0f green:229.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
    self.navigationItem.titleView = title;
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] init];
    barButtonItem.image = [UIImage imageNamed:@"backBtn.png"];
    self.navigationItem.backBarButtonItem = barButtonItem; 
}

//更改是否成功
-(void)feedBack
{
    NSLog(@"phone feedback");
    NSString *feedback = [[LIBDataManager shareManager]changPhoneMsg];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更改结果结果" message:feedback delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
    [alert show];
}

@end
