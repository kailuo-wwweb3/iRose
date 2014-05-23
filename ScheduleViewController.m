//
//  ScheduleViewController.m
//  iRose
//
//  Created by Kai Luo on 12/19/13.
//  Copyright (c) 2013 Kai Luo. All rights reserved.
//

#import "ScheduleViewController.h"
#import "Constants.h"
#import "ScheduleSettingViewController.h"
#import "CourseRosterViewController.h"

@interface ScheduleViewController ()
@property (nonatomic) NSArray *courses;
@property (nonatomic) RequestType requestType;
@end

@implementation ScheduleViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (NSString *)userName {
    if (_userName == nil) {
        _userName = [[NSUserDefaults standardUserDefaults] objectForKey:kUserName];
    }
    return _userName;
}

- (NSString *)termCode {
    if (_termCode == nil) {
        _termCode = @"201410";
    }
    return _termCode;
}



- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ([userDefault stringForKey:kUserName] == Nil) {
        [self popLoginView];
    }
    

    [self loadCourses];
}

- (NSArray *)courses {
    if (_courses == nil) {
        _courses = [[NSArray alloc] init];
    }
    return _courses;
}


- (void)loadCourses {
    self.requestType = CourseScheduleRequest;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *postBody = [NSString stringWithFormat:@"&login=%@&password=%@&username=%@&termcode=%@", [userDefaults objectForKey:kUserName], [userDefaults objectForKey:kPassword], self.userName, self.termCode];
    NSData *postData = [postBody dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[ROOTURL stringByAppendingString:@"schedule"]]];
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.courses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CourseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    cell.textLabel.text = [[_courses objectAtIndex:indexPath.row] objectForKey:@"course"];
    cell.detailTextLabel.text = [[_courses objectAtIndex:indexPath.row] objectForKey:@"description"];
    NSLog(@"%@", cell.detailTextLabel.text);
    return cell;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSError *error;
    
    if (self.requestType == CourseScheduleRequest) {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            NSLog(@"there is an error parsing the json data");
            [NSThread sleepForTimeInterval:1.0f];
            [self loadCourses];
            return;
        }
        _courses = [json objectForKey:@"content"];
        [self.tableView reloadData];
    } else if (self.requestType == LoginValidationRequest) {
        
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

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
    [self validateLoginInfoWithUserName:username password:password];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:username, kUserName, password, kPassword, nil];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault registerDefaults:dict];
    [userDefault synchronize];
    
    [self loadCourses];
    return;
}

- (void)validateLoginInfoWithUserName:(NSString *)username password:(NSString *)password {
    self.requestType = LoginValidationRequest;
    NSString *postBody = [NSString stringWithFormat:@"&login=%@&password=%@", username, password];
    NSData *postData = [postBody dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[ROOTURL stringByAppendingString:@"validateLogin"]]];
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

- (IBAction)setting:(id)sender {
    [self performSegueWithIdentifier:@"scheduleSetting" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"scheduleSetting"]) {
        ScheduleSettingViewController *settingViewController = (ScheduleSettingViewController *)segue.destinationViewController;
        settingViewController.delegate = self;
        settingViewController.userName = self.userName;
        settingViewController.termCode = self.termCode;
    } else if ([segue.identifier isEqualToString:@"showRosters"]) {
        CourseRosterViewController *courseRosterViewController = (CourseRosterViewController *)segue.destinationViewController;
        courseRosterViewController.termCode = self.termCode;
        courseRosterViewController.courseID = [sender objectForKey:@"course"];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showRosters" sender:[self.courses objectAtIndex:indexPath.row]];
}
@end

