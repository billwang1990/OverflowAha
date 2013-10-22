//
//  QuestionCreationTest.m
//  OverflowAha
//
//  Created by niko on 13-10-21.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "QuestionCreationWorkflowTest.h"
#import "MockStackOverflowCommunicator.h"
#import "StackOverFlowManager.h"
#import "MockStackOverflowManagerDelegate.h"
#import "Question.h"
#import "FakeQuestionBuilder.h"

@implementation QuestionCreationWorkflowTest
{
    @private
    StackOverFlowManager *mgr;
    MockStackOverflowManagerDelegate *delegate;
    FakeQuestionBuilder *builder;
    NSError *underlyingError;
    NSArray *questionArray;
    
    Question *questionToFetch;
    MockStackOverflowCommunicator *communicator;
    MockStackOverflowCommunicator *bodyCommunicator;
    
}

-(void)setUp
{
    mgr = [[StackOverFlowManager alloc]init];
    delegate = [[MockStackOverflowManagerDelegate alloc]init];
    mgr.delegate = delegate;
    underlyingError = [NSError errorWithDomain:@"Test Domain" code:0 userInfo:nil];
        
    builder = [[FakeQuestionBuilder alloc]init];
    
    mgr.questionBuilder = builder;
    
    
    questionToFetch = [[Question alloc]init];
    questionToFetch.questionID = 1234;
    
    questionArray = [NSArray arrayWithObject:questionToFetch];

    communicator = [[MockStackOverflowCommunicator alloc]init];
    mgr.communicator = communicator;
    
    bodyCommunicator = [[MockStackOverflowCommunicator alloc]init];
    mgr.bodyCommunicator = bodyCommunicator;
}

-(void)tearDown
{
    mgr = nil;
    delegate = nil;
    underlyingError = nil;
    questionArray = nil;
    builder = nil;
    
    questionToFetch = nil;
    communicator = nil;
    
}

-(void)testNonConformingObjectCannnotBeDelegate
{
    STAssertThrows(mgr.delegate = (id<StackOverflowManagerDelegate>)[NSNull null], @"delegate不应该是null");
}

-(void)testManagerAcceptsNilAsADelegate
{
    STAssertNoThrow(mgr.delegate = nil, @"应该允许接受nil为delegate");
}

-(void)testConformingObjectCanBeDelegate
{
    STAssertNoThrow(mgr.delegate = delegate, @"manager的代理应该是遵守协议类型的对象");
}

-(void)testErrorReturnedToDelegateIsNotNotifiedByCommunicator
{
    [mgr searchingForQuestionFailedWithError: underlyingError];
    
    STAssertFalse(underlyingError == [delegate fetchError], @"Error should be at the correct level of abstraction");
}

-(void)testErrorReturnedToDelegateDocumentsUnderlyingError
{   
    [mgr searchingForQuestionFailedWithError: underlyingError];

    STAssertEqualObjects([[[delegate fetchError] userInfo] objectForKey: NSUnderlyingErrorKey], underlyingError, @"the underlying error should be available to client code");
}

-(void)testQuestionJSONIsPassedToQuestionBuilder
{    
    [mgr receivedQuestionsJSON: @"Fake JSON"];
    
    STAssertEqualObjects(builder.JSON, @"Fake JSON", @"Downloaded JSON is sent to the builder");
    
    mgr.questionBuilder = nil;
}

-(void)testDelegateNotifiedOfErrorWhenQuestionBuilderFails
{
    builder.arrayToReturn = nil;
    builder.errorToSet = underlyingError;
    
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    
    STAssertNotNil([[[delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey], @"The delegate should have found out about the error");
    
    mgr.delegate = nil;
       
}

-(void)testDelegateNotToldAboutErrorWhenQuestionsReceived
{
    builder.arrayToReturn = questionArray;
    builder.errorToSet = underlyingError;
    
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    
    STAssertNil([delegate fetchError], @"no error");
    
    mgr.delegate = nil;
}

-(void)testDelegateReceivesTheQuestionsDiscoveredByManager
{
    builder.arrayToReturn = questionArray;
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    
    STAssertEqualObjects([delegate receicedQuestions], questionArray, @"The manager shluld have sent its questions to the delegate");
}

-(void)testEmptyArrayIsPassedToDelegate
{
    builder.arrayToReturn = [NSArray array];
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    
    STAssertEqualObjects([delegate receicedQuestions], [NSArray array], @"The manager shluld have sent its questions to the delegate");
}

-(void)testAskingForQuestionBodyMeansRequestingData
{
    [mgr fetchBodyForQuestion:questionToFetch];
    
    STAssertTrue([bodyCommunicator wasAskedToFetchBody], @"The communicator should need to retrieve data for the question body");
}

-(void)testDelegateNotifiedOfFailureToFetchQuestion
{
    [mgr fetchingQuestionBodyFailedWithError:underlyingError];
    
    STAssertNotNil([[[delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey], @"delegate should have found out about this error");
    
}

-(void)testManagerPassesRetrievedQuestionBodyToQuestionBuilder
{
    [mgr receivedQuestionBodyJSON:@"Fake JSON"];
    
    STAssertEqualObjects(builder.JSON, @"Fake JSON", @"Successfully-retrieved data should be passed to the builder");
}

-(void)testManagerPassesQuestionItWasSentToQuestionBuilderForFillingIn
{
    [mgr fetchBodyForQuestion:questionToFetch];
    [mgr receivedQuestionBodyJSON: @"Fake JSON"];
    
    STAssertEqualObjects(builder.questionToFill, questionToFetch, @"The question should have been passe to the builder");
}





@end
