//
//  StackOverflowCommunicatorTest.m
//  OverflowAha
//
//  Created by niko on 13-10-23.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "StackOverflowCommunicatorTest.h"
#import "InspectableStackOverflowCommunicator.h"
#import "NonNetworkedStackOverflowCommunicator.h"
#import "MockStackOverflowManager.h"
#import "FakeURLResponse.h"

@implementation StackOverflowCommunicatorTest
{
    InspectableStackOverflowCommunicator  *communicator;
    NonNetworkedStackOverflowCommunicator *nnCommunicator;
    MockStackOverflowManager *manager;
    FakeURLResponse *fourOhFourResponse;
    NSData *receivedData;   
}

-(void)setUp
{
    communicator = [[InspectableStackOverflowCommunicator alloc]init ];
    nnCommunicator = [[NonNetworkedStackOverflowCommunicator alloc]init];
    manager = [[MockStackOverflowManager alloc]init];
    fourOhFourResponse = [[FakeURLResponse alloc]initWithStatusCode:404];
    
    receivedData = [@"Result" dataUsingEncoding:NSUTF8StringEncoding];
    
    nnCommunicator.delegate = manager;
    
}

-(void)tearDown
{
    [communicator cancelAndDiscardURLConnection];
    communicator = nil;
    nnCommunicator = nil;
    manager = nil;
    fourOhFourResponse = nil;
    receivedData = nil;
}

-(void)testSearchingForQuestionOnTopicCallsTopicAPI
{    
    [communicator searchForQuestionWithTag:@"ios"];
    
    STAssertEqualObjects([[communicator URLToFetch] absoluteString], @"http://api.stackoverflow.com/1.1/search?tagged=ios&pagesize=20", @"use the search API to find questions with particular tag");
}

-(void)testFillingInQuestionBodyCallsQuestionAPI
{
    [communicator downloadInformationForQuestionWithID:12345];
    
    STAssertEqualObjects([[communicator URLToFetch] absoluteString], @"http://api.stackoverflow.com/1.1/questions/12345?body=true", @"use the search API to find questions with particular tag");
}

-(void)testFetchingAnswersToQuestionCallsQustionAPI
{
    [communicator downloadAnswersToQuestionWithID:12345];
    
    STAssertEqualObjects([[communicator URLToFetch] absoluteString], @"http://api.stackoverflow.com/1.1/questions/12345/answers?body=true", @"use the search API to find questions with particular tag");
}

-(void)testSearchingForQuestionsCreatesURLConnection
{
    [communicator searchForQuestionWithTag:@"ios"];
    
    STAssertNotNil([communicator currentURLConnection], @"There should be a URL connection in-flight now");
    
    [communicator cancelAndDiscardURLConnection];
}

-(void)testStartingNewSearchThrowOutOldConnection
{
    [communicator searchForQuestionWithTag:@"ios"];
    NSURLConnection *firstConnection = [communicator currentURLConnection];
    
    [communicator searchForQuestionWithTag:@"cocoa"];
    STAssertFalse([[communicator currentURLConnection] isEqual:firstConnection], @"should not be equal with first connection");

    [communicator cancelAndDiscardURLConnection];
}

-(void)testRecevingResponseDisCardsExistingData
{
    nnCommunicator.receivedData = [@"Hello" dataUsingEncoding:NSUTF8StringEncoding];
    
    [nnCommunicator searchForQuestionWithTag:@"ios"];
    [nnCommunicator connection:nil didReceiveResponse:nil];
    
    STAssertEquals([nnCommunicator.receivedData length], (NSUInteger)0, @"Data should have been discard");
}

-(void)testRecvingResponseWith404StatusPassesErrorToDelegate
{
    [nnCommunicator searchForQuestionWithTag:@"ios"];
    [nnCommunicator connection:nil didReceiveResponse:(NSURLResponse*)fourOhFourResponse];
    
    STAssertEquals([manager topicFailureErrorCode], 404, @"manager fetch topic error code should equal with 404");
}

-(void)testNoErrorReceivedOn200Status
{
    FakeURLResponse *twoHundredResponse = [[FakeURLResponse alloc]initWithStatusCode:200];
    
    [nnCommunicator searchForQuestionWithTag:@"ios"];
    [nnCommunicator connection:nil didReceiveResponse:(NSURLResponse*)twoHundredResponse];
    
    STAssertFalse([manager topicFailureErrorCode] == 200, @"No need for error on 200 response");
}

-(void)testReceiving404ResponseToQuestionBodyRequestPassesErrorToDelegate
{
    [nnCommunicator downloadInformationForQuestionWithID:12345];
    [nnCommunicator connection:nil didReceiveResponse:(NSURLResponse*)fourOhFourResponse];
    
    STAssertEquals([manager bodyFailureErrorCode], 404, @"Body fetch error was passed through to delegate");
}

-(void)testReceiving404ResponseToAnswerRequestPassesErrorToDelegate
{
    [nnCommunicator downloadAnswersToQuestionWithID:12345];
    [nnCommunicator connection:nil didReceiveResponse:(NSURLResponse*)fourOhFourResponse];
    
    STAssertEquals([manager answerFailureErrorCode], 404, @"Answer fetch error was passed through to delegate");
}

-(void)testConnectionFailingPassesErrorToDelegate
{
    [nnCommunicator searchForQuestionWithTag:@"ios"];
    NSError *error = [NSError errorWithDomain:@"Fake domain" code:12345 userInfo:nil];
    [nnCommunicator connection:nil didFailWithError:error];
    
    STAssertEquals([manager topicFailureErrorCode], 12345, @"failure to connect should get passed to the delegate");
}

-(void)testSuccessfulQuestionSearchPassesDataToDelegate
{
    [nnCommunicator searchForQuestionWithTag:@"ios"];
    [nnCommunicator setReceivedData:receivedData];
    [nnCommunicator connectionDidFinishLoading:nil];
    STAssertEqualObjects([manager topicSearchString], @"Result", @"The delegate should have ");
}

-(void)testSuccessfulBodyFetchPassesDataToDelegate
{
    [nnCommunicator downloadInformationForQuestionWithID:12345];
    [nnCommunicator setReceivedData:receivedData];
    [nnCommunicator connectionDidFinishLoading:nil];
    
    STAssertEqualObjects([manager questionBodyString], @"Result", @"The delegate should have received the question body data");
}

-(void)testSuccessfulAnswerFetchPassesDataToDelegate
{
    [nnCommunicator downloadAnswersToQuestionWithID:12345];
    [nnCommunicator setReceivedData:receivedData];
    [nnCommunicator connectionDidFinishLoading:nil];
    
    STAssertEqualObjects([manager answerListString], @"Result", @"Answer list should be passed to the delegate");
}

-(void)testAdditionalDataAppendedToDownload
{
    [nnCommunicator setReceivedData:receivedData];
    
    NSData *extraData = [@" appended" dataUsingEncoding:NSUTF8StringEncoding];
    [nnCommunicator connection:nil didReceiveData:extraData];
    
    NSString *combinedString = [[NSString alloc]initWithData:[nnCommunicator receivedData] encoding:NSUTF8StringEncoding];
    
    STAssertEqualObjects(combinedString, @"Result appended", @"Received data should be appended to the downlaod data");
}


@end
