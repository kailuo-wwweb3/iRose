//
//  RosterDetailViewController.h
//  iRose
//
//  Created by Kai Luo on 1/6/14.
//  Copyright (c) 2014 Kai Luo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RosterDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (nonatomic) NSDictionary *rosterInfo;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *cm;
@property (weak, nonatomic) IBOutlet UILabel *major;
@property (weak, nonatomic) IBOutlet UILabel *year;
@property (weak, nonatomic) IBOutlet UILabel *advisor;
@property (weak, nonatomic) IBOutlet UILabel *standing;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;
- (IBAction)sendEmail:(id)sender;
- (IBAction)viewCourses:(id)sender;


@end
