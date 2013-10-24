//
//  AnswerCreationWorkflowTest.m
//  OverflowAha
//
//  Created by niko on 13-10-23.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "AnswerCreationWorkflowTest.h"
#import "StackOverFlowManager.h"
#import "MockStackOverflowCommunicator.h"
#import "MockStackOverflowManagerDelegate.h"
#import "FakeAnswerBuilder.h"

@implementation AnswerCreationWorkflowTest

-(void)setUp
{
    manager = [[StackOverFlowManager alloc]init];
    
    communicator = [[MockStackOverflowCommunicator alloc]init];
    manager.communicator = communicator;
    
    delegate = [[MockStackOverflowManagerDelegate alloc]init];
    manager.delegate = delegate;
    
    answerBuilder = [[FakeAnswerBuilder alloc]init];
    manager.answerBuilder = answerBuilder;
    
    question = [[Question alloc]init];
    question.questionID = 12345;

    error = [NSError errorWithDomain:@"Fake Domain" code:42 userInfo:nil];
    
}

-(void)tearDown
{
    manager = nil;
    communicator = nil;
    delegate = nil;
    answerBuilder = nil;
    question = nil;
    error = nil;
}


-(void)testAskingForAnswersMeansCommunicationWithSite
{
    [manager fetchAnswerForQuestion:question];
    
    STAssertEquals(question.questionID, [communicator askedForAnswersToQuestionID], @"Answers to questions are found by communicating with the web site");
}

-(void)testDelegateNotifiedOfFailureToGetAnswers
{
    [manager fetchingAnswersFailedWithError:error];
    
    STAssertEqualObjects([[[delegate fetchError] userInfo] objectForKey: NSUnderlyingErrorKey], error, @"Delegate should be notified of failure to communicate");

}

-(void)testManagerRemembersWhichQuestionToAddAnswersTo
{
    [manager fetchAnswerForQuestion:question];
    STAssertEqualObjects(manager.questionToFill, question, @"Manager should know to fill this question in");
}

-(void)testAnswerResponsePassedToAnswerBuilder
{
    [manager receivedAnswerListJSON:@"Fake JSON"];
    
    STAssertEqualObjects([answerBuilder receivedJSON], @"Fake JSON", @"Manager must pass response to builder to get answers constructed");
}

-(void)testQuestionPassedToAnswerBuilder
{
    manager.questionToFill = question;
    [manager receivedAnswerListJSON:@"Fake JSON"];
    
    STAssertEqualObjects(answerBuilder.questionToFill, question, @"Manager must pass question to answer builder");
}

-(void)testManagerNotifiesDelegateWhenAnswersAdded
{
    answerBuilder.successful = YES;
    manager.questionToFill = question;
    
    [manager receivedAnswerListJSON:@"Fake JSON"];
    
    STAssertEqualObjects(delegate.successQuestion, question, @"Manager should call the delegate method");
}

-(void)testManagerNotifiesDelegateWhenAnswersNotAdded
{
    answerBuilder.successful = NO;
    answerBuilder.error = error;
    
    [manager receivedAnswerListJSON:@"Fake JSON"];
    
    STAssertEqualObjects([[delegate.fetchError userInfo] objectForKey:NSUnderlyingErrorKey], error, @"Manager should pass an error on to the delegate");
}


@end
