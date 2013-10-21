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

-(void)setDelegate:(id<StackOverFlowManagerDelegate>)delegate
{
    if (delegate && ![delegate conformsToProtocol:@protocol(StackOverFlowManagerDelegate) ]) {
        [[NSException exceptionWithName:NSInvalidArgumentException reason:@"delegate object not conform to the delegate protocol" userInfo:nil] raise];
    }
    
    _delegate = delegate;
    
}

-(void)fetchQuestionOnTopic:(Topic *)topic
{
    [self.communicator searchForQuestionWithTag:[topic tag]];
}

-(void)searchingForQuestionFailedWithError:(NSError *)error
{
    [self tellDelegateAboutQuestionSearchError:error];
    
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
