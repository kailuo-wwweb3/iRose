//
//  CourseLookUpController.h
//  iRose
//
//  Created by Kai Luo on 12/19/13.
//  Copyright (c) 2013 Kai Luo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "TouchJSON/Source/CJSONDeserializer.h"
#import "ScheduleRequest.h"
@interface CourseLookUpController : UIViewController <UIAlertViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@end
