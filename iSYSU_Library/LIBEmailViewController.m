//
//  LIBEmailViewController.m
//  iSYSU_Library
//
//  Created by 04 developer on 12-11-10.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import "LIBEmailViewController.h"

@implementation LIBEmailViewController
@synthesize emailText;
@synthesize email;
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
    [self setStyle];
    //获得原来的email，并显示
    self.email = [[[LIBDataManager shareManager]personalInfo]objectAtIndex:3];
    NSLog(@"email : %@",self.email);
    self.emailText.text = self.email;
}


- (void)viewDidUnload
{
    [self setEmailText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
//提交email的更改
- (IBAction)changEmail:(id)sender {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(feedBack) name:@"Did change email" object:nil];
    [[LIBDataManager shareManager] requestChangeEmailwithParrtern:self.emailText.text];
}
//显示更改是否成功
-(void)feedBack
{
    NSLog(@"email feedback");
    NSString *feedback = [[LIBDataManager shareManager]changeEmailMsg];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更改结果结果" message:feedback delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)setStyle
{
    CGRect rect = CGRectMake(0, 0, 100, 74);
    UILabel *title= [[UILabel alloc] initWithFrame:rect];
    title.backgroundColor = [UIColor clearColor];
    title.text = @" 电子邮箱";
    title.textColor = [UIColor colorWithRed:145.0f/255.0f green:229.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
    self.navigationItem.titleView = title;
}
@end
