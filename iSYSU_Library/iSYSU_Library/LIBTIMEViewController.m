//
//  BIDNotificationViewController.m
//  Notification-View
//
//  Created by hu on 12-11-17.
//  Copyright (c) 2012年 god. All rights reserved.
//

#import "LIBTIMEViewController.h"
@interface LIBTIMEViewController ()

@end

@implementation LIBTIMEViewController
@synthesize lastIndexPath_section1;
@synthesize lastIndexPath_section2;
@synthesize Time_Show;
@synthesize time_picker;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSDate *now = [NSDate date];
    Time_Show.text = [NSDateFormatter localizedStringFromDate:now dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
    NSLog([NSString stringWithFormat:@"yeah"]);
    /*
     lastIndexPath_section1 = [NSIndexPath indexPathForRow:1 inSection:1];
     lastIndexPath_section2 = [NSIndexPath indexPathForRow:1 inSection:2];
     [self.tableView selectRowAtIndexPath:lastIndexPath_section1 animated:YES scrollPosition:UITableViewScrollPositionNone];
     [self.tableView selectRowAtIndexPath:lastIndexPath_section2 animated:YES scrollPosition:UITableViewScrollPositionNone];
     */
    
}

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



@end
