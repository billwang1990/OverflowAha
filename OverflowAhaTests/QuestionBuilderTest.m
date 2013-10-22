//
//  QuestionBuilderTest.m
//  OverflowAha
//
//  Created by niko on 13-10-22.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "QuestionBuilderTest.h"
#import "Question.h"
#import "Person.h"
#import "QuestionBuilder.h"

static NSString *questionJSON = @"{"
@"\"total\": 1,"
@"\"page\": 1,"
@"\"pagesize\": 30,"
@"\"questions\": ["
@"{"
@"\"tags\": ["
@"\"iphone\","
@"\"security\","
@"\"keychain\""
@"],"
@"\"answer_count\": 1,"
@"\"accepted_answer_id\": 3231900,"
@"\"favorite_count\": 1,"
@"\"question_timeline_url\": \"/questions/2817980/timeline\","
@"\"question_comments_url\": \"/questions/2817980/comments\","
@"\"question_answers_url\": \"/questions/2817980/answers\","
@"\"question_id\": 2817980,"
@"\"owner\": {"
@"\"user_id\": 23743,"
@"\"user_type\": \"registered\","
@"\"display_name\": \"Graham Lee\","
@"\"reputation\": 13459,"
@"\"email_hash\": \"563290c0c1b776a315b36e863b388a0c\""
@"},"
@"\"creation_date\": 1273660706,"
@"\"last_activity_date\": 1278965736,"
@"\"up_vote_count\": 2,"
@"\"down_vote_count\": 0,"
@"\"view_count\": 465,"
@"\"score\": 2,"
@"\"community_owned\": false,"
@"\"title\": \"Why does Keychain Services return the wrong keychain content?\","
@"\"body\": \"<p>I've been trying to use persistent keychain references.</p>\""
@"}"
@"]"
@"}";

@implementation QuestionBuilderTest
{
    QuestionBuilder *questionBuilder;
    Question *question;
}


-(void)setUp
{
    questionBuilder = [[QuestionBuilder alloc]init];
    question = [[questionBuilder questionsFromJSON:questionJSON error:NULL] objectAtIndex:0];
}

-(void)tearDown
{
    questionBuilder = nil;
    question = nil;
}

-(void)testThatNilIsNotAnAcceptableParameter
{
    STAssertThrows([questionBuilder questionsFromJSON:nil error:NULL], @"Lack of data should have been handled elsewhere");
}

-(void)testNilReturnedWhenStringIsNotJSON
{
    STAssertNil([questionBuilder questionsFromJSON:@"Not JSON" error:NULL], @"invalid parameter");
}

-(void)testErrorSetWhenStringIsNotJSON
{
    NSError *error = nil;
    [questionBuilder questionsFromJSON:@"Not JSON" error:&error];
    STAssertNotNil(error, @"An error occurred, we should be told");
}

-(void)testPassingNullErrorDoesNotCauseCrash
{
    STAssertNoThrow([questionBuilder questionsFromJSON:@"Not JSON" error:NULL], @"Use a NULL parameter should not be a problem");
}

-(void)testRealJSONWithoutQuestionsArrayIsError
{
    NSString *jsonString = @"{\"noquestions\": true}";

    STAssertNil([questionBuilder questionsFromJSON:jsonString error:NULL], @"No questions to parse in this JSON");
}

-(void)testRealJSONWithoutQuestionsReturnsMissingDataError
{
    NSString *jsonString = @"{\"noquestions\": true}";

    NSError *error = nil;
    
    [questionBuilder questionsFromJSON:jsonString error:&error];
    
    STAssertEquals([error code], QuestionBuilderMissingDataError, @"should be a missing data error");

}

-(void)testJSONWithOneQuestionReturnsOneQuestionObject
{
    NSError *error = nil;
    
    NSArray *questions = [questionBuilder questionsFromJSON:questionJSON error:&error];
    
    STAssertEquals([questions count], (NSUInteger)1, @"should create one question object");

}

-(void)testQuestionCreatedFromJSONHasPropertiesPresentedInJSON
{
    STAssertEquals(question.questionID, 2817980, @"question id should match the data we sent");
    
    STAssertEquals([question.date timeIntervalSince1970], (NSTimeInterval)1273660706, @"date should match");
    
    STAssertEqualObjects(question.title, @"Why does Keychain Services return the wrong keychain content?", @"title should match");
    
    STAssertEquals(question.score, 2, @"score should match");
    
    Person *asker = question.asker;
    
    STAssertEqualObjects(asker.name, @"Graham Lee", @"name should match");
    
    STAssertEqualObjects(asker.avatarUrlStr, @"http://www.gravatar.com/avatar/563290c0c1b776a315b36e863b388a0c", @"the avatar url string should match we sent");
    
}

-(void)testQuestionCreatedFromEmptyObjectIsStillValidObject
{
    NSString *emptyQuestion = @"{\"questions\":[{} ]}";
    
    NSArray *questions = [questionBuilder questionsFromJSON:emptyQuestion error:NULL];
    
    STAssertEquals([questions count], (NSUInteger)1, @"questionBuilder must handle partial input");
    
}



@end
