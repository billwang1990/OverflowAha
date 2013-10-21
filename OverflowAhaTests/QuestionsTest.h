//
//  QuestionsTest.h
//  OverflowAha
//
//  Created by niko on 13-10-18.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "Question.h"
#import "Answer.h"

@interface QuestionsTest : SenTestCase
{
    Question *question;
    Answer *lowScore;
    Answer *highScore;
}
@end
