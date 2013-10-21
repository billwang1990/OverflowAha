//
//  Question.m
//  OverflowAha
//
//  Created by niko on 13-10-18.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "Question.h"

@implementation Question

-(id)init
{
    if (self = [super init]) {
        answerSet = [[NSMutableSet alloc]init];
    }
    return self;
}

-(void)addAnswer:(Answer *)answer{
    [answerSet addObject:answer];
}

-(NSArray *)answers
{
    return [[answerSet allObjects]sortedArrayUsingSelector:@selector(compare:)];
}


@end
