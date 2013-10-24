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

-(void)fetchAnswerForQuestion:(Question *)question
{
    self.questionToFill = question;
    [self.communicator downloadAnswersToQuestionWithID:question.questionID];
}

#pragma mark fetch error
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

-(void)fetchingAnswersFailedWithError:(NSError *)error{
    
    self.questionToFill = nil;
    
    NSDictionary *errorInfo = nil;
    if (error) {
        errorInfo = [NSDictionary dictionaryWithObject:error forKey:NSUnderlyingErrorKey];
    }
    NSError *reportableError = [NSError errorWithDomain:StackOverflowManagerError code:StackOverflowManagerErrorAnswerFetchCode userInfo:errorInfo];
    [self.delegate retrievingAnswersFailedWithError:reportableError];
}


-(void)searchingForQuestionsFailedWithError:(NSError *)error{
    [self tellDelegateAboutQuestionSearchError: error];
}

#pragma mark ReceivedData successful
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

-(void)receivedAnswerListJSON:(NSString *)objectNotation{
    NSError *error = nil;
    
    if([self.answerBuilder addAnswersToQuestion:self.questionToFill fromJSON:objectNotation error:&error])
    {
        [self.delegate answersReceivedForQuestion:self.questionToFill];
        self.questionToFill = nil;
    }
    else
    {
        [self fetchingAnswersFailedWithError:error];
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
