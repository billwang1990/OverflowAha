//
//  Answer.m
//  OverflowAha
//
//  Created by niko on 13-10-19.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "Answer.h"

@implementation Answer

-(NSComparisonResult)compare:(Answer*)otherAnswer
{
    if (self.accepted && !(otherAnswer.accepted)) {
        return NSOrderedAscending;
    }
    else if (!self.accepted && otherAnswer.accepted)
    {
        return NSOrderedDescending;
    }
    
    if (self.score > otherAnswer.score) {
        return NSOrderedAscending;
    }
    else if (self.score < otherAnswer.score)
    {
        return NSOrderedDescending;
    }
    else
        return NSOrderedSame;
}

@end
