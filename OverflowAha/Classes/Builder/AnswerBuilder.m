//
//  AnswerBuilder.m
//  OverflowAha
//
//  Created by niko on 13-10-23.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "AnswerBuilder.h"
#import "Question.h"
#import "UserBuilder.h"
#import "Answer.h"


@implementation AnswerBuilder

-(BOOL)addAnswersToQuestion:(Question *)question fromJSON:(NSString *)objectNotation error:(NSError *__autoreleasing *)error
{
    NSParameterAssert(objectNotation);
    NSParameterAssert(question);
    
    NSData *unicodeNotation = [objectNotation dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *localError;
    
    NSDictionary *answerData = [NSJSONSerialization JSONObjectWithData:unicodeNotation options:NSJSONReadingAllowFragments error:&localError];
    
    if (!answerData) {
        if (error) {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:1];
            if (!localError) {
                [userInfo setObject:localError forKey:NSUnderlyingErrorKey];
            }
            *error = [NSError errorWithDomain:AnswerBuilderErrorDomain code:AnswerBuilderErrorInvalidJSONError userInfo:userInfo ];
        }
        return NO;
    }
    NSArray *answers = [answerData objectForKey: @"answers"];
    
    if (answers == nil) {
        if (error) {
            *error = [NSError errorWithDomain: AnswerBuilderErrorDomain code:AnswerBuilderErrorMissingDataError userInfo: nil];
        }
        return NO;
    }
    
    for (NSDictionary *answerData in answers) {
        Answer *thisAnswer = [[Answer alloc] init];
        thisAnswer.text = [answerData objectForKey: @"body"];
        thisAnswer.accepted = [[answerData objectForKey: @"accepted"] boolValue];
        thisAnswer.score = [[answerData objectForKey: @"score"] integerValue];
        NSDictionary *ownerData = [answerData objectForKey: @"owner"];
        thisAnswer.person = [UserBuilder personFromDictionary: ownerData];
        [question addAnswer: thisAnswer];
    }
    return YES;
}


NSString *AnswerBuilderErrorDomain = @"AnswerBuilderErrorDomain";

@end
