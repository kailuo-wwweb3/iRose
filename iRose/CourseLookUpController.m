//
//  CourseLookUpController.m
//  iRose
//
//  Created by Kai Luo on 12/19/13.
//  Copyright (c) 2013 Kai Luo. All rights reserved.
//

#import "CourseLookUpController.h"
#define kUserName   @"username"
#define kPassword   @"password"

@interface CourseLookUpController ()


@end

@implementation CourseLookUpController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // set up picker view.
    
    
    
    
    // check if authentication is approved or not.
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ([userDefault stringForKey:kUserName] == Nil) {
        [self popLoginView];
    }
    
}

- (void)popLoginView {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Login" message:@"" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"login", nil];
    [alertView setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    UITextField* usernameInput = [alertView textFieldAtIndex:0];
    UITextField* passwordInput = [alertView textFieldAtIndex:1];
    usernameInput.placeholder = @"username";
    passwordInput.placeholder = @"password";
    [passwordInput setSecureTextEntry:YES];
    [alertView show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.cancelButtonIndex) {
        return;
    }
    NSString *username = [alertView textFieldAtIndex:0].text;
    NSString *password = [alertView textFieldAtIndex:1].text;
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:username, kUserName, password, kPassword, nil];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault registerDefaults:dict];
    [userDefault synchronize];
    return;
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger month = [dateComponents month];
    NSInteger year = [dateComponents year];
    
    return (year - 2000) * 4 + month 
    
    
    
    
}


@end
