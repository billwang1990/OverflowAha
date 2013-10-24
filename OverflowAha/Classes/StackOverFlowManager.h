//
//  StackOverFlowManager.h
//  OverflowAha
//
//  Created by niko on 13-10-21.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowCommunicator.h"
#import "StackOverflowCommunicatorDelegate.h"
#import "StackOverflowManagerDelegate.h"
#import "QuestionBuilder.h"
#import "AnswerBuilder.h"
#import "Topic.h"
#import "Question.h"

extern NSString *StackOverflowManagerError;

enum{
    StackOverFlowManagerErrorQuestionSearchCode,
    StackOverflowManagerErrorQuestionBodyFetchCode,
    StackOverflowManagerErrorAnswerFetchCode
};

@interface StackOverFlowManager : NSObject<StackOverflowCommunicatorDelegate>
{
    NSInteger topicFailureErrorCode;
    NSInteger bodyFailureErrorCode;
    NSInteger answerFailureErrorCode;
}

@property (nonatomic, weak) id<StackOverflowManagerDelegate> delegate;

@property (nonatomic) StackOverflowCommunicator *communicator;
@property (nonatomic) StackOverflowCommunicator *bodyCommunicator;
@property (nonatomic) QuestionBuilder *questionBuilder;
@property (nonatomic) AnswerBuilder  *answerBuilder;
@property (nonatomic) Question *questionNeedingBody;
@property (nonatomic) Question *questionToFill;



-(void)fetchQuestionOnTopic:(Topic*)topic;

-(void)fetchBodyForQuestion:(Question *)question;

-(void)fetchAnswerForQuestion:(Question *)question;

//- (NSInteger)topicFailureErrorCode;


@end
