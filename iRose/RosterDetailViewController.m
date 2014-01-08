//
//  RosterDetailViewController.m
//  iRose
//
//  Created by Kai Luo on 1/6/14.
//  Copyright (c) 2014 Kai Luo. All rights reserved.
//

#import "RosterDetailViewController.h"
#import "ScheduleViewController.h"

@interface RosterDetailViewController ()

@end

@implementation RosterDetailViewController

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
	// Do any additional setup after loading the view.
    [self displayRosterInfo];
}

- (void)displayRosterInfo {
    self.name.text = [self.rosterInfo objectForKey:@"name"];
    self.userName.text = [self.rosterInfo objectForKey:@"username"];
    self.cm.text = [self.rosterInfo objectForKey:@"CM"];
    self.major.text = [self.rosterInfo objectForKey:@"major"];
    self.standing.text = [self.rosterInfo objectForKey:@"class"];
    self.year.text = [self.rosterInfo objectForKey:@"year"];
    self.advisor.text = [self.rosterInfo objectForKey:@"advisor"];
    [self.emailButton setTitle:[self.rosterInfo objectForKey:@"email"] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendEmail:(id)sender {
    NSLog(@"send email");
    NSString *urlEmail = [[@"mailto:" stringByAppendingString:self.emailButton.titleLabel.text] stringByAppendingString:@"?subject=&body="];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlEmail]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ScheduleViewController *scheduleViewController = (ScheduleViewController *)segue.destinationViewController;
    scheduleViewController.userName = self.userName.text;
}

- (IBAction)viewCourses:(id)sender {
    [self performSegueWithIdentifier:@"viewCourses" sender:nil];

}
@end
