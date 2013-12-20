//
//  CourseLookUpController.h
//  iRose
//
//  Created by Kai Luo on 12/19/13.
//  Copyright (c) 2013 Kai Luo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseLookUpController : UIViewController <UIAlertViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@end
