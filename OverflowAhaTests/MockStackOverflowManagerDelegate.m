//
//  MockStackOverflowDelegate.m
//  OverflowAha
//
//  Created by niko on 13-10-21.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "MockStackOverflowManagerDelegate.h"

@implementation MockStackOverflowManagerDelegate


-(void)fetchingQuestionsFailedWithError:(NSError *)error
{
    self.fetchError = error;
}


- (void)didReceiveQuestions:(NSArray *)questions {
    self.receicedQuestions = questions;
}

@end
