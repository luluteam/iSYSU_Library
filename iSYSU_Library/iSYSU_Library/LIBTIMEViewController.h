//
//  BIDNotificationViewController.h
//  Notification-View
//
//  Created by hu on 12-11-17.
//  Copyright (c) 2012年 god. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LIBTIMEViewController : UITableViewController{
    NSUInteger row_1;
    NSUInteger row_2;
}
@property (strong, nonatomic) NSIndexPath *lastIndexPath_section1;
@property (strong, nonatomic) NSIndexPath *lastIndexPath_section2;
@property (weak, nonatomic) IBOutlet UILabel *Time_Show;
@property (weak, nonatomic) UIDatePicker *time_picker;
@property (weak, nonatomic) IBOutlet UISwitch *Switch_button;

- (NSString *)filePath;
@end
