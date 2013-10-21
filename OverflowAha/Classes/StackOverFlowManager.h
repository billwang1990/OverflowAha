//
//  StackOverFlowManager.h
//  OverflowAha
//
//  Created by niko on 13-10-21.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowCommunicator.h"
#import "QuestionBuilder.h"
#import "Topic.h"

extern NSString *StackOverflowManagerError;

enum{
    StackOverFlowManagerErrorQuestionSearchCode
};

@protocol StackOverFlowManagerDelegate <NSObject>

-(void)fetchingQuestionsFailedWithError: (NSError*)error;
- (void)didReceiveQuestions:(NSArray *)questions ;
@end


@interface StackOverFlowManager : NSObject

@property (nonatomic, weak) id<StackOverFlowManagerDelegate> delegate;
@property (nonatomic) StackOverflowCommunicator *communicator;
@property (nonatomic) QuestionBuilder *questionBuilder;



-(void)fetchQuestionOnTopic:(Topic*)topic;

-(void)searchingForQuestionFailedWithError:(NSError*)error;

-(void)receivedQuestionsJSON:(NSString*)objectNotation;

@end
