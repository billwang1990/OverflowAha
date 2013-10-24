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

-(void)fetchingAnswersFailedWithError:(NSError*)error;

-(void)searchingForQuestionsFailedWithError:(NSError*)error;

-(void)receivedAnswerListJSON:(NSString*)objectNotation;

-(void)receivedQuestionsJSON:(NSString*)objectNotation;

- (void)receivedQuestionBodyJSON:(NSString *)objectNotation;

@end
