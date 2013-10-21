//
//  MockStackOverflowCommunicator.m
//  OverflowAha
//
//  Created by niko on 13-10-21.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "MockStackOverflowCommunicator.h"

@implementation MockStackOverflowCommunicator
{
    BOOL   wasAskedToFetchQuestions;
}

-(void)searchForQuestionWithTag:(NSString *)tag
{
    wasAskedToFetchQuestions = YES;
}

-(BOOL)wasAskedToFetchQuestions
{
    return wasAskedToFetchQuestions;
}

@end
