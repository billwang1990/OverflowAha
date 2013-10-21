//
//  AnswerTest.m
//  OverflowAha
//
//  Created by niko on 13-10-19.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "AnswerTest.h"
#import "Answer.h"
#import "Person.h"


@implementation AnswerTest

-(void)setUp
{
    answer = [[Answer alloc]init];
    answer.text = @"this is a test";
    answer.person = [[Person alloc] initWithName:@"billwang" andAvatarUrlStr:@"www"];
    answer.score = 42;
    
    otherAnswer = [[Answer alloc]init];
    otherAnswer.text = @"answer you need";
    otherAnswer.score = 42;
    
}

-(void)tearDown
{
    answer = nil;
}

-(void)testAnswerText
{
    STAssertEqualObjects(answer.text, @"this is a test", @"answer'text is not equal with gave text");
}

-(void)testAnswerProvidePerson
{
    STAssertTrue([answer.person isKindOfClass: [Person class]], @"A person gave this answer");
}

-(void)testAnswerScore
{
    STAssertEquals(answer.score, 42, @"answer's score should equal with 12");
}

-(void)testAnswerNotAcceptedByDefault
{
    STAssertFalse(answer.accepted, @"answer not accepted by default");
}

-(void)testAnswerCanByAccepted
{
    answer.accepted = YES;
    STAssertTrue(answer.accepted, @"answer can be accepted");
}

-(void)testAcceptedAnswerComesBeforeUnAccepted
{
    otherAnswer.accepted = YES;
    otherAnswer.score = answer.score + 10;
    STAssertEquals([answer compare:otherAnswer], NSOrderedDescending, @"Accpeted answer should come first");
    
    STAssertEquals([otherAnswer compare:answer], NSOrderedAscending, @"Accpeted answer should come first");
}

-(void)testAnswerWithEqualScoreCompareEqually
{
    STAssertEquals([answer compare:otherAnswer], NSOrderedSame, @"排序应该相等");
    
    STAssertEquals([otherAnswer compare:answer], NSOrderedSame, @"排序应该相等");
}

-(void)testLowerScoringAnswerComesAfterHigher
{
    otherAnswer.score = answer.score + 10;
    
    STAssertEquals([answer compare:otherAnswer], NSOrderedDescending, @"Accpeted answer should come first");
    
    STAssertEquals([otherAnswer compare:answer], NSOrderedAscending, @"Accpeted answer should come first");
}




@end
