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
    BOOL wasAskedToFetchBody;
    NSInteger questionID;

}

-(void)searchForQuestionWithTag:(NSString *)tag
{
    wasAskedToFetchQuestions = YES;
}

-(BOOL)wasAskedToFetchQuestions
{
    return wasAskedToFetchQuestions;
}

-(BOOL)wasAskedToFetchBody{
    return wasAskedToFetchBody;
}

-(void)downloadInformationForQuestionWithID:(NSInteger)indentifier
{
    wasAskedToFetchBody = YES;
}

-(void)downloadAnswersToQuestionWithID:(NSInteger)identifier
{
    questionID = identifier;
}

-(NSInteger)askedForAnswersToQuestionID
{
    return questionID;
}


@end
