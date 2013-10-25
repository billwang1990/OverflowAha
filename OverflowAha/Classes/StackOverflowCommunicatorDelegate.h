//
//  StackOverflowCommunicatorDelegate.h
//  OverflowAha
//
//  Created by niko on 13-10-22.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StackOverflowCommunicatorDelegate <NSObject>

/**
 * Signal from the communicator that it couldn't retrieve a question body.
 */
- (void)fetchingQuestionBodyFailedWithError: (NSError *)error;

/**
 *Signal from the communicator that it couldn't retrieve a answer for a question
 */
-(void)fetchingAnswersFailedWithError:(NSError*)error;

/**
 * Signal frome the communicator that it couldn't retrieve questions list
 */
-(void)searchingForQuestionsFailedWithError:(NSError*)error;

/**
 * receive answer list JSON data successful
 */
-(void)receivedAnswerListJSON:(NSString*)objectNotation;

/**
 * receive question JSON data successful
 */
-(void)receivedQuestionsJSON:(NSString*)objectNotation;

/**
 * receive question body JSON data successful
 */
- (void)receivedQuestionBodyJSON:(NSString *)objectNotation;

@end
