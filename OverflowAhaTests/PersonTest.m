//
//  PersonTest.m
//  OverflowAha
//
//  Created by niko on 13-10-19.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "PersonTest.h"
#import "Person.h"

@implementation PersonTest

-(void)setUp
{
    person = [[Person alloc]initWithName:@"billwang" andAvatarUrlStr:@"http://github.com/billwang1990"];
}

-(void)tearDown
{
    person = nil;
}

-(void)testPersonName
{
    STAssertEqualObjects(person.name, @"billwang", @"person's name should equal with billwang");
}

-(void)testPersonAvatarUrlStr
{
    STAssertEqualObjects(person.avatarUrlStr, @"http://github.com/billwang1990", @"person's avatar url string should equal with given string");
} 
@end
