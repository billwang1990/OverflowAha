//
//  MockStackOverflowCommunicator.h
//  OverflowAha
//
//  Created by niko on 13-10-21.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "StackOverflowCommunicator.h"

@interface MockStackOverflowCommunicator : StackOverflowCommunicator

-(BOOL)wasAskedToFetchQuestions;
-(BOOL)wasAskedToFetchBody;

@end
