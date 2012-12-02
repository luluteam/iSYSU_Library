//
//  LIBSearchResultViewController.m
//  iSYSU_Library
//
//  Created by 04 developer on 12-11-8.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import "LIBSearchResultViewController.h"
#import "LIBBookViewController.h"

@implementation LIBSearchResultViewController
@synthesize bookList;
@synthesize tableview;
@synthesize keyword;
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
    [self setStyle];
    NSLog(@"key:%@",self.keyword);
    //添加observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getBook) name:@"finishSearch" object:nil];
    [[LIBDataManager shareManager] requestSearchWithParrtern:self.keyword];
    [self.tableview addPullToRefreshWithActionHandler:^{
        [self refresh];
        [tableview.pullToRefreshView performSelector:@selector(stopAnimating) withObject:nil afterDelay:1];
    }];
    
    // trigger the refresh manually at the end of viewDidLoad
    [tableview.pullToRefreshView triggerRefresh];

}
//下拉刷新
-(void)refresh
{
    //添加observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBooklist) name:@"finish refresh" object:nil];
}
-(void)changeBooklist
{
    [tableview reloadData];
}
//获取书的信息
-(void)getBook
{
    self.bookList = [[LIBDataManager shareManager] searchResult];
    [tableview reloadData];
}
- (void)viewDidUnload
{
    [self setTableview:nil];
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    title.text = @" 搜索结果";
    title.textColor = [UIColor whiteColor];
    //title.textColor = [UIColor colorWithRed:145.0f/255.0f green:229.0f/255.0f blue:145.0f/255.0f alpha:1.0f];
    self.navigationItem.titleView = title;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    LIBBookViewController *bookViewController = segue.destinationViewController;
    
    bookViewController.book = [bookList objectAtIndex:[self.tableview.indexPathForSelectedRow row]];
    NSLog(@"%@", bookViewController.book);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return bookList.count;
}

- (UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    Book *book = [Book new];
    book = [bookList objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = [book bookName];
    cell.detailTextLabel.text = [book author];
    
    return cell;
}

@end
