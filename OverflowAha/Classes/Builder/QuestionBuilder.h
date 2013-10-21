//
//  QuestionBuilder.h
//  OverflowAha
//
//  Created by niko on 13-10-21.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionBuilder : NSObject

-(NSArray*)questionsFromJSON:(NSString *)objectNotation
                       error:(NSError**)error;

@end
