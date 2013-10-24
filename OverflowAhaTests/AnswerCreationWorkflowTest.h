//
//  AnswerCreationWorkflowTest.h
//  OverflowAha
//
//  Created by niko on 13-10-23.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@class StackOverFlowManager;
@class Question;
@class MockStackOverflowCommunicator;
@class MockStackOverflowManagerDelegate;
@class FakeAnswerBuilder;

@interface AnswerCreationWorkflowTest : SenTestCase
{
    StackOverFlowManager *manager;
    MockStackOverflowCommunicator *communicator;
    Question *question;
    MockStackOverflowManagerDelegate *delegate;
    FakeAnswerBuilder *answerBuilder;
    NSError *error;
    
}


@end
