//
//  Question.h
//  OverflowAha
//
//  Created by niko on 13-10-18.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Answer;

@interface Question : NSObject
{
    NSMutableSet *answerSet;
}

@property (nonatomic) NSDate *date;
@property (nonatomic) NSString *title;
@property (assign) int score;
@property (readonly) NSArray *answers;

-(void)addAnswer:(Answer*)answer;


@end
