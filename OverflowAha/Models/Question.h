//
//  Question.h
//  OverflowAha
//
//  Created by niko on 13-10-18.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@class Answer;

@interface Question : NSObject
{
    NSMutableSet *answerSet;
}

@property (nonatomic) NSDate *date;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *body;
@property (assign) int score;
@property (readonly) NSArray *answers;
@property (nonatomic) NSInteger questionID;
@property (nonatomic) Person *asker;

-(void)addAnswer:(Answer*)answer;


@end
