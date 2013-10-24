//
//  FakeAnswerBuilder.m
//  OverflowAha
//
//  Created by niko on 13-10-23.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "FakeAnswerBuilder.h"

@implementation FakeAnswerBuilder

- (BOOL)addAnswersToQuestion: (Question *)question fromJSON: (NSString *)objectNotation error: (NSError **)addError {
    self.questionToFill = question;
    self.receivedJSON = objectNotation;
    
    if (addError) {
        *addError = _error;
    }
    return _successful;
}

@end
