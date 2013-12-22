//
//  ScheduleRequest.m
//  iRose
//
//  Created by Kai Luo on 12/21/13.
//  Copyright (c) 2013 Kai Luo. All rights reserved.
//

#import "ScheduleRequest.h"

@implementation ScheduleRequest


+ (id)initWithUserName: (NSString *)userName termCode: (NSString *) termCode {
    ScheduleRequest *request = [[ScheduleRequest alloc] init];
    request.userName = userName;
    request.termCode = termCode;
    return request;
}

@end
