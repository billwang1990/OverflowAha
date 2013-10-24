//
//  StackOverflowManagerDelegate.h
//  OverflowAha
//
//  Created by niko on 13-10-22.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Question;

@protocol StackOverflowManagerDelegate <NSObject>

-(void)fetchingQuestionsFailedWithError: (NSError*)error;

-(void)fetchingQuestionBodyFailedWithError:(NSError*)error;

- (void)retrievingAnswersFailedWithError: (NSError *)error;

- (void)didReceiveQuestions:(NSArray *)questions;

/**
 * The manager got the body of a question.
 */
- (void)bodyReceivedForQuestion: (Question *)question;

- (void)answersReceivedForQuestion: (Question *)question;


@end
