//
//  ScheduleSettingViewController.m
//  iRose
//
//  Created by Kai Luo on 12/25/13.
//  Copyright (c) 2013 Kai Luo. All rights reserved.
//

#import "ScheduleSettingViewController.h"
#import "ScheduleViewController.h"

@interface ScheduleSettingViewController ()
@property (nonatomic, strong) NSArray *terms;

@end

@implementation ScheduleSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSArray *)terms {
    if (_terms == nil) {
        _terms = [[NSArray alloc] init];
    }
    return _terms;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.userNameTextField.text = self.userName;
    [self loadTerms];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
//    [self performSegueWithIdentifier:@"backToSchedule" sender:nil];
    
    ScheduleViewController *scheduleViewController = (ScheduleViewController *)self.delegate;
    scheduleViewController.userName = self.userNameTextField.text;
    scheduleViewController.termCode = [[self.terms objectAtIndex:[self.termPickerView selectedRowInComponent:0]] objectForKey:@"termCode"];
    [scheduleViewController loadCourses];
    [scheduleViewController.tableView reloadData];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)loadTerms {
    if ([self.terms count] == 0) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
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

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSError *error;
    
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if (error) {
        NSLog(@"there is an error parsing the json data");
        return;
    }
    _terms = (NSArray *)[json objectForKey:@"content"];
    [_termPickerView reloadAllComponents];
    
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


@end
