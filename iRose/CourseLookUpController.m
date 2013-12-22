//
//  CourseLookUpController.m
//  iRose
//
//  Created by Kai Luo on 12/19/13.
//  Copyright (c) 2013 Kai Luo. All rights reserved.
//

#import "CourseLookUpController.h"
#import "ScheduleViewController.h"

#define kUserName   @"username"
#define kPassword   @"password"
#define kShowSchedule @"showSchedule"

@interface CourseLookUpController ()
@property (nonatomic, strong) NSArray *terms;

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

- (NSArray *)terms {
    if (_terms == nil) {
        _terms = [[NSArray alloc] init];
    }
    return _terms;
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
    
    [self loadTerms];
    return;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    // call API to load total number of rows.
    return [self.terms count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if ([self.terms count] > 0) {
        return [[self.terms objectAtIndex:row] objectForKey:@"termName"];
    } else {
        return @"";
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *termCode = [self.terms objectAtIndex:row];
    NSString *userName = self.userNameTextField.text;
    ScheduleRequest *request = [ScheduleRequest initWithUserName:termCode termCode:userName];
    [self performSegueWithIdentifier:kShowSchedule sender:request];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ScheduleViewController *destination = segue.destinationViewController;
    [destination setScheduleRequest:sender];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSError *error;

    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if (error) {
        NSLog(@"there is an error parsing the json data");
        return;
    }
    _terms = (NSArray *)[json objectForKey:@"content"];
    [_pickerView reloadAllComponents];
}

- (void)loadTerms {
    if ([self.terms count] == 0) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSLog(@"%@", [userDefaults objectForKey:kPassword]);
        NSString *postBody = [NSString stringWithFormat:@"&login=%@&password=%@", [userDefaults objectForKey:kUserName], [userDefaults objectForKey:kPassword]];
        NSData *postData = [postBody dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[ROOTURL stringByAppendingString:@"terms"]]];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        [request setHTTPBody:postData];
        NSLog(@"%@", [[request URL] absoluteString]);
        NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        if (conn) {
            NSLog(@"Connnection success");
        } else {
            NSLog(@"Connection fail");
        }
    }
}
@end
