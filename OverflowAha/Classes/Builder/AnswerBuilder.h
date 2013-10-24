//
//  AnswerBuilder.h
//  OverflowAha
//
//  Created by niko on 13-10-23.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  Question;

extern NSString *AnswerBuilderErrorDomain;

enum {
    AnswerBuilderErrorInvalidJSONError,
    AnswerBuilderErrorMissingDataError,
};


@interface AnswerBuilder : NSObject

- (BOOL)addAnswersToQuestion: (Question *)question fromJSON: (NSString *)objectNotation error: (NSError **)error;

@end
