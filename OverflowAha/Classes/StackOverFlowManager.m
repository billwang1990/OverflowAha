//
//  StackOverFlowManager.m
//  OverflowAha
//
//  Created by niko on 13-10-21.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "StackOverFlowManager.h"

NSString *StackOverflowManagerError = @"StackOverflowManagerError";

@implementation StackOverFlowManager

-(void)setDelegate:(id<StackOverflowManagerDelegate>)delegate
{
    if (delegate && ![delegate conformsToProtocol:@protocol(StackOverflowManagerDelegate) ]) {
        [[NSException exceptionWithName:NSInvalidArgumentException reason:@"delegate object not conform to the delegate protocol" userInfo:nil] raise];
    }
    
    _delegate = delegate;
    
}

-(void)fetchQuestionOnTopic:(Topic *)topic
{
    [self.communicator searchForQuestionWithTag:[topic tag]];
}

-(void)fetchBodyForQuestion:(Question *)question{
    
    self.questionNeedingBody = question;
    [self.bodyCommunicator downloadInformationForQuestionWithID:question.questionID];
}

-(void)searchingForQuestionFailedWithError:(NSError *)error
{
    [self tellDelegateAboutQuestionSearchError:error];
}

-(void)fetchingQuestionBodyFailedWithError:(NSError *)error
{
    NSDictionary *errorInfo = nil;
    if (error) {
        errorInfo = [NSDictionary dictionaryWithObject: error forKey: NSUnderlyingErrorKey];
    }
    NSError *reportableError = [NSError errorWithDomain: StackOverflowManagerError code: StackOverflowManagerErrorQuestionBodyFetchCode userInfo:errorInfo];
    [self.delegate fetchingQuestionBodyFailedWithError: reportableError];
    self.questionNeedingBody = nil;
    
}

-(void)receivedQuestionsJSON:(NSString *)objectNotation
{
    NSError *error = nil;
    NSArray *questions = [self.questionBuilder questionsFromJSON:objectNotation error:&error];
    
    if (!questions) {
        
        [self tellDelegateAboutQuestionSearchError:error];
      }
    else
    {
        [_delegate didReceiveQuestions:questions];
    }
}

-(void)receivedQuestionBodyJSON:(NSString *)objectNotation
{
    [self.questionBuilder fillInDetailsForQuestion:self.questionNeedingBody fromJSON: objectNotation];
    [self.delegate bodyReceivedForQuestion: self.questionNeedingBody];
    self.questionNeedingBody = nil;
}

-(void)tellDelegateAboutQuestionSearchError:(NSError*)error
{
       NSDictionary *errorInfo = nil;
    if (error) {
        errorInfo = [NSDictionary dictionaryWithObject:error forKey:NSUnderlyingErrorKey];
    }
    
    NSError *reportableError = [NSError errorWithDomain:StackOverflowManagerError code:StackOverFlowManagerErrorQuestionSearchCode userInfo:errorInfo];
    [_delegate fetchingQuestionsFailedWithError:reportableError];

}

@end
