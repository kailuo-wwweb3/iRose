//
//  ScheduleRequest.h
//  iRose
//
//  Created by Kai Luo on 12/21/13.
//  Copyright (c) 2013 Kai Luo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScheduleRequest : NSObject
@property (nonatomic) NSString *userName;
@property (nonatomic) NSString *termCode;

+ (id)initWithUserName: (NSString *)userName termCode: (NSString *) termCode;


@end
