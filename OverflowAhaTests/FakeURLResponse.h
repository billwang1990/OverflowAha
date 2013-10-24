//
//  FakeURLResponse.h
//  OverflowAha
//
//  Created by niko on 13-10-23.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FakeURLResponse : NSObject
{
    NSInteger statusCode;
}

-(id)initWithStatusCode:(NSInteger)code;
-(NSInteger)statusCode;

@end
