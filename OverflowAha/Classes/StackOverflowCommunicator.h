//
//  StackOverflowCommunicator.h
//  OverflowAha
//
//  Created by niko on 13-10-21.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StackOverflowCommunicator : NSObject

-(void)searchForQuestionWithTag:(NSString*)tag;

-(void)downloadInformationForQuestionWithID:(NSInteger)indentifier;

@end
