//
//  LIBLogIn.m
//  iSYSU_Library
//
//  Created by 04 developer on 12-11-8.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import "LIBLogInViewController.h"


@implementation LIBLogInViewController
@synthesize username;
@synthesize password;
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
    // Do any additional setup after loading the view from its nib.
}

//登陆函数
-(void)LogInWithParrtern:(NSString *)usname password:(NSString *)psw
{
    NSLog(@"add observer");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidLogIn) name:@"DidLogIn" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidNotLogIn) name:@"DidNotLogIn" object:nil];
    
    //发送登陆消息
    [[LIBDataManager shareManager] requestLonIn:usname password:psw];
}

//登录成功,
-(void)DidLogIn
{
    self->flag = true;
    NSLog(@"login");
    [self dismissViewControllerAnimated:YES completion:nil];  
}
//登录失败，弹出提示
-(void)DidNotLogIn
{
    self->flag = false;
    NSLog(@"can not log");
}

- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];  
}

- (void)viewDidUnload
{
    [self setUsername:nil];
    [self setPassword:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)login:(id)sender {
    NSString *name = [self.username text];
    NSString *psw = [self.password text];
    [self LogInWithParrtern:name password:psw];
    if (self->flag) {
        NSLog(@"success log in");
        //[self performSegueWithIdentifier:@"login" sender:self];
    } else {
        NSLog(@"Invalid Login!");
    }
}
@end
