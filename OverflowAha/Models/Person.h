//
//  Person.h
//  OverflowAha
//
//  Created by niko on 13-10-19.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *avatarUrlStr;

-(id)initWithName:(NSString *)aName andAvatarUrlStr:(NSString*)urlStr;

@end
