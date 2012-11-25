//
//  BIDNotificationViewController.m
//  Notification-View
//
//  Created by hu on 12-11-17.
//  Copyright (c) 2012年 god. All rights reserved.
//

#import "LIBTIMEViewController.h"
#define kFileName @"date.plist"
@interface LIBTIMEViewController ()

@end

@implementation LIBTIMEViewController
@synthesize lastIndexPath_section1;
@synthesize lastIndexPath_section2;
@synthesize Time_Show;
@synthesize time_picker;
@synthesize Switch_button;

- (NSString *)filePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDirectory, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"%@", documentsDirectory);
    return [documentsDirectory stringByAppendingPathComponent:kFileName];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated{
    /*
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"alarmSetLine.png"]];
    self.tableView.backgroundView = view;
    //[self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"alarmSetLine.png"]]];
    
    //清除背景颜色
    
    int tmep_num[] = {1,3,2,1};
    for (int i= 0; i < 4; i++) {
        for (int j = 0; j < tmep_num[i]; j++) {
            NSIndexPath *temp_index = [NSIndexPath indexPathForRow:j inSection:i];
            UITableViewCell *temp_cell = [self.tableView cellForRowAtIndexPath:temp_index];
            temp_cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alarmSetLine.png"]];
            [temp_cell.textLabel setBackgroundColor:[UIColor clearColor]];
        }
    }
     */
    
    [super viewWillAppear:animated];
    NSString *file = [self filePath];
    NSLog(file);
    if ([[NSFileManager defaultManager] fileExistsAtPath:file]) {
        NSArray *array = [[NSArray alloc] initWithContentsOfFile:file];
        [Switch_button setOn:[[array objectAtIndex:0] boolValue] ];
        
        lastIndexPath_section1 = [NSIndexPath indexPathForRow:[[array objectAtIndex:1] intValue ] inSection:1];
        lastIndexPath_section2 = [NSIndexPath indexPathForRow:[[array objectAtIndex:2] intValue]  inSection:2];
        Time_Show.text = [array objectAtIndex:3];
        
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:lastIndexPath_section1];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell = [self.tableView cellForRowAtIndexPath:lastIndexPath_section2];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }else{
        NSDate *now = [NSDate date];
        Time_Show.text = [NSDateFormatter localizedStringFromDate:now dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
        lastIndexPath_section1 = [NSIndexPath indexPathForRow:2 inSection:1];
        lastIndexPath_section2 = [NSIndexPath indexPathForRow:0 inSection:2];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:lastIndexPath_section1];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell = [self.tableView cellForRowAtIndexPath:lastIndexPath_section2];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    NSNumber *swtich_temp = [[NSNumber alloc] initWithBool:[Switch_button isOn]];
    NSNumber *row1_temp = [[NSNumber alloc] initWithInt:[lastIndexPath_section1 row]];
    NSNumber *row2_temp = [[NSNumber alloc] initWithInt:[lastIndexPath_section2 row]];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:swtich_temp];
    [array addObject:row1_temp];
    [array addObject:row2_temp];
    [array addObject:Time_Show.text];
    
    [array writeToFile:[self filePath] atomically:YES];
}

/*
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog([NSString stringWithFormat:@"yeah"]);
    
     lastIndexPath_section1 = [NSIndexPath indexPathForRow:1 inSection:1];
     lastIndexPath_section2 = [NSIndexPath indexPathForRow:1 inSection:2];
     [self.tableView selectRowAtIndexPath:lastIndexPath_section1 animated:YES scrollPosition:UITableViewScrollPositionNone];
     [self.tableView selectRowAtIndexPath:lastIndexPath_section2 animated:YES scrollPosition:UITableViewScrollPositionNone];
     
    UISwitch *sw = [self.tableView viewWithTag:3];
}
 */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int newRow = [indexPath row];
    int section = [indexPath section];
    NSLog([NSString stringWithFormat:@"%d",section]);
    if ( section == 1 ){
        int oldRow = (lastIndexPath_section1 != nil)? [lastIndexPath_section1 row]: -1;
        if ( newRow != oldRow ) {
            row_1 = newRow;
            NSLog([NSString stringWithFormat:@"%d",row_1]);
            UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
            newCell.accessoryType = UITableViewCellAccessoryCheckmark;
            UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:lastIndexPath_section1];
            oldCell.accessoryType = UITableViewCellAccessoryNone;
            lastIndexPath_section1 = indexPath;
        }
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }else if( section == 2 ){
        row_2 = newRow;
        NSLog([NSString stringWithFormat:@"%d",row_2]);
        int oldRow = (lastIndexPath_section2 != nil)? [lastIndexPath_section2 row]: -1;
        if ( newRow != oldRow ) {
            UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
            newCell.accessoryType = UITableViewCellAccessoryCheckmark;
            UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:lastIndexPath_section2];
            oldCell.accessoryType = UITableViewCellAccessoryNone;
            lastIndexPath_section2 = indexPath;
        }
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }else if( section == 3 ){
        
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\\n\n\n\\n\n\n\n\n\n\n"
                                                                          delegate:self
                                                                 cancelButtonTitle:@"取消"
                                                            destructiveButtonTitle:@"确定"
                                                                 otherButtonTitles:nil];
        
        actionSheet.userInteractionEnabled = YES;
        UIDatePicker *datePicker = [[UIDatePicker alloc] init] ;
        datePicker.datePickerMode = UIDatePickerModeTime;
        
        [actionSheet addSubview:datePicker];
        [actionSheet showInView:self.view];
        //    actionSheet.bounds = CGRectMake(0, 0, 320, 516);
        datePicker.frame = CGRectMake(0, 0, 320, 216);
        time_picker = datePicker;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    }
    
}
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if( buttonIndex == 0 ){
        NSDate *new_date = [time_picker  date];
        Time_Show.text = [NSDateFormatter localizedStringFromDate:new_date dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
        NSString *message = [NSDateFormatter localizedStringFromDate:new_date dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
        NSLog([NSString stringWithFormat:@"%@",message]);
    }
}



- (void)viewDidUnload {
    [self setSwitch_button:nil];
    [super viewDidUnload];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
{
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return  nil;
    }
    
    UILabel * label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 320, 35);
    //    label.backgroundColor = [UIColor clearColor];
    //    label.backgroundColor = [UIColor redColor];
    label.font=[UIFont fontWithName:@"Arial" size:20];
    label.text = sectionTitle;
    label.textColor = [UIColor darkGrayColor];
    CGFloat width_ =  tableView.bounds.size.width;
   //width_ /= 10;
    UIView * sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width_, 220)];
    [sectionView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"alarmSetLine.png"]]];
    [sectionView addSubview:label];
    return sectionView;
}

@end
