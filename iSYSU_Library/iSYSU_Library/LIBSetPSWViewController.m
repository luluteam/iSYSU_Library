//
//  LIBSetPSWViewController.m
//  iSYSU_Library
//
//  Created by lovaday on 12-11-17.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import "LIBSetPSWViewController.h"

@implementation LIBSetPSWViewController
@synthesize ordPSW;
@synthesize nPSW;
@synthesize confPSW;

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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [self setOrdPSW:nil];
    [self setNPSW:nil];
    [self setConfPSW:nil];
    [super viewDidUnload];
    [self setStyle];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)setStyle
{
    CGRect rect = CGRectMake(0, 0, 100, 74);
    UILabel *title= [[UILabel alloc] initWithFrame:rect];
    title.backgroundColor = [UIColor clearColor];
    title.text = @" 更改密码";
    title.textColor = [UIColor colorWithRed:145.0f/255.0f green:229.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
    self.navigationItem.titleView = title;
}

- (IBAction)savePSW:(id)sender {
    NSString *opsw = self.ordPSW.text;
    NSString *npsw = self.nPSW.text;
    NSString *cpsw = self.confPSW.text;
    if ([npsw isEqualToString:cpsw]) {
        //添加obsever
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChange) name:@"did change password" object:nil];
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didNotChange) name:@"did not change password" object:nil];
        [[LIBDataManager shareManager] requestChangePSWWithPSW:opsw npsw:npsw];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更改失败" message:@"两次密码不相同" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
        [alert show];

    }
}

-(void)didChange
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"更改成功" delegate:nil cancelButtonTitle:@"ok"otherButtonTitles:nil, nil];
    [alert show];
}
-(void)didNotChange
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更改失败" message:@"原密码错误" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
}
@end
