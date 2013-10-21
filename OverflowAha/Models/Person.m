//
//  Person.m
//  OverflowAha
//
//  Created by niko on 13-10-19.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "Person.h"

@implementation Person

-(id)initWithName:(NSString *)aName andAvatarUrlStr:(NSString *)urlStr
{
    if (self = [super init]) {
        _name = [aName copy];
        _avatarUrlStr = [urlStr copy];
    }
    return self;
}


@end
