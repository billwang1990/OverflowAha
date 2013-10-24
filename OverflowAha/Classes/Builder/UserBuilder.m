//
//  UserBuilder.m
//  OverflowAha
//
//  Created by niko on 13-10-22.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "UserBuilder.h"
#import "Person.h"

@implementation UserBuilder

+(Person *)personFromDictionary:(NSDictionary *)ownerValues
{
    NSString *name = [ownerValues objectForKey: @"display_name"];
    NSString *avatarURLStr = [NSString stringWithFormat: @"http://www.gravatar.com/avatar/%@", [ownerValues objectForKey: @"email_hash"]];
    Person *owner = [[Person alloc] initWithName: name andAvatarUrlStr: avatarURLStr];
    return owner;
    
}

@end
