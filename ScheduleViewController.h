//
//  ScheduleViewController.h
//  iRose
//
//  Created by Kai Luo on 12/19/13.
//  Copyright (c) 2013 Kai Luo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleRequest.h"

@interface ScheduleViewController : UITableViewController <NSURLConnectionDataDelegate, UITextFieldDelegate>
- (IBAction)setting:(id)sender;
@property (nonatomic) ScheduleRequest *request;
@property (nonatomic) NSString *userName;
@property (nonatomic) NSString *termCode;


- (void)loadCourses;
@end
