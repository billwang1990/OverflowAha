//
//  FakeQusetionBuilder.m
//  OverflowAha
//
//  Created by niko on 13-10-21.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "FakeQuestionBuilder.h"
#import "Question.h"

@implementation FakeQuestionBuilder

-(NSArray *)questionsFromJSON:(NSString *)objectNotation error:(NSError **)error
{
    self.JSON = objectNotation;
    if (error) {
        *error = _errorToSet;
    }
    return self.arrayToReturn;
}


@end
