//
//  CourseRosterViewController.h
//  iRose
//
//  Created by Kai Luo on 1/6/14.
//  Copyright (c) 2014 Kai Luo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface CourseRosterViewController : UITableViewController <NSURLConnectionDataDelegate>
@property (nonatomic) NSString *courseID;
@property (nonatomic) NSString *termCode;
@end
