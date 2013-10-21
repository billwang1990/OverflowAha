//
//  Topic.h
//  OverflowAha
//
//  Created by niko on 13-10-18.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Question;

@interface Topic : NSObject
{
    NSArray *questions;
}

@property (readonly) NSString *name;
@property (readonly) NSString *tag;

-(id)initWithName:(NSString *)name withTag:(NSString*)tag;

-(NSArray*)recentQuestions;
-(void)addQuestion:(Question*)aQuestion;

@end
