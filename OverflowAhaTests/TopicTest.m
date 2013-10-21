//
//  TopicTest.m
//  OverflowAha
//
//  Created by niko on 13-10-18.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "TopicTest.h"
#import "Topic.h"
#import "Question.h"

@implementation TopicTest

-(void)setUp
{
    topic = [[Topic alloc]initWithName:@"IOS Dev" withTag: @"IOS"];
    
}

-(void)tearDown
{
    topic = nil;
}

-(void)testThatTopicExists
{
    STAssertNotNil(topic, @"创建实例失败");
    STAssertEqualObjects([topic class], [Topic class], @"topic 应该是Topic的实例");
}

-(void)testTopicCanBeNamed
{
    STAssertEqualObjects(topic.name, @"IOS Dev", @"topic的名字应该与初始化给定参数一致");
}

-(void)testTopicCanHasTag
{
    STAssertEqualObjects(topic.tag, @"IOS", @"topic的标签应该与创建时候一致");
}

-(void)testForAListOfQuestions
{
    STAssertTrue([[topic recentQuestions]isKindOfClass :[NSArray class] ], @"topic 应该包含一个最近提问的列表");
}

-(void)testForInitiallyEmptyQuestionList
{
    STAssertEquals([[topic recentQuestions]count], (NSUInteger)0, @"topic的提问列表应该是空的");
}

-(void)testAddingAQuestionToTheList
{
    Question *question = [[Question alloc]init];
    [topic addQuestion:question];
    
    STAssertEquals([[topic recentQuestions]count], (NSUInteger)1, @"topic的提问列表数应该是1");
}

-(void)testQuestionListOrder
{
    Question *q1 = [[Question alloc]init];
    q1.date = [NSDate distantPast];
    
    Question *q2 = [[Question alloc]init];
    q2.date = [NSDate distantFuture];
    
    [topic addQuestion:q1];
    [topic addQuestion:q2];
    
    NSArray *questionList = [topic recentQuestions];
    Question *listFirst = [questionList objectAtIndex:0];
    Question *listSecond = [questionList objectAtIndex:1];
    
    STAssertEqualObjects([listFirst.date laterDate:listSecond.date], listFirst.date, @"最新的提问应该在前面");
    
}

@end
