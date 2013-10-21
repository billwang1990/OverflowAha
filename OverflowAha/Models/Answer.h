//
//  Answer.h
//  OverflowAha
//
//  Created by niko on 13-10-19.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Person;

@interface Answer : NSObject

@property (nonatomic) NSString *text;
@property (nonatomic) Person *person;
@property (assign) int score;
@property (nonatomic, getter = isAccepted) BOOL accepted;

-(NSComparisonResult)compare:(Answer*)otherAnswer;


@end
