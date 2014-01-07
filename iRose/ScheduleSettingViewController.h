//
//  ScheduleSettingViewController.h
//  iRose
//
//  Created by Kai Luo on 12/25/13.
//  Copyright (c) 2013 Kai Luo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface ScheduleSettingViewController : UIViewController <NSURLConnectionDataDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *termPickerView;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (nonatomic) NSString *userName;
@property (nonatomic) NSString *termCode;
@property (nonatomic, assign) id delegate;
- (IBAction)done:(id)sender;

@end
