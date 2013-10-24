//
//  FakeAnswerBuilder.h
//  OverflowAha
//
//  Created by niko on 13-10-23.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "AnswerBuilder.h"

@interface FakeAnswerBuilder : AnswerBuilder


@property (retain) NSString *receivedJSON;
@property (retain) Question *questionToFill;
@property (retain) NSError *error;
@property BOOL successful;

@end

