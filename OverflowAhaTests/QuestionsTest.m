//
//  QuestionsTest.m
//  OverflowAha
//
//  Created by niko on 13-10-18.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "QuestionsTest.h"

@implementation QuestionsTest

-(void)setUp
{
    question = [[Question alloc]init];
    
    Answer *accpeted = [[Answer alloc]init];
    accpeted.score = 1;
    accpeted.accepted = YES;
    [question addAnswer: accpeted];
    
    lowScore = [[Answer alloc]init];
    lowScore.score = -4;
    [question addAnswer: lowScore];
    
    highScore = [[Answer alloc]init];
    highScore.score = 4;
    [question addAnswer: highScore];
    
    asker = [[Person alloc]initWithName:@"billwang" andAvatarUrlStr:@"www.baidu.com"];
    question.asker = asker;
}

-(void)tearDown
{
    question = nil;
    lowScore = nil;
    highScore = nil;
}

-(void)testQuestionHasDate
{
    NSDate *testDate = [NSDate distantPast];
    
    question.date = testDate;
    
    STAssertTrue([question.date isKindOfClass: [NSDate class]], @"question 应该有date属性");
    STAssertEqualObjects(question.date, testDate, @"question.date 应该等于 testdate");
}

-(void)testQuestionTitle
{
    question.title = @"Ios 7 is very nice";
    STAssertEqualObjects(question.title, @"Ios 7 is very nice", @"question的title应该和给定文字相等");
    
    question.title = @"BillWang1990";
    STAssertEqualObjects(question.title, @"BillWang1990", @"question的title应该和给定文字相等");
    
}

-(void)testQuestionKeepScore
{
    question.score = 45;
    STAssertEquals(question.score, 45, @"question's score 应该等于45");
    
    question.score = 42;
    STAssertEquals(question.score, 42, @"question's score 应该等于42");

}

-(void)testQuestionCanAddAnswer
{
    Answer *answer = [[Answer alloc]init];
    STAssertNoThrow([question addAnswer: answer], @"question 应该可以添加回答");
}

-(void)testAcceptedAnswerIsFirst
{
    STAssertTrue([[question.answers objectAtIndex:0] isAccepted],@"Accepted answer should list at first" );
}

-(void)testHighScoreAnswerBeforeLow
{
    NSArray *answers = question.answers;
    NSInteger highIndex = [answers indexOfObject:highScore];
    NSInteger lowIndex = [answers indexOfObject:lowScore];
    
    STAssertTrue(highIndex < lowIndex, @"高分应该在前面");
    
}

-(void)testQuestionWasAskedBySomeOne
{
    STAssertEqualObjects(question.asker, asker, @"question asker should equal with asker");
}


@end
