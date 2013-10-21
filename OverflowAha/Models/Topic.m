//
//  Topic.m
//  OverflowAha
//
//  Created by niko on 13-10-18.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "Topic.h"
#import "Question.h"

@implementation Topic

-(id)initWithName:(NSString *)name withTag:(NSString*)tag
{
    if (self = [super init]) {
        _name = [name copy];
        _tag = [tag copy];
        questions = [[NSArray alloc]init];
    }
    return self;
}

-(NSArray *)recentQuestions
{
    return [self sortQuestionLatestFirst:questions];
}

-(void)addQuestion:(Question *)aQuestion
{
    NSArray *newQuestions = [questions arrayByAddingObject:aQuestion];
    
    if (newQuestions.count > 20) {
        
        newQuestions = [self sortQuestionLatestFirst:newQuestions];
        newQuestions = [newQuestions subarrayWithRange:NSMakeRange(0, 20)];
    }
    
    questions = newQuestions;    
}

-(NSArray *)sortQuestionLatestFirst:(NSArray*)questionList
{
    return [questionList sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        Question *q1 = (Question*)obj1;
        Question *q2 = (Question*)obj2;
        return [q2.date compare:q1.date];
    }];
}


@end
