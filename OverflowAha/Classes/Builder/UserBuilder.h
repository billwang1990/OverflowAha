//
//  UserBuilder.h
//  OverflowAha
//
//  Created by niko on 13-10-22.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface UserBuilder : NSObject

+(Person*)personFromDictionary:(NSDictionary*)valueDic;

@end
