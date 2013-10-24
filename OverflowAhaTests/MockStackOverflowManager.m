//
//  MockStackOverflowManager.m
//  OverflowAha
//
//  Created by niko on 13-10-23.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "MockStackOverflowManager.h"

@implementation MockStackOverflowManager

- (void)searchingForQuestionsFailedWithError: (NSError *)error {
    topicFailureErrorCode = [error code];
}

-(void)fetchingQuestionBodyFailedWithError:(NSError *)error{
    bodyFailureErrorCode = [error code];
}

-(void)fetchingAnswersFailedWithError:(NSError *)error
{
    answerFailureErrorCode = [error code];
}

- (NSInteger)topicFailureErrorCode {
    return topicFailureErrorCode;
}

-(NSInteger)bodyFailureErrorCode{
    return bodyFailureErrorCode;
}

-(NSInteger)answerFailureErrorCode
{
    return answerFailureErrorCode;
}

-(void)receivedQuestionsJSON:(NSString *)objectNotation{
    topicSearchStr = objectNotation;
}

-(void)receivedQuestionBodyJSON:(NSString *)objectNotation
{
    questionBodyStr = objectNotation;
}

-(void)receivedAnswerListJSON:(NSString *)objectNotation
{
    answerListStr = objectNotation;
}

-(NSString *)topicSearchString
{
    return topicSearchStr;
}

-(NSString *)questionBodyString
{
    return questionBodyStr;
}

-(NSString *)answerListString{
    return answerListStr;
}


@end
