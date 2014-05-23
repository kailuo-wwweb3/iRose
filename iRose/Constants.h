//
//  Constants.h
//  iRose
//
//  Created by Kai Luo on 12/21/13.
//  Copyright (c) 2013 Kai Luo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject
#define ROOTURL     @"http://localhost:8080/"
#define kUserName   @"username"
#define kPassword   @"password"
typedef enum {
    LoginValidationRequest,
    CourseScheduleRequest
} RequestType;
@end
