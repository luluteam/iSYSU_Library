//
//  LIBConfigureViewController.m
//  iSYSU_Library
//
//  Created by 04 developer on 12-11-10.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import "LIBConfigureViewController.h"

@implementation LIBConfigureViewController
@synthesize myinfolist;
@synthesize name;
@synthesize school;
@synthesize college;
@synthesize personalinfo;
@synthesize configTable;
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
    [self setMyinfolist:nil];
    [self setName:nil];
    [self setSchool:nil];
    [self setCollege:nil];
    [self setConfigTable:nil];
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
    title.text = @" 帐号设置";
    title.textColor = [UIColor colorWithRed:145.0f/255.0f green:229.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
    self.navigationItem.titleView = title;
}
@end
